class YouOrMe{
    
    PFont font;
    MainScreen2 mainScreen;
    GameScreen gameScreen;
    ScoreScreen scoreScreen;
    
    String situation = "mainScreen";
    
    YouOrMe(){
        mainScreen = new MainScreen2(this);
        gameScreen = new GameScreen(this);
        font = loadFont("ArialRoundedMTBold-48.vlw");
    }

    void init(){
        textFont(font);
        //mainSound.loop();
    }

    void operater_setup(){
    }
    
    void operater_draw(){
        switch(situation){
        case "mainScreen":
            mainScreen.operater_draw();
            break;
        case "gameScreen":
            gameScreen.operater_draw();
            break;
        default:
        }
        
    }
    
    void operater_mouseClicked(){
    }
    
    void operater_mouseMoved(){
    }
    
    void operater_mouseReleased(){
    }
    
    void operater_mouseDragged(){
    }
    
    void operater_mouseWheel(float e){
        switch(situation){
        case "gameScreen":
            gameScreen.operater_mouseWheel();
            break;
        }
    }
    
    void operater_mousePressed(){
      switch(situation){
      case "mainScreen":
          if(mainScreen.button.isMouseOn())
              situation = "gameScreen";
              gameScreen.init();
              //mainSound.loop();
          break;
      case "gameScreen":
          gameScreen.operater_mousePressed();
      default:
          break;
      }
            
    }
    
    void operater_mousePressing(){
    }
    
    void operater_keyPressed(){
        switch(situation){
        case "gameScreen":
            gameScreen.operater_keyPressed();
        }
    }
    
    void operater_time_second(){
        switch(situation){
        case "mainScreen":
            break;
        case "gameScreen":
            gameScreen.operater_time_second();
            break;
        default:
            break;
        }
    }
    
    void operater_time_minute(){
    }
}
class Enroll{
  
    GameScreen gameScreen;
  
    String buffer ;

    Enroll(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        init();
    }
    
    void init(){
        buffer = "";
    }
    
    void operator_keyPressed(){
        if(key == ENTER){
            gameScreen.scoreScreen.renewName(buffer);
            gameScreen.situation = "end";
            init();
        }
        else if(key == 8){
            String box = "";
            for(int i=0 ; i<buffer.length()-1 ; i++)
                box += buffer.charAt(i);
                
            buffer = box;
        }
        else if(buffer.length() >= 15){
            // 길이 오버 출력
        }
        else if( (64 <= key && key <= 90) ||
                 (97 <= key && key <= 122)||
                 (48 <= key && key <= 57)       )
                 buffer += key;
    }
    
    void sketch(){
        fill(0, 0, 0, 150);
        strokeWeight(7);
        stroke(255);
        textSize(100);
        rect(width/5, height/2-100, width*3/5, 200);
        fill(255);
        text(buffer, width/2, height/2);
    }
}

class Fruits{
  
    GameScreen gameScreen;
    
    final int imgNum = 6;
    final int fruitNum = 50;
    final int validNum = 7;
    
    
    PImage[][] fruitImg = {{loadImage("strawberry.png"),loadImage("strawberry2.png")},
                        {loadImage("pink.png"),loadImage("pink2.png")},
                        {loadImage("pineapple.png"),loadImage("pineapple2.png")},
                        {loadImage("banana.png"),loadImage("banana2.png")},
                        {loadImage("watermellon.png"),loadImage("watermellon2.png")},
                        {loadImage("mellon.png"),loadImage("mellon2.png")},};
                        
    Fruit[] fruit = new Fruit[fruitNum];
    
    Fruits(GameScreen gameScreen){
        this.gameScreen = gameScreen;
    }
    
    void init(){
      
        for(int i=0 ; i<imgNum ; i++){  // 이미지 섞기
            int idx = (int)random(0, imgNum);
            PImage[] temp = fruitImg[i];
            fruitImg[i] = fruitImg[idx];
            fruitImg[idx] = temp;
        }
        
        
        
        for(int i=0 ; i<validNum ; i++)  // 캐릭터 만들기
           fruit[i] = new Fruit(this, i);
           
        for( int i=validNum ; i<fruitNum ; i++ )
            fruit[i] = null;
    }
    
    void sketch(){
        for(int i=0 ; i<fruitNum ; i++) //  캐릭터 그리기
            if(fruit[i] != null)
                fruit[i].sketch(i == validNum-1);
    }
    
    boolean judge(int keycode){
        if(keycode == LEFT)  // 맞는 방향으로 보내기
            if(fruit[validNum-1].flag%2 == 0)
                return true;
            else
                return false;
        else if(keycode == RIGHT)
            if(fruit[validNum-1].flag%2 == 1)
                return true;
            else
                return false;
        return false;
    }
    void move(int keycode){
        int i=fruitNum-1;
        while(fruit[i] != null && i >= validNum){  // 정답 캐릭터 들어갈 위치 찾기
            i--;
        }
        fruit[i] = fruit[validNum-1];
        fruit[i].set_information(validNum-1);
        fruit[i].idx = i;
        
        if(keycode == RIGHT)  // 맞는 방향으로 보내기
            fruit[i].set_situation("right");
        else if(keycode == LEFT)
            fruit[i].set_situation("left");
        else if(keycode == DOWN)
            fruit[i].set_situation("down");
        
        for(int j=validNum-1 ; j>=1 ; j--){  // 캐릭터 줄 당기기
            fruit[j] = fruit[j-1];
            fruit[j].set_destination(j);
            fruit[j].set_situation("move");
        }
            
        fruit[0] = new Fruit(this, 0);  // 새로운 캐릭터 생성
    }
    
    void sketch_guide(){
        int n, x, y, w, h;
        for(int i=0 ; i<=gameScreen.level.level ; i++){
            n = gameScreen.level.level+1;
            
            
            if(i%2 == 0){
                n = (n+1)/2;
                x = width/10*3;
            }
            else{
                n /= 2;
                x = width/10*7;
            }
            w = width/15;
            h = w/10*14;
            y = height/5*2-(h*n+h/10*1*(n-1))/2 + (i/2)*h/10*11;
                
            image(fruitImg[i][0], x-w/2, y, w, h);
        }
    }
    
    
}

class Fruit{
    Fruits fruits;
    PImage img[];
    String situation;
    float x, y, w, h;
    float w2, h2;
    float desX, desY, desW, desH;
    float move;
    int flag;  // 니편 내편에서 어디 팀인지!!
    int idx; // 정답 처리 되엇을 때 어디에 저장되어 있는지
    
    Fruit(Fruits fruits, int i){
        this.fruits = fruits;
        flag = (int)random(0, fruits.gameScreen.level.level+1);
        img = fruits.fruitImg[flag];
        situation = "wait";
        set_information(i);
    }
    
    void sketch(boolean pause){
      
        switch(situation){
        case "wait":
        break;
        case "move":
            x += (desX-x)*move/10;
            y += (desY-y)*move/10;
            w += (desW-w)*move/10;
            h += (desH-h)*move/10;
            move++;
            if(move == 10)
                set_situation("wait");
            break;
        case "left":
            x -= 30;
            y += 30;
            break;
        case "right":
            x += 30;
            y += 30;
            break;
        case "down":
            y += 30;
        }
        if(y > 2*height)
            fruits.fruit[idx] = null;  // 해당 캐릭터 삭제
        if(fruits.gameScreen.isPause && pause){
            w2 = w*12/10;
            h2 = h*12/10;
            image(img[1], x-w2/2, y-h2/2, w2, h2);
            return;
        }
        image(img[0], x-w/2, y-h/2, w, h);
        
    }
    
    void set_situation(String situation){
        if(situation == "move")
            move = 1;
        this.situation = situation;
    }
    
    void set_information(int i){
        x = width/2;
        y = height/10+height/10*6/(fruits.validNum)*i;
        w = width/100*5+width/200*i;
        h = w/10*14;
    }
    
    void set_destination(int i){
        desX = width/2;
        desY = height/10+height/10*6/(fruits.validNum)*i;
        desW = width/100*5+width/200*i;
        desH = w/10*14;
    }
}

class GameScreen{
  
    YouOrMe youOrMe;  //  본체와 연결
    Background background = new Background(this);
    Fruits fruits = new Fruits(this);
    Score score = new Score(this);
    Level level = new Level(this);
    Combo combo = new Combo(this);
    Gauge gauge = new Gauge(this);
    Time time = new Time(this);
    Arrow arrow = new Arrow(this);
    ScoreScreen scoreScreen = new ScoreScreen(this);
    Enroll enroll = new Enroll(this);
    
    String situation = "ready";
    boolean isPause = false;
    
    int bombNum;
    int pauseMillis; // 일시정지 시간 측정용
    
    GameScreen(YouOrMe youOrMe){
       this.youOrMe = youOrMe;   
       init();
    }
    
    void operater_draw(){
        //세팅
        time.flow();    // 시간 계산
        
        // 게임
        background.sketch();  // 배경그리기
        fruits.sketch();  // 캐릭터 그리기
        fruits.sketch_guide();  // 캐릭터 구분 그리기
        arrow.sketch(keyCode);  // 화살표 그리기
        combo.sketch();
        time.sketch_timeBar();    // 시간 그리기
        gauge.sketch();
        level.sketch();
        score.sketch();
        level.print_level();
        
        
        
        switch(situation){
        case "ready":
            if(time.isEnd()){
                situation = "start";
                time.init(time.MAX_TIME);
                time.isGo = true;
            }
            time.sketch_start();
            break;
        case "start":
            if(time.isEnd()){
                scoreScreen.renewScore(score.score);
                situation = "end";
            }
            if(isPause){
                if(millis() - pauseMillis > 1000){ // 객체가 만들어지고 1초마다 실행
                    isPause = false;
                }
            }
            break;
        case "bomb":
            bomb();
            break;
        case "end":
            scoreScreen.sketch();
            break;
        case "enroll":
            enroll.sketch();
        default:
            break;
        }   
    }
    
    void operater_mouseClicked(){}
    void operater_mouseMoved(){}
    void operater_mouseReleased(){}
    void operater_mouseDragged(){}
    void operater_mouseWheel(){}
    void operater_mousePressed(){
        switch(situation){
        case "end":
            if(scoreScreen.enroll.isMouseOn())
                if(scoreScreen.isRenew)
                    situation = "enroll";
            if(scoreScreen.restart.isMouseOn()){
                init();
                situation = "ready";
            }
                break;  
        }
    }
    void operater_mousePressing(){}
    void operater_keyPressed(){
        switch(situation){
        case "start":
            if(!isPause){
                progress(keyCode);          
            }
            break;
        case "enroll":
            enroll.operator_keyPressed();
        default:
            break;
        }
    }
    void operater_time_second(){}
    void operater_time_minute(){}
    void init(){
        fruits.init();
        score.init();
        level.init();
        combo.init();
        gauge.init();
        time.init(3);
        
    }
    
    void progress(int keycode){
        if(keycode == 32){
            if(gauge.isFull()){
                time.second += 10;  // 시간 추가
                time.adjust();
                situation = "bomb";
                bombNum = 0;
                gauge.init();
                return;
            }
        }
        else if(fruits.judge(keycode)){
            fruits.move(keycode);
            manage_right();
            return; 
        } 
        manage_wrong();
    }
    
    void manage_wrong(){
        isPause = true;
        pauseMillis = millis(); 
        combo.init();

    }
    
    void manage_right(){
        combo.hit();
        score.plus(combo.combo);
        gauge.fill_gauge();
        level.right();

    }
    
    void bomb(){
        if(bombNum %2 == 0){
            fruits.move(DOWN);
            manage_right();
            for(int i=1 ; i<fruits.validNum ; i++)
                fruits.fruit[i].set_information(i);
        }
        bombNum++;
        if(bombNum >= 20)
            situation = "start";
        gauge.gauge = 0;
    }
    
    void time_millis(){
        switch(situation){
        case "ready":
            
            break;
        case "start":
            break;
        default:
            break;
        }
    }
}

class Background{
  
    GameScreen gameScreen;
    PImage img = loadImage("gameScreen.png");
    
    color roadColor = color(255, 200, 200);
    color backgroundColor = color(255);
    
    float[][][] x= {{{width*47/100, height*0/100}, {width*53/100, height*0/100}, {width*58/100, height*70/100}, {width*42/100, height*70/100}},
                   {{width*42/100, height*70/100}, {width*58/100, height*70/100}, {width*40/100, height*100/100}, {width*25/100, height*100/100}},
                   {{width*42/100, height*70/100}, {width*58/100, height*70/100}, {width*75/100, height*100/100}, {width*60/100, height*100/100}}};
    
    Background(GameScreen gameScreen){
        this.gameScreen = gameScreen;
    }
    
    void sketch(){
      
        
        background(backgroundColor);
        
        fill(roadColor);  // draw road
        noStroke();
        if(gameScreen.situation == "bomb")
            quad(x[0][0][0], x[0][0][1], x[0][1][0], x[0][1][1], width*60/100, height, width*40/100, height);
        else
            for(int i=0 ; i<3 ; i++)
                quad(x[i][0][0], x[i][0][1], x[i][1][0], x[i][1][1], x[i][2][0], x[i][2][1], x[i][3][0], x[i][3][1]);
        
        
        stroke(0);
        strokeWeight(5);
        //background(255);
    }
    
}

class Score{
  
    GameScreen gameScreen;
    float x = width/40*31;
    float y = height/20;
    float w = width/20*3;
    Box box = new Box(x, y, w, "Score");
    int score;
   
    Score(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        init();
    }
    
    void init(){
        score = 0;
    }
    
    void plus(int score){
        this.score += score;
    }
     
    void sketch(){
        box.sketch(score);
    }
}

class Level{
  
    GameScreen gameScreen;
  
    int num;
  
    float x = width/20*12;
    float y = height/20;
    float w = width/20*3;
    int level;
    int levelUpMillis;
    
    Box box = new Box(x, y, w, "Level");
    
    Level(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        init();
    }
    
    void init(){
        level = 1;
        num = 0;
        levelUpMillis = -1000;  // millis()와 차이가 무조건 1000이상이 되게끔 => levelUp() 실행이 안되게
    }
    
    void right(){
        num++;
        
        switch(num){
        case 100:
        case 250:
        case 400:
        case 700:
            levelUp();
        default:
            break;
        }
    }
    
    void sketch(){
        box.sketch(level);
    }
    
    void levelUp(){
        level++;
        levelUpMillis = millis();
    }
    
    void print_level(){
        if(millis()-levelUpMillis<2000){
          
            fill(0, 255, 0);
            textSize(200);
            float x = sin(radians(90)+radians((millis()-levelUpMillis)*180/2000));
            text("levelUP!", width/2+width*sq(sq(x))*x, height/3);
        }
    }
}

class Combo{
  
    GameScreen gameScreen;
    
    int combo;
    int millis;
    int textSize;
    
    Combo(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        init();
    }
    
    void init(){
        combo = 0;
    }

    void hit(){
        combo++;
        millis = millis();
        textSize = 0;
    }
    
    void sketch(){
      
        if(millis()-millis< 1000){    // 1초 동안만 출력
      
            textSize = (millis()-millis)/2;  // textSize 정하기
            if(textSize > 70)
                textSize = 70;
                
            pushMatrix();
            translate(width/10*4, height/10*3);
            rotate(radians(-10));
            textSize(textSize);
            fill(255, 0, 0);
            text(combo+" combo", 0, 0);
            popMatrix();
        }
    }
}

class Gauge{
  
    GameScreen gameScreen;
    PImage bomb = loadImage("bomb.png");
    
    final int MAX_GAUGE = 50;
    int gauge;
    int x = 130;
    int y = 210;
    int w = width/5;
    int h = 50;
    
    Gauge(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        init();
    }
    
    void init(){
        gauge = 0;
    }
    
    void fill_gauge(){
        
        if(gauge < MAX_GAUGE)  
            gauge++;
            
    }
    
    void sketch(){
        
        strokeWeight(1);          //gauge
        int colorControl;
        
        if(gauge == MAX_GAUGE){
            colorControl = millis()/200%2;    // 게이지가 꽉차면 깜빡임
            fill(255, 180*colorControl, 0);
        }else
            fill(255, 180, 0);
        rect(x, y, w*gauge/MAX_GAUGE, h);
        
        
        if(gauge == MAX_GAUGE){    // 꽉차면 space 출력
            textSize(height/100*4);
            fill(255);
            text("SPACE", x+w/2, y+h/2);
        }
        
        noFill();    //테두리
        stroke(0);
        strokeWeight(3);
        rect(x, y, w, h);
        
        image(bomb, x-70, y-70, 130, 130);
    }
    
    boolean isFull(){
        if(gauge == MAX_GAUGE)
            return true;
        return false;
    }
}

class Time{
    
    GameScreen gameScreen;
    
    private int millis;
    private int second;
    final int MAX_TIME = 60;
    
    boolean isGo = false;
    
    PImage watch = loadImage("watch.png");
    
    int x = 130;
    int y = 100;
    int w = width/5;
    int h = 50;
    
    Time(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        init(3);
    }
    
    void init(int second){
        this.second = second;
        millis = millis();
    }
    
    void flow(){ // loop에 넣을 부분
        if(millis() - millis > 1000){
            millis = millis();
            second--;
        }
    }
    
    void sketch_timeBar(){
        stroke(0);
        strokeWeight(0);
        fill(0, 255, 0);
        if(gameScreen.situation == "ready")
            rect(x, y, w, h);
        else
            rect(x, y, w/MAX_TIME*second, h);
        strokeWeight(3);
        noFill();
        rect(x, y, w, h);
        image(watch, x-78, y-45, 105, 105);
        
        if(isGo){
            fill(255, 0, 0);
            textSize((millis()-millis)/2);
            text("Go!", width/2, height/2);
            
            if(second <= 60 && millis()-millis > 500)
                isGo = false;
        }
    }
    
    void sketch_start(){
        fill(255, 0, 0);
        textSize((millis()-millis)/2);
        text(second, width/2, height/2);
    }
    
    boolean isEnd(){
        if(second == 0)
            return true;
        return false;
    }
    
    void adjust(){
        if(second>60)
            second = 60;
    }
}

class Arrow{
    
    GameScreen gameScreen;
    
    final int Left = 0;
    final int Right = 1;
    final int noPress = 0;
    final int Press = 1;
    
    int pressedMillis;
    
    float w = width/10;
    float h = w/10*7;
    float y = height/20*14-h/2;
    
    PImage[][] image = {{loadImage("left_white.png"), loadImage("left_yellow.png")}, {loadImage("right_white.png"), loadImage("right_yellow.png")}};
    
    
    Arrow(GameScreen gameScreen){
        this.gameScreen = gameScreen;
    }
    
    void sketch(int keycode){
        if(keyPressed){
            if(keycode == LEFT){
                image(image[Left][Press], width/3-w/2, y, w, h);
                image(image[Right][noPress], width/3*2-w/2, y, w, h);
                return;
            }
            else if(keycode == RIGHT){
                image(image[Left][noPress], width/3-w/2, y, w, h);
                image(image[Right][Press], width/3*2-w/2, y, w, h);
                return;
            }
        }
        
        image(image[Left][noPress], width/3-w/2, y, w, h);
        image(image[Right][noPress], width/3*2-w/2, y, w, h);   
    }


}

class Box{
    color stroke = color(0);
    color fill = color(255);
    float strokeWeight = 8;
    String text;
    float x, y, w, h;
    
    Box(float x, float y,float w, String text){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = w/10*4;
        this.text = text;
    }
    
    void sketch(int value){
        fill(fill);
        stroke(stroke);
        strokeWeight(strokeWeight);
        rect(x, y, w, h, width/80);
        
        noStroke();
        fill(255);
        rect(x+w/5, y-strokeWeight/2-1, w/5*3, strokeWeight+2);
        if(text != null){
            fill(0);
            textSize(50);
            text(text, x+w/2, y);
        }
        
        text(value, x+w/2, y+h/2);
    }
    
    
}

class MainScreen2{

    PImage img;
    YouOrMe youOrMe;
    StartButton button;
    
    MainScreen2(YouOrMe youOrMe){
        this.youOrMe = youOrMe;
        button = new StartButton();
        
        img = loadImage("mainScreen.PNG");
    }

    void operater_setup(){
    }
    
    void operater_draw(){
        image(img, 0, 0, width, height);
        button.sketch();
    }
    
    void operater_mouseClicked(){
    }
    
    void operater_mouseMoved(){
    }
    
    void operater_mouseReleased(){
    }
    
    void operater_mouseDragged(){
    }
    
    void operater_mouseWheel(){
    }
    
    void operater_mousePressed(){
    }
    
    void operater_mousePressing(){
    }
    
    void operater_keyPressed(){
    }
    
    void operater_time_second(){
    }
    
    void operater_time_minute(){
    }
    
}

class StartButton{
    
    float x, y, w, h;
    PImage img;
    
    StartButton(){
        x = width/2;
        y = height/2 + height/10*2;
        w = width/100*17;
        h = height/200*11;
    }
    
    boolean isMouseOn(){
        if( x-w/2 < mouseX && mouseX < x+w/2 )
        if( y-h/2 < mouseY && mouseY < y+h/2 )
            return true;
      
        return false;
    }
    
    void sketch(){
        //image(img, x, y, w, h);
        if(isMouseOn()){
            textSize(60);
            fill(255, 0, 0);
        }
        else{
            textSize(50);
            fill(0);
        }
        text("GAME START", x, y);
        
    }
}

class ScoreScreen{
  
    GameScreen gameScreen;
    Button enroll = new Button("Enroll Name", width*29/100, height*85/100, 300, 100);
    Button restart = new Button("Start", width*55/100, height*85/100, 300, 100);
    final int NUM = 10; // 몇위까지 기록?
    int[] score;
    String[] name;
    boolean isRenew;
    int rank;
  
    ScoreScreen(GameScreen gameScreen){
        this.gameScreen = gameScreen;
        score = new int[NUM];
        name = new String[NUM];
        for(int i=0 ; i<NUM ; i++){
            score[i] = 0;
            name[i] = "noName"; 
        }
    }
    
    void renewScore(int score){
      
        if( this.score[NUM-1] < score ){  // 10위권 안에 든다면
            for(rank=NUM-1 ; rank>=1 ; rank--)
                if(this.score[rank-1] < score){
                    this.score[rank] = this.score[rank-1];
                }
                else{
                    break;
                }
                
            this.score[rank] = score;
            isRenew = true;
        }
        else
            isRenew = false;
            
        for(int i=NUM-1 ; i>rank ; i--)  // 이름 등록하기
            name[i] = name[i-1];
            name[rank] = "noName";
    }
    
    void renewName(String name){
        this.name[rank] = name;
        isRenew = false;
    }

    void sketch(){
        fill(0,0,0,150);  // 필터씌우기
        rect(0, 0, width, height);
        fill(255, 255, 0);
        textSize(70);
        text("Rank                Name                Score", width/2, height/7);
        fill(255);
        for(int i=0 ; i<NUM ;i++){
            text(i+1, width*23/100, 250 + 70*i);
            text(name[i], width*50/100, 250+70*i);
            text(score[i], width*75/100, 250+70*i);
        }
            
        
        if(isRenew)
            enroll.sketch();
        
        restart.sketch();
        
        if(enroll.isMouseOn() || restart.isMouseOn())
            cursor(HAND);
        else
            cursor(ARROW);
    }
    
    
    
}

class Button{
    
    float x, y, w, h;
    PImage img = loadImage("restartButton.png");
    String text;
    
    Button(String text, float x, float y, float w, float h){
        this.text = text;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    boolean isMouseOn(){
        if( x < mouseX && mouseX < x+w )
        if( y < mouseY && mouseY < y+h )
            return true;
        return false;
    }
    
    void sketch(){
        fill(255, 255, 0);
        if(isMouseOn()){
            textSize(80);
        }
        else{
            textSize(75);
        }
        text(text, x, y, w, h);
        
        noFill();
        stroke(255);
        rect(x, y, w, h);
        
    }
}
