public class Content{
    
    public final int SCREEN_NUM = 4;  //팝업창 포함
    public Display display;
    public LeftScreen leftScreen;
    public MainScreen[] mainScreen;
    public BottomScreen bottomScreen;
    public App controllingApp = null;
    public int curScreen = 1;
  
    public float x, y, w, h;
    
    public App pressedApp = null;
    
    public String situation = "stop";
    public boolean isConstructing = false; 
    
  
    public Content(Display display) {
        this.display = display;
        leftScreen = new LeftScreen(this);
        mainScreen = new MainScreen[SCREEN_NUM-1];
        for( int i=1 ; i< SCREEN_NUM ; i++){
            mainScreen[i-1] = new MainScreen(this, i);
        }
        bottomScreen = new BottomScreen(this);
            /*
        for(int i=0 ; i<30 ; i++)
            insertApp(loadImage("beach.jpg"), "beach");
        for(int i=0 ; i<4 ; i++)
            bottomScreen.insertApp(loadImage("beach.jpg"), str(i));
            */
        insertApp(loadImage("Lolo_icon.png"), "Lolo");
        insertApp(loadImage("Naver_icon.png"), "Naver");
        insertApp(loadImage("Facebook_icon.png"), "FaceBook");
        insertApp(loadImage("NaverWebtoon_icon.png"), "Naver\nWebtoon");
        insertApp(loadImage("Cloud_icon.png"), "Cloud");
        insertApp(loadImage("Youtube_icon.png"), "YouTube");
        insertApp(loadImage("TetrisLogo.png"), "Tetris");
        insertApp(loadImage("mainScreen.PNG"), "YouOrMe");
        //insertApp(loadImage(""), "");
        //insertApp(loadImage(""), "");
        //insertApp(loadImage(""), "");
        //insertApp(loadImage(""), "");
    }
    
    public void set_situation(String situation){this.situation = situation;}
    public String get_situation(){return situation;}
    public void set_isConstructing(boolean isConstructing){this.isConstructing = isConstructing;}
    
    
  
    public void adjust(){
        switch(situation){
        case "stop":
            this.x = display.x-display.w*curScreen;
            this.y = display.y;
            this.w = display.w;
            this.h = display.h;
            break;
        default:
            this.y = display.y;
            this.w = display.w;
            this.h = display.h;
            break;
        }

            
        leftScreen.adjust(x, y, w, h);
        for(MainScreen as : mainScreen){
            as.adjust(x, y, w, h);
        }
        bottomScreen.adjust(x, y, w, h);
    }
    
    public void shaking(){
        for(int i=0 ; i<SCREEN_NUM-1 ; i++)
          for(int j=0 ; j<mainScreen[i].appNum ; j++)
              mainScreen[i].app[j].set_rotate(sin(millis()/50+j*10)*4);
        for(int j=0 ; j<bottomScreen.appNum ; j++)
            bottomScreen.app[j].set_rotate(sin(millis()/50+j*10)*4);
    }
    
    public void stop_shaking(){
        for(int i=0 ; i<SCREEN_NUM-1 ; i++)
            for(int j=0 ; j<mainScreen[i].appNum ; j++)
                mainScreen[i].app[j].set_rotate(0);
        for(int j=0 ; j<bottomScreen.appNum ; j++)
            bottomScreen.app[j].set_rotate(0);
    }
    
    public void goHome(){
        if(isConstructing)
            set_isConstructing(false);
        stop_shaking();
        curScreen = 1;
        set_situation("adjusting");
    }
    
    public boolean isMouseOnApp(){
        if(curScreen == 0)
            return false;
        return mainScreen[curScreen-1].isMouseOnApp() || bottomScreen.isMouseOnApp();
    }
    
    public boolean isPressedOnApp(){
        Point pressedPoint = new Point(display.pressedX, display.pressedY);
        if(curScreen == 0)
            return false;
        return mainScreen[curScreen-1].isPointOnApp(pressedPoint) || bottomScreen.isPointOnApp(pressedPoint);
    }

    public void sketch(){
        
        if(situation == "stop"){
            if(isConstructing)
                shaking();
            adjust_screen(curScreen+0);
            sketch_screen(curScreen+0);
        }else{
            if(situation == "adjusting"){
                float there = display.x-w*(curScreen);
                if(x != there){
                        x += (there-x)/abs(there-x)*w/10;
                    if(abs(there-x)<w/100*6){
                        x = there; 
                        set_situation("stop");
                    }
                }else{
                    x = there; 
                    set_situation("stop");
                }
            }

            for(int i=curScreen-1 ; i<=curScreen+1 ; i++){
                adjust_screen(i);
                sketch_screen(i);
            }
        }

        bottomScreen.adjust(x, y, w, h);
        if(curScreen != 0)
                bottomScreen.sketch();
                
        sketch_index();
        
        if(isConstructing)
            if(controllingApp != null)
                controllingApp.sketch();
                
    }
    
    public boolean insertApp(PImage img, String name){
        for( int i=0 ; i<SCREEN_NUM-1 ; i++)
            if(mainScreen[i].insertApp(img, name))
                return true;
         return false;
    }
    
    void sketch_index()
    {
        for( int i=0 ; i<SCREEN_NUM ; i++ ){
            PALETTE.setting_pen(false, true, PALETTE.WHITE, PALETTE.WHITE, 1);
            if(i == curScreen)
                PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.WHITE, 1);
            float x = mainScreen[0].x+w/2+w/200*5+w/100*5*(i-1.0*SCREEN_NUM/2);
            if(x<display.x +w/2+w/200*5+w/100*5*(i-1.0*SCREEN_NUM/2))
                x = display.x+w/2+w/200*5+w/100*5*(i-1.0*SCREEN_NUM/2);
            ellipse(x, y+h/100*86, w/200*5, w/200*5);
        }
    }
    
    public void sketch_screen(int screenNum) {
        if(screenNum < 0 || SCREEN_NUM-1 < screenNum )
            return;
        if(screenNum == 0){
            leftScreen.sketch();
        }
        else{
            mainScreen[screenNum-1].sketch();
        }

    }
    
    public void adjust_screen(int screenNum){
        if(screenNum < 0 || SCREEN_NUM-1 < screenNum )
            return;
        if(screenNum == 0){
            leftScreen.adjust(x, y, w, h);
        }
        else{
            mainScreen[screenNum-1].adjust(x, y, w, h);
        }
    }
    
    public void move(String direction){
        
        switch(direction){
        case "left":
            if(curScreen > 0)
                curScreen--;
            break;
        case "right":
            if(curScreen < SCREEN_NUM-1)
                curScreen++;
            break;
        }
    }
    
    public void dropApp(){
        controllingApp = pressedApp;
        if(mainScreen[curScreen-1].deleteApp(pressedApp) == false)
            bottomScreen.deleteApp(pressedApp);
        controllingApp.set_situation("controlling");
    }
    
    public void putApp(){
        int idx1 = mainScreen[curScreen-1].search_insertIdx();
        
        if(bottomScreen.appNum == 4)
            mainScreen[curScreen-1].insertApp(controllingApp, idx1);
        else{
            int idx2 = bottomScreen.search_insertIdx();
            
            float x1 = mainScreen[curScreen-1].x + w/170*13 + w/170*39*(idx1%4);
            float y1 = mainScreen[curScreen-1].y + h/250*14 + h/500*75*(idx1/4);
            
            float x2 = bottomScreen.x + w/170*13 + w/170*39*(idx2%4);
            float y2 = bottomScreen.y + h/250*25;
            
            float dist1 = dist(mouseX, mouseY, x1, y1);
            float dist2 = dist(mouseX, mouseY, x2, y2);
            
            if(dist1 > dist2)
                bottomScreen.insertApp(controllingApp, idx2);
            else
                mainScreen[curScreen-1].insertApp(controllingApp, idx1);
        }
        
        controllingApp = null;
    }
    
    public void controller_mousePressed(){
        if(display.isMouseOn())
            if(isConstructing)
                if(isMouseOnApp())
                    dropApp();    // 디스플레이 안에서 어플을 눌렀을 때 실행
    }
    
    public void controller_mousePressing(){
        if(display.isMouseOn()){
            if(situation == "stop")
                if(isPressedOnApp())
                    if(display.get_pressedTime() > 600)
                        set_isConstructing(true);
        }
    }

    public void controller_mouseDragged(){
        if(display.isMouseOn()){
            if(situation == "controlling"){
                if( x < display.x-display.w*(SCREEN_NUM-1) || display.x < x)
                    x += (mouseX-pmouseX)/2;
                else
                    x += mouseX-pmouseX;
            }else{
                if(controllingApp == null){
                    if(dist(mouseX, mouseY, pressedX, pressedY)>w/30){
                        set_situation("controlling");
                    }
                }
            }
        }
        else{
            if(situation == "controlling"){
                if(mouseX < display.x)
                    move("right");
                else if(mouseX > display.x+display.w)
                    move("left");
                else{
                    if(display.get_pressedTime() < 300){
                        if(mouseX - display.pressedX < 0)
                            move("right");
                        else if(mouseX - display.pressedX > 0)
                            move("left");
                    }else{
                        if(mouseX - display.pressedX < -display.w/4)
                            move("right");
                        else if(mouseX - display.pressedX > display.w/4)
                            move("left");
                    }
                }
                set_situation("adjusting");
            }
            else{
                if(controllingApp != null)
                    putApp();
            }
        }

    }
    
    public void controller_mouseReleased(){
        if(situation == "controlling"){
            if(display.get_pressedTime()< 300){
                if(mouseX - display.pressedX < 0)
                    move("right");
                else if(mouseX - display.pressedX > 0)
                    move("left");
            }else{
                if(mouseX - display.pressedX < -display.w/4)
                    move("right");
                else if(mouseX - display.pressedX > display.w/4)
                    move("left");
            }
            set_situation("adjusting");
        }
        else if(situation == "stop")
            if(display.isMouseOn())
                if(isMouseOnApp())
                    if(!isConstructing)
                        pressedApp.implement();
        
        if(isConstructing)
            if(display.isMouseOn())
                if(controllingApp != null)
                    putApp();
    }

}

public class LeftScreen{

    public Content content;
    int screenNum = 0;
    float x, y, w, h;
    public LeftScreen(Content content){
        this.content = content;
    }
    
    public void adjust(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    public void sketch(){
        sketch_darkCover(20, 1);
    
    }
    
    void sketch_darkCover(float transparency, float range){
        color c = color(0, 0, 0, transparency);
        PALETTE.setting_pen(true, false, c, PALETTE.BLACK, 1);
        rect(x, y, w, h*range);
    }
}

public class BottomScreen{

    public Content content;
    App[] app;
    float x, y, w, h;
    int appNum = 0;
    
    public boolean isAppMove = false;
    public int appMovingFirst;
    public int appMovingLast;
    public String appMovingDirection = null;
    
    public BottomScreen(Content content){
        this.content = content;
        app = new App[4];
    }
    
    public void set_isAppMove(boolean isAppMove){this.isAppMove = isAppMove;}
    
    public void sketch(){
        for(int i=0 ; i<appNum ; i++)
            app[i].sketch();
            
        if(isAppMove)
            appMove();
    }
    
    public void adjust(float x1, float y1, float w1, float h1){
        this.x = content.leftScreen.x+w1;  // 항상 두번째 스크린을 따라 다닌다. 하지만 왼쪽으로 이동하지 않는다.
        this.y = y1+h1*0.88;
        this.w = w1;
        this.h = h1*0.12;
        
        if(this.x < content.display.x)
            this.x = content.display.x;
        
        for(int i=0 ; i<appNum ; i++){
            float x2 = x + w/170*13 + w/170*39*(i%4);
            float y2 = y + h/250*25;
            float w2 = w/170*26;
            float h2 = w/170*26;
            app[i].adjust(x2, y2, w2, h2);
            app[i].set_isText(false);
        }
    }
    
    public void appMove(){
        if(appMovingFirst <= appMovingLast){
            int i = appMovingFirst;
            float x1 = x + w/170*13 + w/170*39*(i%4);
            float y1 = y + h/250*14 + h/500*75*(i/4);
            app[appMovingFirst].setting_destination(x1, y1);
            appMovingFirst++;
        }
        else
            set_isAppMove(false);
            
    }
    
    public void setting_appMoving(int first, int last, String direction){
        if(isAppMove)
            for(int i=appMovingFirst ; i<=appMovingLast ; i++)
                app[i].set_situation("stop");
        appMovingFirst = first;
        appMovingLast = last;
        appMovingDirection = direction;
        set_isAppMove(true);
    }
    
    public boolean insertApp(PImage img, String name){
        if(appNum < 24){
            App app = new App(content, img, name);
            this.app[appNum] = app;
            appNum ++;
            return true;
        }
        else{
            return false;
        }
    }
    
    public void insertApp(App app, int idx){
        if(appNum ==  4)
            return;
 
        for(int i=appNum-1 ; i>=idx ; i--){
            float x1 = x + w/170*13 + w/170*39*((i+1)%4);
            float y1 = y + h/250*25;
            this.app[i].set_situation("noMove");
            this.app[i+1] = this.app[i];
        }
        
        setting_appMoving(idx+1, appNum, "left");
        
        if(idx <= appNum-1){
            float x1 = x + w/170*13 + w/170*39*((idx+1)%4);
            float y1 = y + h/250*25;
            this.app[idx] = app;
            this.app[idx].setting_destination(x1, y1);
        }
        else{
            float x1 = x + w/170*13 + w/170*39*((appNum)%4);
            float y1 = y + h/250*25;
            this.app[appNum] = app;
            this.app[appNum].setting_destination(x1, y1);
        }
        appNum ++;
    }
    
    public int search_insertIdx(){
        int idx = 0;
        float dist1 = 10000;
        int i = 0;
        for( ; i<4 ; i++){
            float x1 = x + w/170*13 + w/170*39*(i%4);
            float y1 = y + h/250*25;
            float w1 = w/170*26;
            float h1 = w/170*26;
            x1 += w1/2;
            y1 += h1/2;
            
            float dist2 = dist(mouseX, mouseY, x1, y1);
            if(dist1 > dist2){
                dist1 = dist2;
                idx = i;
            }
        }
            
        return idx;
    }
    
    public boolean deleteApp(App app){
        int i = searchApp(app);
        if( i == -1 )
            return false;
        for( int j=i; j<appNum-1 ; j++){
            this.app[j+1].set_situation("noMove");
            this.app[j] = this.app[j+1];
        }
        appNum --;
        
        setting_appMoving(i, appNum-1, "left");
        return true;
    }
    
    public boolean isMouseOnApp(){
        for( int i=0 ; i<appNum ; i++)
            if(app[i].isMouseOn()){
                content.pressedApp = app[i];
                return true;
            }
        content.pressedApp = null;
        return false;
      }    
    
    public boolean isPointOnApp(Point point){
        for( int i=0 ; i<appNum ; i++)
            if(app[i].isPointOn(point))
                return true;
        return false;
    }
    
    public int searchApp(App app){
        for(int i=0 ; i<appNum ; i++)
            if(app == this.app[i]){
                return i;
            }
        return -1;
    }
    
    
}

public class MainScreen{
    
    public Content content;
    public int MAX_NUM = 24;
    App[] app;
    float x, y, w, h;
    int screenNum;
    int appNum = 0;
    
    public boolean isAppMove = false;
    public int appMovingFirst;
    public int appMovingLast;
    public String appMovingDirection = null;
    
    public MainScreen(Content content, int screenNum){
        this.content = content;
        app = new App[MAX_NUM];
        this.screenNum = screenNum;
    }
    
    public void set_isAppMove(boolean isAppMove){this.isAppMove = isAppMove;}
    
    public void sketch(){
        sketch_darkCover(20, 1);
        for(int i=0 ; i<appNum ; i++)
            app[i].sketch();
            
        if(isAppMove)
            appMove();
    }
    
    public void adjust(float x1, float y1, float w1, float h1){
        this.x = x1+w1*screenNum;
        this.y = y1;
        this.w = w1;
        this.h = h1*0.88;
        for(int i=0 ; i<appNum ; i++){
            float x2 = x + w/170*13 + w/170*39*(i%4);
            float y2 = y + h/250*14 + h/500*75*(i/4);
            float w2 = w/170*26;
            float h2 = w/170*26;
            app[i].adjust(x2, y2, w2, h2);
            app[i].set_isText(true);
        }
    }
    
    public void appMove(){
        if(appMovingFirst <= appMovingLast){
            int i = appMovingFirst;
            float x1 = x + w/170*13 + w/170*39*(i%4);
            float y1 = y + h/250*14 + h/500*75*(i/4);
            app[appMovingFirst].setting_destination(x1, y1);
            appMovingFirst++;
        }
        else
            set_isAppMove(false);
            
    }
    
    public void setting_appMoving(int first, int last, String direction){
        if(isAppMove)
            for(int i=appMovingFirst ; i<=appMovingLast ; i++)
                app[i].set_situation("stop");
                
        appMovingFirst = first;
        appMovingLast = last;
        appMovingDirection = direction;
        set_isAppMove(true);
    }
    
    public int search_insertIdx(){
        int idx = 0;
        float dist1 = 10000;
        int i = 0;
        for( ; i<24 ; i++){
            float x1 = x + w/170*13 + w/170*39*(i%4);
            float y1 = y + h/250*14 + h/500*75*(i/4);
            float w1 = w/170*26;
            float h1 = w/170*26;
            x1 += w1/2;
            y1 += h1/2;
            
            float dist2 = dist(mouseX, mouseY, x1, y1);
            if(dist1 > dist2){
                dist1 = dist2;
                idx = i;
            }
        }
            
         return idx;
    }
    
    public boolean deleteApp(App app){
        int i = searchApp(app);
        if( i == -1 )
            return false;
        
        for(  int j=i; j<appNum-1 ; j++){
            this.app[j+1].set_situation("noMove");
            this.app[j] = this.app[j+1];
        }
        
        appNum --;
        setting_appMoving(i, appNum-1, "left");
        
        return true;
    }
    
    public boolean insertApp(PImage img, String name){
        if(appNum < MAX_NUM){
            App app = new App(content, img, name);
            app.set_isText(true);
            this.app[appNum] = app;
            appNum ++;
            return true;
        }
        else{
            return false;
        }
    }
    
    public void insertApp(App app, int idx){
        if(appNum ==  24){
            content.mainScreen[content.curScreen].insertApp(this.app[23], 0);
            appNum --;
        }
        
 
        for(int i=appNum-1 ; i>=idx ; i--){
            float x1 = x + w/170*13 + w/170*39*((i+1)%4);
            float y1 = y + h/250*14 + h/500*75*((i+1)/4);
            this.app[i].set_situation("noMove");
            this.app[i+1] = this.app[i];
        }
        
        setting_appMoving(idx+1, appNum, "right");
        
        if(idx <= appNum-1){
            float x1 = x + w/170*13 + w/170*39*((idx+1)%4);
            float y1 = y + h/250*14 + h/500*75*((idx+1)/4);
            this.app[idx] = app;
            this.app[idx].setting_destination(x1, y1);
        }
        else{
            float x1 = x + w/170*13 + w/170*39*((appNum)%4);
            float y1 = y + h/250*14 + h/500*75*((appNum)/4);
            this.app[appNum] = app;
            this.app[appNum].setting_destination(x1, y1);
        }
        appNum ++;
    }

    public int searchApp(App app){
        for(int i=0 ; i<appNum ; i++)
            if(app == this.app[i]){
                return i;
            }
        return -1;
    }
    
    public boolean isMouseOnApp(){
        for( int i=0 ; i<appNum ; i++)
            if(app[i].isMouseOn()){
                content.pressedApp = app[i];
                return true;
            }
        content.pressedApp = null;
        return false;
    }
    
    public boolean isPointOnApp(Point point){
        for( int i=0 ; i<appNum ; i++)
            if(app[i].isPointOn(point))
                return true;
        return false;
    }

    void sketch_darkCover(float transparency, float range){
        color c = color(0, 0, 0, transparency);
        PALETTE.setting_pen(true, false, c, PALETTE.BLACK, 1);
        rect(x, y, w, h*range);
    }
}

public class App extends Rect{
  
    Content content;
    public PImage img;
    public String situation = "stop";
    
    public float desX;  // 앱을 움직이기 위한 변수들
    public float desY;  // destination
    public float preX;
    public float preY;
    public int progress;
    
    public App(Content content, PImage img, String name){
        super(0,0,0,0);
        this.content = content;
        this.img = img;
        this.text = name;
        set_textColor(color(255));
    }
    
    public void adjust(float x, float y, float w, float h){
        if(situation == "move")
            return;
            
        if(situation == "noMove")
            return;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        set_textSize(w/100*27);
        set_strokeWeight(w/15);
    }
    
    public void set_situation(String situation){
        this.situation = situation;
    }
    
    public void implement(){
        content.display.iphone.application.set_situation(text);
        content.display.iphone.application.set_position(x+w/2, y+h/2);
    }
    
    @Override
    void sketch(){  // 직사각형 그리기
        if(situation == "move")
            move();
        if(situation == "controlling"){
            x += mouseX-pmouseX;
            y += mouseY-pmouseY;
        }
        if(content.situation == "stop"){  // 꾹 눌렀을 때 조금 커지는 기능
            if(content.curScreen != 0)
                if(!content.isConstructing)
                    if(content.isPressedOnApp())
                        if(mousePressed){
                            float adjust = (float)(millis()-content.display.pressedTime)/8000;
                            w *= 1+adjust;
                            h *= 1+adjust;
                            x -= w*adjust/2;
                            y -= h*adjust/2;
                        }
        }
        
        pushMatrix();  // 좌표계 기억
        NEW.new_translate(getCenterPoint());  // 좌표계 이동
        rotate(radians(get_rotate()));  // 좌표계 회전
        PALETTE.setting_pen(isFill, isStroke, fillColor, strokeColor, strokeWeight);  // 펜 설정
        if(isMouseOn())
            fill(0,0,0,100);
            
        if(img != null)
            NEW.new_image(img, get_point().minus(getCenterPoint()), w, h);
        else
            NEW.new_rect(get_point().minus(getCenterPoint()), w, h, w/3);  // 직사각형 그리기
        popMatrix();  // 좌표계 반환
    
        printText(); // 텍스트 출력
    }
    
    void setting_destination(float x, float y){
        preX = this.x;
        preY = this.y;
        desX = x;
        desY = y;
        progress = 0;
        set_situation("move");
    }
    
    void move(){
        x += (desX - preX)/5;
        y += (desY - preY)/5;
        progress ++;
        if(progress == 5){
            x = desX;
            y = desY;
            set_situation("stop");
        }
    }
    
  
    void printText(){  // 텍스트 출력 함수
        if(isText)
            if(text != null){
                pushMatrix();  // 좌표계 기억
                NEW.new_translate(getCenterPoint());  // 좌표계 이동
                rotate(radians(rotate));  // 좌표계 회전
                PALETTE.setting_text(textSize, textColor);
                textLeading(h/4.5);
                NEW.new_text(text, get_point().minus(getCenterPoint()).minus(w/10*2,0).plus(0, h/3*2),w*1.4,h);  // 도형 안에 텍스트 넣기
                popMatrix();  // 좌표계 반환
            }
    }
}
