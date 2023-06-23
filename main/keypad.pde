public class Keypad extends Rect{
  
    IPhone iphone;
    KeyButton[][] button1;  // 잠금화면 키패드 버튼 9 세트
    KeyButton button2;
  
    String situation = "solving";
  
    public int pressedKey;
    public int passwordBuffer[];

    public float progress;
    
    public int password[]; // 암호
    public int PASSWORD_LEN = 4;
    
    Keypad(IPhone iphone) {
        super(0,0,0,0);
        this.iphone=iphone;
        set_isStroke(false);
        password = new int[PASSWORD_LEN];
        
        button1 = new KeyButton[3][3];
        for (int y=0; y<3; y++ )
        for (int x=0; x<3; x++ )
            button1[x][y] = new KeyButton(this, x+1 + y*3);
        button2 = new KeyButton(this, 0);
    
        adjust();
        password = new int[PASSWORD_LEN];
        passwordBuffer = new int[PASSWORD_LEN];
        for (int i=0; i<PASSWORD_LEN; i++ ) {
            password[i] = 0;
            passwordBuffer[i] = -1;
        }
        
        adjust();
    }
    
    void set_PASSWORD_LEN(int len){
        if(len <= 4)
            PASSWORD_LEN = 4;
        else if(len >10)
            PASSWORD_LEN = 10;
        else
            PASSWORD_LEN = len;
    } 
    
    void set_password(int[] password){
        if(password.length == PASSWORD_LEN)
            this.password = password;
        else
            ERROR.error("keypad","비밀번호가 올바르지 않습니다. \n 자릿수를 확인해주세요");
    }
    
    void set_situation(String situation){
        switch(situation){
        case "right":
            iphone.display.set_situation("to_wallpaperScreen");
            break;
        case "solving":
            initBuffer();
            break;
        case "wrong":
            progress = 0;
            break;
        }
        this.situation = situation;
    }
    
    int get_PASSWORD_LEN(){return PASSWORD_LEN;}
    int[] get_password(){return password;}
    
    public void initBuffer(){
        for(int i=0; i<PASSWORD_LEN; i++ )
            passwordBuffer[i] = -1;
    }
    
    public void adjust(){
        x = iphone.display.get_x();
        y = iphone.display.get_y();
        w = iphone.display.get_w();
        h = iphone.display.get_h();
        
        for (int y=0; y<3; y++ )
        for (int x=0; x<3; x++ )
            button1[x][y].adjust(x,y);
        button2.adjust(1,3);
    }
    
    @Override
    public void sketch(){
        super.sketch();
        switch(situation){
        case "right":
            break;
        case "wrong":
            scetch_buffer(sin(progress/1)*(w/8-w/200*progress));
            progress+=1.5;
            if(progress > 10)
                set_situation("solving");
            break;
        case "solving":
            scetch_buffer(0);
            break;
        }
        print_information();
        sketch_button();
    }

    public void sketch_button() {
        for (int y=0; y<3; y++ )
            for (int x=0; x<3; x++ )
                button1[x][y].sketch();
    
        button2.sketch();
    }
    
    public void scetch_buffer(float move) {
        PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.WHITE, 1);
    
        for ( int i=0; i<PASSWORD_LEN; i++ ) {
            if (passwordBuffer[i] == -1)
                PALETTE.setting_pen(false, true, PALETTE.WHITE, PALETTE.WHITE, 1);
            ellipse(x+w/2+move - w/10*(PASSWORD_LEN-1)/2+w/10*i, y+h/100*25, w/110*4, w/110*4);
        }
    }
    
    public void print_information() {
        PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.BLACK, 1);
        textSize(w/14);
        text("Please\nenter your password", x+w/2, y+h/100*13);
    }
    
    public boolean isMouseOn(){
        pressedKey = -1;
        if (button2.isMouseOn())
            return true;
        else {
          for (int y=0; y<3; y++ )
          for (int x=0; x<3; x++ )
              if (button1[x][y].isMouseOn())
                  return true;
        }
        return false;
    }
  
    public void isPressed() {
        int i=0;
        for ( i=0; i<PASSWORD_LEN; i++ ) {
            if (passwordBuffer[i] == -1) {
                passwordBuffer[i] = pressedKey;
                break;
            }
        }
        if (i == PASSWORD_LEN-1) {
            if (isRightPassword())
                set_situation("right");
            else
                set_situation("wrong");
        }
    }
  
    public boolean isRightPassword() {
        for ( int i=0; i<PASSWORD_LEN; i++ )
            if (password[i] != passwordBuffer[i]) {   
                return false;
          }
        return true;
    }
}

public class KeyButton extends Ellipse{
    
    public Keypad keypad;
    int num;
    
    public KeyButton(Keypad keypad, int num){
        super(0,0,0,0);
        this.keypad=keypad;
        this.num = num;
        set_isStroke(false);
        set_isFill(true);
        set_fillColor(color(255, 255, 255, 60));
    }
    
    @Override
    public void sketch() {
        super.sketch();
        PALETTE.setting_pen(true, true, PALETTE.WHITE, PALETTE.BLACK, 1);
        textSize(w/100*60);
        text(num, x+w/2, y+w/2-w/100*5);
    }
    
    public void adjust(float x, float y){
        this.x = keypad.x + keypad.w/30*7 + keypad.w/30*8*x;
        this.y = keypad.y + keypad.h/100*40 + keypad.h/30*5*y;
        
        this.w = keypad.w/100*20;
        this.h = keypad.w/100*20;
        
        this.x -= w/2;
        this.y -= h/2;
    }
    
    @Override
    public boolean isMouseOn(){
        if(super.isMouseOn()){
            keypad.pressedKey = num;
            return true;
        }
        else
            return false;
            
    }
}
