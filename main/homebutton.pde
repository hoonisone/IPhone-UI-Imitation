class HomeButton extends Ellipse{  // 홈버튼

    public IPhone iphone;  // 핸드폰
  
    public HomeButton(IPhone iphone) {  // 홈버튼 생성자
        super(0,0,0,0);
        this.iphone = iphone;  // 핸드폰과 연결
        set_isFill(true);
        set_isStroke(true);
        set_fillColor(PALETTE.WHITE);
        set_strokeColor(PALETTE.BLACK);
        adjust();
    }
  
    public void adjust(){
        this.x = iphone.device.x + iphone.device.w/2;
        this.y = iphone.device.y + iphone.device.h/200*189;
        this.w = iphone.device.h/200*12;
        this.h = w;
        
        x -= w/2;
        y -= h/2;
        strokeWeight = w/100*7;
    }
}
