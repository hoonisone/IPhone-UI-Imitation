public class Battery {

    public IPhone iphone;
  
    public boolean isCharging = false;
    public float useRate = 1.0/3;
    public float chargeRate = 10;
    public float battery = 70;
    public PImage electricity;
    
    public Battery(IPhone iphone) {
        this.iphone = iphone;
        electricity = loadImage("electricity.png");
    }
  
    public void use() {
      if (iphone.device.isTurnOn)
          if (iphone.display.situation == "turnOffScreen"){  // 화면이 꺼져있으면 배터리 감소속도 1/3
              battery -= useRate/3;
          }
          else {
              battery -= useRate;
          }
          if (battery <= 0)
                  iphone.device.set_isTurnOn(false);
    }
  
    public void charge() {  // 배터리 충전
        if (isCharging) {  // 충전중이면 배터리 증가
            battery++;    
            if (battery > 100)
                battery = 100;
        }
    }
    
    public void chargeController(){
        isCharging = !isCharging;
    }
}