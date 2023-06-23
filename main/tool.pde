public class Day {
  
    public int year;
    public int month;
    public int day;
    public int hour;
    public int minute;
    public int second;
  
    public String[] month_string;  // 달에 대한 문자열
    public String[] dayOfWeek_string;  // 요일에 대한 문자열
    public int[] month_count;  // 한 달의 요일 수
  
    public Day() {
        month_string = new String[12];
        dayOfWeek_string = new String[7];
        month_count = new int[12];
    
        year = year();
        month = month();
        day = day();
    
        hour = hour();
        minute = minute();
        second = second();
    
        for (int i=0; i<12; i++) {  // 한 달의 요일 수 계산
            month_count[i] = 31;
            if (i+1 == 4 || i+1 == 6 || i+1 == 9 || i+1 == 11)
                month_count[i] = 30;
            else
                month_count[i] = 28;
        }
    
        month_string[0] = "January";
        month_string[1] = "February";
        month_string[2] = "March";
        month_string[3] = "April";
        month_string[4] = "May";
        month_string[5] = "June";
        month_string[6] = "July";
        month_string[7] = "August";
        month_string[8] = "September";
        month_string[9] = "October";
        month_string[10] = "November";
        month_string[11] = "December";
    
        dayOfWeek_string[0] = "Monday";
        dayOfWeek_string[1] = "Tuesday";
        dayOfWeek_string[2] = "Wednesday";
        dayOfWeek_string[3] = "Thursday";
        dayOfWeek_string[4] = "Friday";
        dayOfWeek_string[5] = "Saturday";
        dayOfWeek_string[6] = "Sunday";
    }
  
    public int count_year() {
        return year();
    }
  
    public int count_month() {
        return month();
    }
  
    public int count_day() {
        return day();
    }
  
    public int count_hour() {
        return hour();
    }
  
    public int count_minute() {
        return minute();
    }
  
    public int count_second() {
        return second();
    }
  
    public String dayOfWeekString(int year, int month, int day) {  // 요일을 문자열로 바꿔줌
        int sum = year*365;  //년에 대한 날짜수 계산
    
        for (int i=0; i<month; i++)  // 달에 대한 날짜수 계산
            sum += month_count[i];
    
        sum += day;  // 날짜에 대한 날짜수 게산
    
        return dayOfWeek_string[(sum+6)%7];
    }    
  
    public String monthString(int num) {  // 월을 문자열로 바꿔줌
        return month_string[num-1];
    }
  
    public String ampm()
    {
        if (hour<12)
            return "AM";
        else
            return "PM";
    }
  
    public int hour_ampm()
    {
        if (hour%12 == 0)
            return 12;
        else
            return hour%12;
    }
}

public class Palette {

    final color WHITE        = color( 255, 255, 255, 255);
    final color BLACK        = color(   0, 0, 0, 255);
    final color YELLOW       = color( 255, 255, 0, 255);
    final color RED          = color( 255, 0, 0, 255);
    final color GREEN        = color(   0, 255, 0, 255);
    final color BLUE         = color(   0, 0, 255, 255);
    final color ORANGE       = color( 255, 150, 0, 255);
    final color BACKGROUND   = color( 200, 200, 200, 255);
    final color PINK         = color( 255, 170, 170, 255);
    final color LIGHT_BLACK  = color( 150, 150, 150, 255);
  
    void setting_pen(boolean fill, boolean stroke, color fill_color, color stroke_color, float stroke_weight) {
        if (fill)
            fill(fill_color);
        else
            noFill();
    
        if (stroke){
            stroke(stroke_color);
            strokeWeight(stroke_weight);
        } else
            noStroke();
    }
    
    void setting_text(float textSize, color textColor){
        textSize(textSize);
        fill(textColor);
    }
}

public class New{
    public void new_translate(Point point){translate(point.get_x(), point.get_y());}
    public void new_triangle(Point point1, Point point2, Point point3){triangle(point1.get_x(), point1.get_y(), point2.get_x(), point2.get_y(), point3.get_x(), point3.get_y());}
    public void new_line(Point point1, Point point2){line(point1.get_x(), point1.get_y(), point2.get_x(), point2.get_y());}
    public void new_rect(Point point1, float W, float H){rect(point1.get_x(), point1.get_y(), W, H);}
    public void new_rect(Point point1, float W, float H, float coner){rect(point1.get_x(), point1.get_y(), W, H, coner);}
    public void new_ellipse(Point centerPoint, float A, float B){ellipse(centerPoint.get_x(), centerPoint.get_y(), A, B);}
    public float new_dist(Point point, float x, float y){ return new_dist(point, new Point(x, y));}
    public float new_dist(float x, float y, Point point){ return new_dist(point, new Point(x, y));}
    public float new_dist(Point point1, Point point2){return dist(point1.get_x(), point1.get_y(), point2.get_y(), point2.get_y());}
    public void new_text(String text, Point point, float w, float h){text(text, point.get_x(), point.get_y(), w, h);}
    public void new_image(PImage img, Point point, float w, float h){image(img, point.get_x(), point.get_y(), w, h);};
}

public class Error {
  
    final float sizeX = 400;
    final float sizeY = 300;
    int errorTime;
    
    String errorMessage;
    
    Rect errorCover;
    Rect errorToast;
    
    public Error(){  // 오류 관리자 생성
        errorCover = new Rect(0, 0, width,  height);
        errorCover.isFill = true;
        errorCover.fillColor = color(150,150,150,150);
        errorCover.strokeColor = color(150,150,150,150);
        errorToast = new Rect(width/2-sizeX/2, height/2-sizeY/2, sizeX, sizeY);
        errorToast.isFill = true;
        errorToast.fillColor = PALETTE.BLUE;  // 테두리 파란색
        errorToast.strokeColor = PALETTE.LIGHT_BLACK;  // 내부 회색
        errorToast.strokeWeight = 15;
    }
    
    void error(String name, String errorMessage){
        this.errorMessage = errorMessage;
        errorTime = 3;
    }
    
    void operater_draw(){
        if(0 < errorTime)
            printError();
    }
    
    void operater_mousePressed(){
        if(0 < errorTime)
        if(errorToast.isMouseOn()){
            errorTime = 0;
        }
    }
   
    public void printError() {  // 오류 내용 출력
        errorCover.sketch();
        errorToast.sketch();
        fill(PALETTE.WHITE);
        textSize(40);
        text(errorMessage, width/2, height/2-sizeY/10*3);
        fill(PALETTE.BLACK);
        textSize(30);
        text("please press this \n to go before", width/2, height/2+sizeY/10*2);
    }
    
    void operater_time_second(){
        timeFlow();
    }
  
    public void timeFlow()
    {
        if(0 < errorTime)
            errorTime--;
    }
}
