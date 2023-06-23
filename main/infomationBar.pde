public class InformationBar extends Rect{
  
    public Display display;
  
    public String operationSystem = "IOS";         // 운영체제 이름
    public String dataSort = "LET";                // 데이터 종류
    public String communicationFirm = "LG U+";       // 통신회사
    public int communicationCapacity = 3;      // 전화가 터지는 정도
    public final int COMMUNICATION_CAPACITY_NUM = 4; //통신량 최대 5칸
    
    public InformationBar(Display display) {
        super(0,0,0,0);
        set_isStroke(false);
        this.display = display;  // 디스플레이 연결
    }
    
    public void adjust() {  // 좌표 조정
        x = display.x;
        y = display.y;
        w = display.w;
        h = display.h/100*3;
    }
    
    @Override
    public void sketch(){
        super.sketch();
        sketch_communicationCapacity();
        print_infortmation();
        Keypad keypad = display.iphone.keypad;
        if(keypad.situation == "wrong"){
            float progress = keypad.progress;
            sketch_lock(sin(progress/1)*(w/8-w/200*progress));
        }else{
            sketch_lock(0);
        }
        sketch_battery();
    }
    public void sketch_informationBar(boolean isLock)
    {
        sketch_communicationCapacity();  // 통신량 출력
        print_infortmation();  // 정보 출력 - 통신사, 데이터
        sketch_battery(); // 배터리 출력
    
        if (isLock) {
            sketch_lock(0);  // 자물쇠 출력 - 움직임 효과 없음
        } else {
        }
    }
    
    public void sketch_communicationCapacity() {  // 통신량 출력
        color c = color(150, 150, 150, 170);
        int i=0;
    
        PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.WHITE, 7/10);
        for (; i<communicationCapacity; i++ )
            rect(x + w/100*2 + w/150*2*i, y+h/100*30+h/9*(4-i), w/120*1, h/8*7-h/9*(4-i), w/100*5);
    
        PALETTE.setting_pen(true, true, c, c, 7/10);  
        for (; i<COMMUNICATION_CAPACITY_NUM; i++ )
            rect(x + w/100*2 + w/150*2*i, y+h/110*30+h/9*(4-i), w/120*1, h/8*7-h/9*(4-i), w/110*5);
    }
    
    public void print_infortmation() {  // 정보출력 - 통신사, 데이터
        PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.WHITE, 1);
        textSize(w/100*4);
        text(communicationFirm + "  " + dataSort, x + w/100*20, y+h/10*7);
    }
  
    
  
    public void sketch_lock(float effect) {  // 자물쇠 그리기  effect = 움직임 효과
        PALETTE.setting_pen(false, true, PALETTE.WHITE, PALETTE.WHITE, (float)15/10);    // 자물쇠 그리기
        ellipse(x+w/2 + effect, y+h/100*54, w/165*3, w/165*3);
        PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.WHITE, 1);
        rect(x+w/2-w/115*3/2 + effect, y+h/100*63, w/115*3, w/143*3, w/300*1);
    }
  
    public void sketch_battery(){
        color c = color(230, 230, 230, 255);
    
        int battery = (int)display.iphone.battery.battery;  // 자주 바꾸기 때문에 사용할 때 마다 가져온다.
        PALETTE.setting_pen(false, true, c, c, 1);
        rect(x + w/100*85, y+h/100*30, w/100*10, h/8*7, w/200*2);
    
        if (battery<15)
            PALETTE.setting_pen(true, false, PALETTE.RED, PALETTE.RED, 7/10);
        else if (battery<50)
            PALETTE.setting_pen(true, false, PALETTE.ORANGE, PALETTE.ORANGE, 7/10);
        else
            PALETTE.setting_pen(true, false, PALETTE.GREEN, PALETTE.GREEN, 7/10);
  
        rect(x + w/100*85+w/200*1, y+h/100*30+w/200*1, (w/100*10-w/200*2)/100*battery, h/8*7-w/200*2, w/300*2);
        
        if(display.iphone.battery.isCharging)
            image(display.iphone.battery.electricity, x + w/100*85+w/200*1+(h/8*7-w/200*2), y+h/100*30+w/200*1, h/8*7-w/150*2,  w/55*2);
    }
}