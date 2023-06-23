public class IPhone
{   
  
    public final Information information;
    public final Device device;
    public final Display display;
    public final HomeButton homeButton;
    public final Keypad keypad;
    public final Battery battery;
    public final Charge charge;
    public final Application application;
    
    PFont font = createFont("한초롬바탕", 32);
    
    public IPhone(){

        information = new Information(this);
        device = new Device(this);
        display = new Display(this);
        homeButton = new HomeButton(this);
        keypad = new Keypad(this);
        battery = new Battery(this);
        charge = new Charge(this);
        application = new Application(this);
        
        init();
    }
  
    void init(){
        textFont(font);  // 폰트 수정(한글 허용)
    }
  
    public void operater_setup(){
        application.operater_setup();
    }
  
    public void operater_draw(){
        device.sketch();
        homeButton.sketch();
        if(device.isTurnOn){
            if(display.isTurnOn)
                switch(display.situation){
                case "to_turnOnScreen":  // 꺼진화면 -> 켜진화면
                    display.sketch_to_turnOnScreen();
                    break;
                case "turnOnScreen":  // 켜진화면
                    display.sketch_turnOnScreen();
                    break;
                case "to_keypadScreen":  // 켜진화면 -> 잠금화면
                    display.sketch_to_keypadScreen();
                    break;
                case "keypadScreen":  // 잠금화면
                    display.sketch_keypadScreen();
                    break;
                case "to_wallpaperScreen":  // 잠금화면 -> 바탕화면
                    display.sketch_to_wallpaperScreen();
                    break;
                case "wallpaperScreen":  // 바탕화면
                    display.sketch_wallpaperScreen();
                    break;
                    
            }
            else{
                switch(display.situation){
                case "turnOffScreen":
                    display.sketch_turnOffScreen();
                    break;
                case "to_turnOnScreen":  // 꺼지고 있는 꺼진화면 -> 켜진화면
                    display.sketch_to_turnOnScreen();
                    display.sketch_to_turnOffScreen();
                    break;
                case "turnOnScreen":// 꺼지고 있는 켜진화면
                    display.sketch_turnOnScreen();
                    display.sketch_to_turnOffScreen();
                    break;
                case "to_keypadScreen":  // 꺼지고 있는 켜진화면 -> 잠금화면
                    display.sketch_to_keypadScreen();
                    display.sketch_to_turnOffScreen();
                    break;
                case "keypadScreen":  // 꺼지고 있는 잠금화면
                    display.sketch_keypadScreen();
                    display.sketch_to_turnOffScreen();
                    break;
                case "to_wallpaperScreen":  // 꺼지고 있는 잠금화면 -> 바탕화면
                    break;
                case "wallpaperScreen":  // 거지고 있는 바탕화면
                    break;
                }
            }
            application.operater_draw();
        }
        else{
            switch(display.situation){
            case "turnOffScreen":
                display.sketch_turnOffScreen();
                break;
            case "turningOnScreen":
                break;
            case "turningOffScreen":
                break;
            }
        }
        charge.sketch();
    }
  
    public void operater_mouseClicked(){
        if(device.isTurnOn){
            application.operater_mouseClicked();
        }
    }
  
    public void operater_mouseMoved(){
        if(device.isTurnOn){
            application.operater_mouseMoved();
        }
    }
    
    public void operater_mousePressed(){
        if(device.isTurnOn){
            if(display.isTurnOn){
                switch(display.situation){
                case "to_turnOnScreen":
                    if(homeButton.isMouseOn())
                        display.set_situation("to_keypadScreen");
                    break;
                case "turnOnScreen":
                    if(homeButton.isMouseOn())
                        display.set_situation("to_keypadScreen");
                    break;
                case "to_keypadScreen":
                    if(homeButton.isMouseOn())
                        display.set_situation("to_turnOnScreen");
                    break;
                case "keypadScreen":
                    if(homeButton.isMouseOn())
                        display.set_situation("to_turnOnScreen");
                    if(keypad.isMouseOn())
                        keypad.isPressed();
                    
                    break;
                case "to_wallpaperScreen":
                    break;
                case "wallpaperScreen":
                    display.wallpaperController_mousePressed();
                    if(homeButton.isMouseOn())
                        display.content.goHome();
                    break;
                }    
            }
            else{
                switch(display.situation){
                case "turnOffScreen":
                    if(homeButton.isMouseOn()){
                        display.set_isTurnOn(true);
                        display.set_situation("to_turnOnScreen");
                    }
                    break;
                case "to_turnOnScreen":
                    break;
                case "turnOnScreen":
    
                    break;
                case "to_keypadScreen":
                    break;
                case "keypadScreen":
                    break;
                case "to_wallpaperScreen":
                    break;
                case "wallpaperScreen":
                    break;
                }
            }
            application.operater_mousePressed();
        }
        if(charge.isMouseOn())
            battery.chargeController();
    }
  
    public void operater_mouseDragged(){
        if(device.isTurnOn){
            if(display.isTurnOn){
                switch(display.situation){
                case "wallpaperScreen": 
                    display.wallpaperController_mouseDragged();
                    break;
                }
            }
            application.operater_mouseDragged();
        }       
    }
  
    public void operater_mouseReleased(){
        if(device.isTurnOn){
            if(display.isTurnOn){
                switch(display.situation){
                case "wallpaperScreen": 
                    display.wallpaperController_mouseReleased();
                    break;
                }
            }
            application.operater_mouseReleased();
        }
        
    }
  
    
  
    public void operater_mouseWheel(float e){
        
        if(device.isTurnOn){
            device.sizeChange(e);
            device.adjust();
            display.adjust();
            homeButton.adjust();
            keypad.adjust();
            
            application.operater_mouseWheel(e);
        }
    }
    
    public void operater_mousePressing(){
        if(device.isTurnOn){
              if(display.isTurnOn){
                  switch(display.situation){
                  case "wallpaperScreen": 
                      display.wallpaperController_mousePressing();
                      break;
                  }
              }
              application.operater_mousePressing();
         }   
    }
    
    public void operater_keyPressed(){
        if(device.isTurnOn){
            application.operater_keyPressed();
        }
    }
  
    public void operater_time_second() {
        if(device.isTurnOn){
            battery.use();
            battery.charge();
            
            application.operater_time_second();
        }
    }
  
  
    public void operater_time_minute() {
        if(device.isTurnOn){
            application.operater_time_minute();
        }

    }
}
