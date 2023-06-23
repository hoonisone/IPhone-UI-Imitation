public class Charge{

    public IPhone iphone;
    public PImage batteryOn;
    public PImage batteryOff;
    
    public float x, y, w, h;
    
    public Charge(IPhone iphone){
        this.iphone = iphone;
        batteryOn = loadImage("batteryOn.png");
        batteryOff = loadImage("batteryOff.png");
        x = width/100*90;
        y = height/100*90;
        w = width/100*9;
        h = w/5*3;
    }
    
    public void sketch(){
      
        if(iphone.battery.isCharging)
            image(batteryOn, x, y, w, h);
        else
            image(batteryOff, x, y, w, h);
    }
    
    public boolean isMouseOn(){
      
      if( x < mouseX && mouseX < x+w && y < mouseY & mouseY < y+h )
          return true;
      return false;
    }
}