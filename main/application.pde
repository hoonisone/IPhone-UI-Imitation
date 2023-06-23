public class Application{
  
    IPhone iphone;
    String situation = "null";
    Lolo lolo;
    
    public float appX;
    public float appY;
    
    public Application(IPhone iphone){
        this.iphone = iphone;
        lolo = new Lolo(this);
    }
    
    public void set_position(float x, float y){
        appX = x;
        appY = y;
    }
    
    public void set_situation(String situation){
        switch(situation){
        case "Naver":
            link("https://naver.com");
            break;
        case "FaceBook":
            link("https://www.facebook.com");
            break;
        case "Naver\nWebtoon":
            link("https://comic.naver.com/webtoon/weekday.nhn");
            break;
        case "Cloud":
            link("https://photo.cloud.naver.com");
            break;
        case "YouTube":
            link("https://www.youtube.com");
            break;
        case "YouOrMe":
            mainSituation = "youOrMe";
            youOrMe.init();

            break;
        case "Tetris":
            mainSituation = "tetris";
            //ReGameInit(1);
            //ReGameInit(2);
            break;
        }
        
        //this.situation = situation;
        //mainSituation = situation;
    }
    
    public void operater_setup(){
        lolo.operater_setup();
        tetris_operater_setup();
    }
  
    public void operater_draw(){
        switch(situation){
        case "Lolo":
            lolo.operater_draw();
            break;
        case "Tetris":
            tetris_operater_draw();
            break;
        default:
        }
    }
  
    public void operater_mouseClicked(){
        switch(situation){
        case "Lolo":
            lolo.operater_mouseClicked();
            break;
        case "Tetris":
            tetris_operater_mouseClicked();
            break;
        default:
        }
    }
  
    public void operater_mouseMoved(){
        switch(situation){
        case "Lolo":
            lolo.operater_mouseMoved();
        default:
        }

    }
    
    public void operater_mousePressed(){
        switch(situation){
        case "Lolo":
            lolo.operater_mousePressed();
            break;
        default:
        }

    }
  
    public void operater_mouseDragged(){
        switch(situation){
        case "Lolo":
            lolo.operater_mouseDragged();
            break;
        default:
        }

    }
  
    public void operater_mouseReleased(){
        switch(situation){
        case "Lolo":
            lolo.operater_mouseReleased();
            break;
        default:
        }

    }
  
    public void operater_mouseWheel(float e){
        switch(situation){
        case "Lolo":
            lolo.operater_mouseWheel(e);
            break;
        default:
        }

    }
    
    public void operater_mousePressing(){
        switch(situation){
        case "Lolo":
            lolo.operater_mousePressing();
            break;
        default:
        }

    }
    
    public void operater_keyPressed(){
        switch(situation){
        case "Lolo":
            lolo.operater_keyPressed();
            break;
        case "Tetris":
            tetris_operater_keyPressed();
            break;
        default:
        }
    
    }
  
    public void operater_time_second(){
        switch(situation){
        case "Lolo":
            lolo.operater_time_second();
            break;
        default:
        }
    }
  
  
    public void operater_time_minute(){
        switch(situation){
        case "Lolo":
            lolo.operater_time_minute();
            break;
        default:
        }

    }
}

public class BackButton extends Rect{
  
    Application application;
    public BackButton(Application application){
        super(0,0,0,0);
        this.application = application;
    }
}
