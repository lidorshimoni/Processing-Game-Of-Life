
public void drawCells(Cell[][] cells)
{
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].drawIt();
    }
  }
}


public void updateCells(Cell[][] cells)
{
  boolean[][] lives = new boolean[RES_X][RES_Y];
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      lives[i][j] = checkNeighborhood(cells, i, j);
    }
  }
  for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].setLive(lives[i][j]);
    }
  }
}

public boolean checkNeighborhood(Cell[][] cells, int x, int y)
{
  // 4 teams counter
  int[] counter = new int[PLAYERS+1];
  
  // removes the center cell
  if(cells[x][y].getLive())
    counter[cells[x][y].getTeam()]--;
    
  for(int i = -1 ;i <= 1 ; i++)
  {
    for(int j = -1; j <= 1 ; j++)
    {
      int col = (x + i + RES_X) % RES_X;
      int row = (y + j + RES_Y) % RES_Y;
      //println("cols " + col + " row " + row);
      counter[cells[col][row].getTeam()] += cells[col][row].getLive() ? 1 : 0;
    }
  }
  boolean ret = false;
  for(int i = 0; i<PLAYERS+1 && !ret; i++)
  {
    if(counter[i]<=1 || counter[i]>3)
    {
      ret =  false;
    }
    else if(counter[i]==3)
    {
      ret =  true;
      cells[x][y].setTeam(findBiggestIndex(counter)+1);
    }
    else
    {
      ret =  cells[x][y].getLive();
    }
  }
  return ret;
}

public int findBiggestIndex(int[] arr)
{
  int max = max(arr);
  for(int i = 0; i<arr.length;i++)
    if(arr[i] == max)
      return i;
  return 1;
}

public void userClick(Cell[][] cells, boolean live, int team, int radius)
{
  int x = mouseX/SIZE;
  int y = mouseY/SIZE;
  if (radius == 0)
  {
    cells[x][y].setLive(live);
    cells[x][y].setTeam(team);
  }
  else
  {
    for(int i=-radius;i<radius;i++)
    {
      if(x+i<0 || x+i>=RES_X)
        continue;
      for(int j=-radius;j<radius;j++)
      {
        if(y+j<0 || y+j>=RES_Y)
          continue;
        
        cells[x+i][y+j].setLive(live);
        cells[x+i][y+j].setTeam(team);
      }
    }
  }
}

public void clearScreen(Cell[][] cells)
{
    for(int i = 0;i < RES_X ; i++)
  {
    for(int j = 0; j < RES_Y ; j++)
    {
      cells[i][j].setLive(false);
    }
  }
}

//public void userClick(Cell[][] cells, boolean live, int team, int radius)
//{
//  for(int i = 0; i < RES_X ; i++)
//  {
//    for(int j = 0; j < RES_Y ; j++)
//    {
//      if(cells[i][j].pointInShape(mouseX, mouseY, radius))
//      {
//        cells[i][j].setLive(live);
//        cells[i][j].setTeam(team);
//      }
//    }
//  }
//}
