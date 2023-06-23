/*
0 = Black
1 = Red
2 = Green
3 = Blue
4 = purple
5 = Yellow
6 = Orange
7 = SkyBlue
*/
final int GARO = 10;
final int SERO = 16;
final int BLOCK_SIZE  = 40;
final int BLOCK_THICK = 10;
final float BUTTON_SIZE  = 30;
final float BUTTON_THICK = 10;

PImage ReadyImage;

char Game1 = 'R';
char Game2 = 'R';

int[][] User1, User2;
int[][] CurBlock1,  CurBlock2;
int[][] NextBlock1, NextBlock2;

int CurColor1,    CurColor2;
int CurTurn1,     CurTurn2;
int CurSort1,     CurSort2;
int CurX1,        CurX2 = 4;
int CurY1,        CurY2 = 2;

int NextColor1,   NextColor2;
int NextTurn1,    NextTurn2;
int NextSort1,    NextSort2;

int Score1,       Score2;
int Goal1,        Goal2;
int Level1,       Level2;

int Second,       Minute,        Hour,          Time;     
int TimeInit,     TimeInit1,     TimeInit2;
int GameTime,     GameTime1,     GameTime2;
int ATimer,       BTimer,        CTimer;
int Counter1,     Counter2;
int CounterSize1, CounterSize2;
int[] Rank;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
boolean CounterOn1,  CounterOn2;
boolean NewBlockOn1, NewBlockOn2;
boolean LevelUp1,    LevelUp2;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void tetris_operater_setup()
{
    GameTime1    = 0;
    GameTime2    = 0;
    CounterSize1 = 0;
    CounterSize1 = 0;
    Counter1     = 0;
    Counter2     = 0;
    ReadyImage   = loadImage("TetrisLogo.png");
    Goal1        = Goal2      = 3;
    Level1       = Level2     = 1;
    User1        = new int[GARO][SERO+5];
    User2        = new int[GARO][SERO+5];
    CurBlock1    = new int[4][4];
    CurBlock2    = new int[4][4];
    NextBlock1   = new int[4][4];
    NextBlock2   = new int[4][4];
    Rank         = new int[6];
    
    for( int i=0 ; i<GARO ; i++ )
    for( int j=0 ; j<SERO+5 ; j++ ){
        User1[i][j] = 0;
        User2[i][j] = 0;
    }
        
    textAlign(CENTER,CENTER);
    //size(1320, 960);    //BLOCK_SIZE*33, BLOCK_SIZE*24
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void tetris_operater_draw()
{
    TimeSet();
    
    background(0);
    if(Game1 == 'R')      DrawReady();
    if(Game2 == 'R')      DrawReady();
    if(Game1 == 'S')      DrawGame1();
    if(Game2 == 'S')      DrawGame2();
    if(Game1 == 'E')      DrawEnding1();
    if(Game2 == 'E')      DrawEnding2();
       
    if(CounterOn1){
        StartCounter(1);
    }
    if(CounterOn2){
        StartCounter(2);
    }
    
    BlockGuideLine(1);
    BlockGuideLine(2);
    RemoveBlock(1);
    RemoveBlock(2);
    IsEnd(1);
    IsEnd(2);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawReady()
{
    image(ReadyImage,0,0, width, height);
    fill(0,0,255);
    rect(width/2-BUTTON_SIZE*7/2-BUTTON_THICK, height/2-BUTTON_SIZE*3/2-BUTTON_THICK, BUTTON_SIZE*7+BUTTON_THICK*2, BUTTON_SIZE*3+BUTTON_THICK*2);
    noStroke();
    fill(255,0,0);
        if( width/2-BUTTON_SIZE*7/2<mouseX && mouseX<width/2+BUTTON_SIZE*7/2)
            if(height/2-BUTTON_SIZE*3/2<mouseY && mouseY<height/2+BUTTON_SIZE*3/2)
                fill(0,255,0);    
    rect(width/2-BUTTON_SIZE*7/2, height/2-BUTTON_SIZE*3/2, BUTTON_SIZE*7, BUTTON_SIZE*3);
    fill(255);
    textSize(36);
    text("Game Start",width/2, height/2);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawGame1()
{
    noStroke();
    fill(150,0,0);
    rect(BLOCK_SIZE*2-BLOCK_THICK*2, BLOCK_SIZE*3-BLOCK_THICK, BLOCK_SIZE*(GARO+4)+BLOCK_THICK*2, BLOCK_SIZE*16+BLOCK_THICK*2);
    fill(0);
    rect(BLOCK_SIZE*2, BLOCK_SIZE*4,BLOCK_SIZE*3,BLOCK_SIZE*3);
    
    DrawBlock(1);
    DrawNextBlock(1);
    DrawCurBlock(1);
    PrintInformation(1);
    
    if(NewBlockOn1){
        SetCurBlock(1);
        SetNextBlock(1);
        NewBlockOn1 = false;
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawGame2()
{
    noStroke();
    fill(0,0,150);
    rect(BLOCK_SIZE*17, BLOCK_SIZE*3-BLOCK_THICK, BLOCK_SIZE*(GARO+4)+BLOCK_THICK*2, BLOCK_SIZE*16+BLOCK_THICK*2);
    fill(0);
    rect(width-BLOCK_SIZE*5, BLOCK_SIZE*4,BLOCK_SIZE*3,BLOCK_SIZE*3);
    
    DrawBlock(2);
    DrawNextBlock(2);
    DrawCurBlock(2);
    PrintInformation(2);
    
    if(NewBlockOn2){
        SetCurBlock(2);
        SetNextBlock(2);
        NewBlockOn2 = false;
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawEnding1()
{
    noStroke();
    fill(150,0,0);
    rect(BLOCK_SIZE*2-BLOCK_THICK*2, BLOCK_SIZE*3-BLOCK_THICK, BLOCK_SIZE*(GARO+4)+BLOCK_THICK*2, BLOCK_SIZE*16+BLOCK_THICK*2);
    fill(0);
    rect(BLOCK_SIZE*2, BLOCK_SIZE*4,BLOCK_SIZE*3,BLOCK_SIZE*3);
    
    PrintInformation(1);
    PrintRank(1);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawEnding2()
{
    noStroke();
    fill(0,0,150);
    rect(BLOCK_SIZE*17, BLOCK_SIZE*3-BLOCK_THICK, BLOCK_SIZE*(GARO+4)+BLOCK_THICK*2, BLOCK_SIZE*16+BLOCK_THICK*2);
    fill(0);
    rect(BLOCK_SIZE*28, BLOCK_SIZE*4,BLOCK_SIZE*3,BLOCK_SIZE*3);
    
    PrintInformation(2);
    PrintRank(2);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawBlock(int User)
{
    if(User == 1)
        for(int i=1 ; i<=GARO ; i++ )
        for(int j=1 ; j<=SERO ; j++ )
        {
            ColorSeting(User1[i-1][j+4]);
            stroke(0);
            rect(BLOCK_SIZE*(i+5)-BLOCK_THICK, BLOCK_SIZE*(j+2), BLOCK_SIZE, BLOCK_SIZE);
        }
    else if(User == 2)
        for(int i=1 ; i<=GARO ; i++ )
        for(int j=1 ; j<=SERO ; j++ )
        {
            ColorSeting(User2[i-1][j+4]);
            stroke(0);
            rect(BLOCK_SIZE*(i+16)+BLOCK_THICK, BLOCK_SIZE*(j+2), BLOCK_SIZE, BLOCK_SIZE);
        }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawCurBlock(int User)
{
    if(User == 1)
      for(int i=1 ; i<=4 ; i++ )
      for(int j=1 ; j<=4 ; j++ )
      {
          ColorSeting(CurBlock1[i-1][j-1]);
          stroke(0);
          if(CurBlock1[i-1][j-1] != 0)
              rect(BLOCK_SIZE*(CurX1+i+5)-BLOCK_THICK, BLOCK_SIZE*(CurY1+j-3), BLOCK_SIZE, BLOCK_SIZE);
      }
    else if(User == 2)
        for(int i=1 ; i<=4 ; i++ )
        for(int j=1 ; j<=4 ; j++ )
        {
            ColorSeting(CurBlock2[i-1][j-1]);
            stroke(0);
            if(CurBlock2[i-1][j-1] != 0)
            rect(BLOCK_SIZE*(CurX2+i+16)+BLOCK_THICK, BLOCK_SIZE*(CurY2+j-3), BLOCK_SIZE, BLOCK_SIZE);
        }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DrawNextBlock(int User)
{
    if(User == 1)
        for(int i=1 ; i<=4 ; i++ )
        for(int j=1 ; j<=4 ; j++ )
        {
            ColorSeting(NextBlock1[i-1][j-1]);
            stroke(0);
            rect(BLOCK_SIZE*3/4*(i-1)+BLOCK_SIZE*2, BLOCK_SIZE*3/4*(j-1)+BLOCK_SIZE*4, BLOCK_SIZE*3/4, BLOCK_SIZE*3/4);
        }
    else if(User == 2)
        for(int i=1 ; i<=4 ; i++ )
        for(int j=1 ; j<=4 ; j++ )
           {
                ColorSeting(NextBlock2[i-1][j-1]);
                stroke(0);
                rect(BLOCK_SIZE*28+BLOCK_SIZE*3/4*(i-1), BLOCK_SIZE*3/4*(j-1)+BLOCK_SIZE*4, BLOCK_SIZE*3/4, BLOCK_SIZE*3/4);
            }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void PrintInformation(int User)
{
    if(User == 1)
    {
        textSize(50);
        fill(255,0,0);
        if(Score1 > Score2)
            fill(255,255,0);
        text("User1",BLOCK_SIZE*8,BLOCK_SIZE*3/2);
        fill(255,0,0);
        textSize(40);
        textAlign(LEFT,CENTER);
        text("Score:", BLOCK_SIZE*4, BLOCK_SIZE*20);
        text(Score1, BLOCK_SIZE*7, BLOCK_SIZE*20);
        text("Goal:", BLOCK_SIZE*4, BLOCK_SIZE*21);
        text(Goal1, BLOCK_SIZE*7, BLOCK_SIZE*21);
        if(LevelUp1)
            fill(255,255,0);
        text("Level:", BLOCK_SIZE*4, BLOCK_SIZE*22);
        text(Level1, BLOCK_SIZE*7, BLOCK_SIZE*22);
        textAlign(CENTER,CENTER);
    }
    else if(User == 2)
    {
        textSize(50);
        fill(0,0,255);
        if(Score1 < Score2)
            fill(255,255,0);
        text("User2",width-BLOCK_SIZE*8,BLOCK_SIZE*3/2);
        fill(0,0,255);
        textSize(40);
        textAlign(LEFT,CENTER);
        text("Score:", width-BLOCK_SIZE*13, BLOCK_SIZE*20);
        text(Score2, width-BLOCK_SIZE*10, BLOCK_SIZE*20);
        text("Goal:", width-BLOCK_SIZE*13, BLOCK_SIZE*21);
        text(Goal2, width-BLOCK_SIZE*10, BLOCK_SIZE*21);
        if(LevelUp2)
            fill(255,255,0);
        text("Level:", width-BLOCK_SIZE*13, BLOCK_SIZE*22);
        text(Level2, width-BLOCK_SIZE*10, BLOCK_SIZE*22);
        textAlign(CENTER,CENTER);
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void PrintRank(int User)
{
    if(User == 1){
        fill(0);
        rect(BLOCK_SIZE*6-BLOCK_THICK, BLOCK_SIZE*3, BLOCK_SIZE*GARO, BLOCK_SIZE*SERO);
        textAlign(CENTER,CENTER);
        textSize(50);
        fill(255);
        text("SCORE :",BLOCK_SIZE*9,BLOCK_SIZE*5);
        text(Score1,BLOCK_SIZE*13,BLOCK_SIZE*5);
        text("LEVEL :",BLOCK_SIZE*9,BLOCK_SIZE*7);
        text(Level1,BLOCK_SIZE*13,BLOCK_SIZE*7);
        text("TIME  :",BLOCK_SIZE*9,BLOCK_SIZE*9);
        text(GameTime1,BLOCK_SIZE*13,BLOCK_SIZE*9);
        textSize(40);
        for(int i=0 ; i<5 ; i++ ){
            fill(255);
            if(Score1 == Rank[i])
                fill(255, 255, 0);
            text("RANK  :",BLOCK_SIZE*9,BLOCK_SIZE*(11+i));
            text(i+1,BLOCK_SIZE*(10+1/2),BLOCK_SIZE*(11+i));
            text(Rank[i],BLOCK_SIZE*12,BLOCK_SIZE*(11+i));
        }
    }
    else if(User == 2){
        fill(0);
        rect(BLOCK_SIZE*17+BLOCK_THICK, BLOCK_SIZE*3, BLOCK_SIZE*GARO, BLOCK_SIZE*SERO);
        textAlign(CENTER,CENTER);
        textSize(50);
        fill(255);
        text("SCORE :",BLOCK_SIZE*20,BLOCK_SIZE*5);
        text(Score2,BLOCK_SIZE*24,BLOCK_SIZE*5);
        text("LEVEL :",BLOCK_SIZE*20,BLOCK_SIZE*7);
        text(Level2,BLOCK_SIZE*24,BLOCK_SIZE*7);
        text("TIME  :",BLOCK_SIZE*20,BLOCK_SIZE*9);
        text(GameTime2,BLOCK_SIZE*24,BLOCK_SIZE*9);
        textSize(40);
        for(int i=0 ; i<5 ; i++ ){
            fill(255);
            if(Score2 == Rank[i])
                fill(255, 255, 0);
            text("RANK  :",BLOCK_SIZE*20,BLOCK_SIZE*(11+i));
            text(i+1,BLOCK_SIZE*(21+1/2),BLOCK_SIZE*(11+i));
            text(Rank[i],BLOCK_SIZE*23,BLOCK_SIZE*(11+i));
        }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void ColorSeting(int Color)
{
    if(Color == 0)
        fill(0);
    if(Color == 1)
        fill(255,0,0);
    if(Color == 2)
        fill(0,255,0);     
    if(Color == 3)
        fill(0,255,0);
    if(Color == 4)
        fill(0,0,255);
    if(Color == 5)
        fill(255,255,0);
    if(Color == 6)
        fill(255,150,0);
    if(Color == 7)
        fill(0,255,255);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void TimeSet()
{
    GameTime++;
    if(GameTime%(30/Level1) == 1){
        CurY1 += 1;
        BlockGuideLine(1);
    }
    if(GameTime%(30/Level2) == 1){
        CurY2 += 1;
        BlockGuideLine(2);
    }
    
    Second = second();
    Minute = minute();
    Hour = hour();
    Time = Hour*3600 + 60*Minute + Second - TimeInit;
    if(CounterOn1 && Time%TimeInit1 == 5-Counter1){
        Counter1 -=1;
        CounterSize1 = 0;
        if(Counter1==0){
            CounterOn1 = false;
            NewBlockOn1 = true;
        }
    }
    if(CounterOn2 && Time%TimeInit2 == 5-Counter2){  
        Counter2 -=1;
        CounterSize2 = 0;
        if(Counter2==0){
            CounterOn2 = false;
            NewBlockOn2 = true;
        }
    }
    
    BTimer = Time;
    if(BTimer == ATimer){
        ATimer++;
        Time();
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void Time()
{
    CTimer++;
    if(CTimer%3 == 0){
        LevelUp1 = false;
        LevelUp2 = false;
    }
    if(Game1 == 'S')
        GameTime1++;
    if(Game2 == 'S')
        GameTime2++;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void StartCounter(int User)
{
    if(User == 1){
        CounterSize1 += 7;
        textSize(CounterSize1);
        textAlign(CENTER,CENTER);
        if(CounterSize1 >= 300)
            textSize(300);
        fill(255);
        text(Counter1, BLOCK_SIZE*11, BLOCK_SIZE*10);
    }
    else if(User == 2){
        CounterSize2 += 7;
        textSize(CounterSize2);
        textAlign(CENTER,CENTER);
        if(CounterSize2 >= 300)
            textSize(300);
        fill(255);
        text(Counter2, BLOCK_SIZE*23, BLOCK_SIZE*10);
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void BlockSeting(int[][] arr, int Sort, int Color, int Turn)
{
    for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            arr[i][j] = 0;

    if(Sort == 1){
        if(Turn%2+1 == 1){
            arr[2][0] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
            arr[2][3] = Color;
        }
        else if(Turn%2+1 == 2){
            arr[0][2] = Color;
            arr[1][2] = Color;
            arr[2][2] = Color;
            arr[3][2] = Color;
        }
    }
    else if(Sort == 2){
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
    }
    else if(Sort == 3){
        if(Turn%4+1 == 1){
            arr[1][1] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
            arr[2][3] = Color;
        }
        else if(Turn%4+1 == 2){
            arr[0][2] = Color;
            arr[1][2] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
        }
        else if(Turn%4+1 == 3){
            arr[1][0] = Color;
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[2][2] = Color;
        }
        else if(Turn%4+1 == 4){
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[2][1] = Color;
            arr[3][1] = Color;
        }  
    }
    else if(Sort == 4){
        if(Turn%4+1 == 1){
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[1][3] = Color;
            arr[2][1] = Color;
        }
        else if(Turn%4+1 == 2){
            arr[0][1] = Color;
            arr[1][1] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
        }
        else if(Turn%4+1 == 3){
            arr[1][2] = Color;
            arr[2][0] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
        }
        else if(Turn%4+1 == 4){
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[2][2] = Color;
            arr[3][2] = Color;
        }
    }
    else if(Sort == 5){
        if(Turn%4+1 == 1){
            arr[1][1] = Color;
            arr[2][0] = Color;
            arr[2][1] = Color;
            arr[3][1] = Color;
        }
        else if(Turn%4+1 == 2){
            arr[2][0] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
            arr[3][1] = Color;
        }
        else if(Turn%4+1 == 3){
            arr[1][1] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
            arr[3][1] = Color;
        }
        else if(Turn%4+1 == 4){
            arr[1][1] = Color;
            arr[2][0] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
        }
    }
    if(Sort == 6){
        if(Turn%2+1 == 1){
            arr[0][1] = Color;
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[2][2] = Color;
        }
        else if(Turn%2+1 == 2){
            arr[1][2] = Color;
            arr[1][3] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
        }
    }
    if(Sort == 7){
        if(Turn%2+1 == 1){
            arr[1][2] = Color;
            arr[2][1] = Color;
            arr[2][2] = Color;
            arr[3][1] = Color;
        }
        else if(Turn%2+1 == 2){
            arr[1][1] = Color;
            arr[1][2] = Color;
            arr[2][2] = Color;
            arr[2][3] = Color;
        }
    }        
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SetCurBlock(int User)
{
    if(User == 1){
        CurX1     = CurY1 = 4;
        CurColor1 = NextColor1;
        CurTurn1  = NextTurn1;
        CurSort1  = NextSort1;
        BlockSeting(CurBlock1, CurSort1, CurColor1, CurTurn1);
    }
    else if(User == 2){
        CurX2     = CurY2 = 4;
        CurColor2 = NextColor2;
        CurTurn2  = NextTurn2;
        CurSort2  = NextSort2;
        BlockSeting(CurBlock2, CurSort2, CurColor2, CurTurn2);
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SetNextBlock(int User)
{
    int random;
    
    if(User == 1){
        random     = (int)random(0,1000);
        NextColor1 = (int)(random%7+1);
        NextTurn1  = (int)(random%4+1);
        NextSort1  = (int)(random%7+1);
        BlockSeting(NextBlock1, NextSort1, NextColor1, NextTurn1);
    }
    else if(User == 2){
        random     = (int)random(0,1000);
        NextColor2 = (int)random%7+1;
        NextTurn2  = (int)random%4+1;
        NextSort2  = (int)random%7+1;
        BlockSeting(NextBlock2, NextSort2, NextColor2, NextTurn2);
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void tetris_operater_keyPressed()
{
    if(key == 'w'){
        CurTurn1 += 1;
        BlockSeting(CurBlock1, CurSort1, CurColor1, CurTurn1);    ///////////////turn - olu   && UP
    }
    else if(key == 'a'){
        CurX1 -= 1;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock1[i][j] != 0){
                if(CurX1+i<0)
                    CurX1 = -i;
                else if(User1[CurX1+i][CurY1+j] != 0){
                    CurX1 +=1;
                    return;
                }
            }
    }   
    else if(key == 's'){
        CurY1 += 1;
        BlockGuideLine(1);
    }
    else if(key == 'd'){
        CurX1 += 1;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock1[i][j] != 0){
                if(CurX1+i>9)
                    CurX1 = 9-i;
                else if(User1[CurX1+i][CurY1+j] != 0){
                    CurX1 -=1;
                    return;
                }
            }
    }
    else if(key == 'n')/////////////////////////////////////////////////////////////////////
    {
        if(Game1 == 'S' && !CounterOn1){
            CurY1 += 1;
            while(!BlockGuideLine(1))
                CurY1 += 1;
        }
    }
    else if(keyCode == UP){
        CurTurn2 += 1;
        BlockSeting(CurBlock2, CurSort2, CurColor2, CurTurn2);
    }
    else if(keyCode == LEFT){
        CurX2 -= 1;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock2[i][j] != 0){
                if(CurX2+i<0)
                    CurX2 = -i;
                else if(User2[CurX2+i][CurY2+j] != 0){
                    CurX2 +=1;
                    return;
                }
            }
    }
    else if(keyCode == DOWN){
        CurY2 += 1;   
        BlockGuideLine(2);
    }
    else if(keyCode == RIGHT){
        CurX2 += 1;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock2[i][j] != 0){
                if(CurX2+i>9)
                    CurX2 = 9-i;
                else if(User2[CurX2+i][CurY2+j] != 0){
                    CurX2 -=1;
                    return;
                }
            }
    }
        else if(key == 'm' && !CounterOn2)/////////////////////////////////////////////////////////////////////
    {
        if(Game2 == 'S'){
            CurY2 += 1;
            while(!BlockGuideLine(2))
                CurY2 += 2;
        }
    }
    else if(key == 'r'){
        if(Game1 != 'S')
            ReGameInit(1);
        if(Game2 != 'S')
            ReGameInit(2);
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
boolean BlockGuideLine(int User)
{
    if(User == 1){
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock1[i][j] != 0){   
                if(CurX1+i<0)
                    CurX1 = -i;
                else if(CurX1+i>9)
                    CurX1 = 9-i;
                else if(CurY1+j>20){
                    NextBlock(1);
                    return true;
                }
                else if(User1[CurX1+i][CurY1+j] != 0 ){
                    NextBlock(1);
                    return true;
                }
            }
        return false;
    }
    else if(User == 2){
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock2[i][j] != 0){    
                if(CurX2+i<0)
                    CurX2 = -i;
                else if(CurX2+i>9)
                    CurX2 = 9-i;
                else if(CurY2+j>20){
                    NextBlock(2);
                    return true;
                }
                else if(User2[CurX2+i][CurY2+j] != 0 ){
                    NextBlock(2);
                    return true;
                }
            }
        return false;
    }
    return false;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void NextBlock(int User)
{
    if(User == 1){
        IsEnd(1);
        if(Game1 == 'E')
            return;
        CurY1 -= 1;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock1[i][j] != 0)
                User1[CurX1+i][CurY1+j] = CurColor1;
        NewBlockOn1 = true;
        Score1 += Level1*5;
    }
    else if(User == 2){
        IsEnd(2);
        if(Game2 == 'E')
            return;
        CurY2 -= 1;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ )
            if(CurBlock2[i][j] != 0)
                User2[CurX2+i][CurY2+j] = CurColor2;
        NewBlockOn2 = true;
        Score2 += Level2*5;
    }    
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void IsEnd(int User)
{
    if(User == 1){
        for(int i=0 ; i<GARO ; i++  ){
            if(User1[i][3] != 0){
                if(Game1 != 'E'){
                    SetRank(1);
                    Game1 = 'E';
                    return;
                  }
            }
        }
    }
    else if(User == 2){
        for(int i=0 ; i<GARO ; i++ ){
            if(User2[i][3] != 0){
                if(Game2 != 'E'){
                    SetRank(2);
                    Game2 = 'E';
                    return;
                }
            }
        }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void RemoveBlock(int User)
{
    int i;
    if(User == 1)
        for( i=20 ; i>=0 ; i-- )
            IsLinePull(1, i);
    else if(User == 2)
        for( i=20 ; i>=0 ; i-- )
            IsLinePull(2, i);
}      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void IsLinePull(int User, int RLine)
{
    if(User == 1){
            for(int i=0 ; i<GARO ; i++ ){
                if(User1[i][RLine] == 0)
                    return;
            }
            EraseLine(1,RLine);
            Goal1 -= 1;
            if(Goal1 == 0){
                for(int i=21 ; i>1 ; i--)
                    EraseLine(1,RLine);
                Level1 += 1;
                Goal1 = Level1+3;
                Score1 *= 2;
                LevelUp1 = true;
            }
    }
    else if(User == 2){
            for(int i=0 ; i<GARO ; i++ ){
                if(User2[i][RLine] == 0)
                    return;
            }
            EraseLine(2,RLine);
            Goal2 -= 1;
            if(Goal2 == 0){
                  for(int i=20 ; i>1 ; i--)
                      EraseLine(2,RLine);
                Level2 += 1;
                Goal2 = Level2+3;
                Score2 *= 2;
                LevelUp2 = true;
            }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void EraseLine(int User, int RLine)
{
    if(User == 1)
    for(int i=RLine ; i>=1 ; i--)
    for(int j=0 ; j<GARO ; j++ )
        User1[j][i] = User1[j][i-1];
    else if(User == 2)
        for(int i=RLine ; i>=1 ; i--)
        for(int j=0 ; j<GARO ; j++ )
            User2[j][i] = User2[j][i-1];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SetRank(int User)
{
    int temp;
    if(User == 1)
        Rank[5] = Score1;
    else if(User ==2)
        Rank[5] = Score2;
    for(int i=5 ; i>0 ; i-- )
        if(Rank[i]>Rank[i-1]){
            temp = Rank[i-1];
            Rank[i-1] = Rank[i];
            Rank[i] = temp;
        }
        else
            return;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void ReGameInit(int User)
{
    if(User == 1){
        for(int i=0 ; i<10 ; i++ )
        for(int j=0 ; j<21 ; j++ )
            User1[i][j] = 0;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ ){
            CurBlock1[i][j] = 0;
            NextBlock1[i][j] = 0;
        }
        CurX1 = 4;
        CurY1 = 2;
        Score1 = 0;
        Level1 = 1;
        Game1 = 'S';
        TimeInit1 = Time;
        GameTime1 = 0;
        CounterOn1 = true;
        NewBlockOn1 =false;
        Counter1 = 3;
    }
    else if(User == 2){
        for(int i=0 ; i<10 ; i++ )
        for(int j=0 ; j<21 ; j++ )
            User2[i][j] = 0;
        for(int i=0 ; i<4 ; i++ )
        for(int j=0 ; j<4 ; j++ ){
            CurBlock2[i][j] = 0;
            NextBlock2[i][j] = 0;
        }
        CurX2 = 4;
        CurY2 = 2;
        Score2 = 0;
        Level2 = 1;
        Game2 = 'S';
        TimeInit2 = Time;
        GameTime2 = 0;
        CounterOn2 = true;
        NewBlockOn2 = false;
        Counter2 = 3;
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void tetris_operater_mouseClicked()
{
    if(Game1 == 'R' && Game2 == 'R')
        if( width/2-BUTTON_SIZE*7/2<mouseX && mouseX<width/2+BUTTON_SIZE*7/2)
            if(height/2-BUTTON_SIZE*3/2<mouseY && mouseY<height/2+BUTTON_SIZE*3/2){
                TimeSet();
                TimeInit  = Time;
                TimeInit1 = Time;
                TimeInit2 = Time;
                SetNextBlock(1);
                SetNextBlock(2);
                Game1 = 'S';
                Game2 = 'S';
                CounterOn1 = true;
                CounterOn2 = true;
                Counter1 = 3;
                Counter2 = 3;
            }
}
