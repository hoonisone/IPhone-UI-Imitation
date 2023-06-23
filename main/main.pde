
final int IPHONE_NUM = 1;

float pressedX;
float pressedY;

Day DAY;
Palette PALETTE;
New NEW;
Error ERROR;

IPhone[] iphone;
YouOrMe youOrMe;
MainBackButton backButton;

int time_second;
int time_minute;

String mainSituation = "iphone";

void setup()
{
    fullScreen ();
    textAlign(CENTER, CENTER);
    frameRate(100);
  
    DAY = new Day();  // 날짜 클래스 생성
    PALETTE = new Palette();  // 파렛트 클래스 생성
    NEW = new New();
    ERROR = new Error();
  
    iphone = new IPhone[IPHONE_NUM];  // 아이폰 더미 생성
    iphone[0] = new IPhone(); // 아이폰 생성
    youOrMe = new YouOrMe();
    backButton = new MainBackButton(width*98/100, 0, width*2/100);
  
    time_second = 0;  // 시간 변수 초기화
    time_minute = 0;  // 시간 변수 초기화
    
    iphone[0].operater_setup();

}

void draw()
{
    background(PALETTE.BACKGROUND);
    
    if(mousePressed)
        mousePressing();
  
    if (time_second != second()) {
        time_second = second();
        time_second();
    }
  
    if (time_minute != minute()) {
        time_minute = minute();
        time_minute();
    }
    
    ERROR.operater_draw();
    
    
    ///////////////////////////////////////////////
    
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_draw();
        break;
    case "youOrMe":
        youOrMe.operater_draw();
        backButton.sketch();
        break;
    case "tetris":
        tetris_operater_draw();
        backButton.sketch();
        break;
    default:
        break;
    }
    
}

void mouseClicked()
{
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mouseClicked();
        break;
    case "youOrMe":
        youOrMe.operater_mouseClicked();
        break;
    case "tetris":
        tetris_operater_mouseClicked();
        break;
    default:
        break;
    }
    
}

void mouseMoved()
{
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mouseMoved();
        break;
    case "youOrMe":
        youOrMe.operater_mouseMoved();
        break;
    case "tetris":
        //tetris_operater_mouseMoved();
        break;
    default:
        break;
    }
}

void mouseReleased()
{
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mouseReleased();
        break;
    case "youOrMe":
        youOrMe.operater_mouseReleased();
        break;
    case "tetris":
        //tetris_operater_mouseReleased();
        break;
    default:
        break;
    }
    
}

void mouseDragged()
{
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mouseDragged();
        break;
    case "youOrMe":
        youOrMe.operater_mouseDragged();
        break;
    case "tetris":
        //tetris_operater_mouseDragged();
        break;
    default:
        break;
    }
    
}

void mouseWheel(MouseEvent event)
{
  
    float e = event.getCount ();
    
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mouseWheel(e);
        break;
    case "youOrMe":
        youOrMe.operater_mouseWheel(e);
        break;
    case "tetris":
        //tetris_operater_mouseWheel(e);
        break;
    default:
        break;
    }
    
}

void mousePressed()
{
  
    pressedX = mouseX;
    pressedY = mouseY;
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mousePressed();
        ERROR.operater_mousePressed();
        break;
    case "youOrMe":
        youOrMe.operater_mousePressed();
        backButton.operator_mousePressed();
        break;
    case "tetris":
        backButton.operator_mousePressed();
        //tetris_operater_mousePressed();
        break;
    default:
        break;
    }
    
    
}

void mousePressing(){
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_mousePressing();
        break;
    case "youOrMe":
        youOrMe.operater_mousePressing();
        break;
    case "tetris":
        //tetris_operater_mousePressing();
        break;
    default:
        break;
    }
    
}

void keyPressed(){
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_keyPressed();
        break;
    case "youOrMe":
        youOrMe.operater_keyPressed();
        break;
    case "tetris":
        tetris_operater_keyPressed();
        break;
    default:
        break;
    }
   
}

public void time_second() {
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_time_second();
        ERROR.operater_time_second();
        break;
    case "youOrMe":
        youOrMe.operater_time_second();
        break;
    case "tetris":
        //tetris_operater_time_second();
        break;
    default:
        break;
    }
    
}

public void time_minute() {
    switch(mainSituation){
    case "iphone":
        for (int i=0; i<IPHONE_NUM; i++ )
        iphone[i].operater_time_minute();
        break;
    case "youOrMe":
        youOrMe.operater_time_minute();
        break;
    case "tetris":
        //tetris_operater_time_minute();
        break;
    default:
        break;
    }
    
}

class MainBackButton{  // 누루면 아이폰으로 돌아감
    
    float x;
    float y;
    float w;
    float h;
    PImage img;
    
    MainBackButton(float x, float y, float w){
        //img = loadImage("");
        this.x = x;
        this.y = h;
        this.w = w;
        this.h = w;
      
    }
    
    void sketch(){
        if(img == null){
            fill(255);
            stroke(0);
            rect(x, y, w, h);
        }
        else
            image(img, x, y, w, h);
      
    }
    
    boolean isMouseOn(){
        if( x < mouseX && mouseX < x+w ) // 이미지 넣으면 범위 조정
        if( y < mouseY && mouseY < y+h )
            return true;
      
        return false;
    }
    
    void operator_mousePressed(){
        if(isMouseOn()){
            mainSituation = "iphone";

        }

    }
}
