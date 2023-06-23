public class Lolo{
    
    public Application application;
    public String situation;
    public int highestScore = 0;
    public String highestName = null;
    public float progress;
    public int step;
    public PImage loadingImg;
    
    
    public final int Red = 1;
    public final int Yellow = 2;
    public final int Blue = 3;
    public final int Width = 6;
    public final int Height = 6;
    
    public final color RedColor = color(255, 0, 0);
    public final color YellowColor = color(255, 255, 0);
    public final color BlueColor = color(0, 0, 255);
    
    public int score;
    public int lank;
    public int time;
    public Block[][] board;
    
    public Lolo(Application application){
        this.application = application;
        board = new Block[6][6];
        loadingImg = loadImage("Lolo_loading.png");
        set_situation("loading");
    }
    
    public void set_situation(String situation){
        
        switch(situation){
        case "loading":
            progress = 300;
            step = 1;
            break;
        }
        
        this.situation = situation;
    }
    
    public void loading(){
        switch(step){
        case 1:
            image(loadingImg, 0, 0, width, height);
            fill(50,70,95,progress);
            rect(0,0,width, height);
            progress -= 5;
            if(progress <= 0)
                step ++;
            break;
        case 2:
            image(loadingImg, 0, 0, width, height);
        }
    }
    
    public void sketch_background(){
        fill(240);
        rect(0,0,width, height);
    }

    public void operater_setup(){

    }
  
    public void operater_draw(){
        sketch_background();
        switch(situation){
        case "loading":
            loading();
            break;
        case "main":
            
        }
        
        textSize(30);
        fill(0);
        text(progress, 100, 100);
        text(situation, 100, 200);
    }
  
    public void operater_mouseClicked(){

    }
  
    public void operater_mouseMoved(){

    }
    
    public void operater_mousePressed(){

    }
  
    public void operater_mouseDragged(){

    }
  
    public void operater_mouseReleased(){

    }
  
    public void operater_mouseWheel(float e){

    }
    
    public void operater_mousePressing(){

    }
    
    public void operater_keyPressed(){
    
    }
  
    public void operater_time_second() {

    }
  
  
    public void operater_time_minute() {

    }
}
public class Block extends Rect{
    
    public Lolo lolo;
    public Block(Lolo lolo){
        super(0,0,0,0);
        this.lolo = lolo;
    }
}
