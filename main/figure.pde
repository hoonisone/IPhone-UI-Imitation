
public abstract class Figure {
  
    float JUDGE_RANGE = 3;  // 도형의 범위를 고려할 때 여유값에 해당한다.
    
    protected float x, y, w, h;
  
    protected boolean isFill = false;
    protected color fillColor = PALETTE.BLACK;
    
    protected boolean isStroke = true;
    protected color strokeColor = PALETTE.BLACK;
    protected float strokeWeight = 5;
  
    protected float rotate = 0;
    
    protected boolean isText = false;
    protected color textColor = PALETTE.BLACK;
    protected float textSize = 30;
    protected String text = null;
    
    protected boolean onLeft = false; 
    protected boolean onRight = false;
    protected boolean onTop = false;
    protected boolean onBottom = false;
    protected boolean onIn = false;
    
    protected boolean isPressed = false;

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////    constructer    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    public Figure(Point point, float w, float h) {  // 도형 생성자
      
        this.x = point.get_x();
        this.y = point.get_y();
        this.w = w;  // 도형이 이루는 영역의 너비
        this.h = h;  // 도형이 이루는 영역의 높이
    }
    
    public Figure(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////   abstract menu   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    abstract void sketch();  // 도형을 그린다.
    abstract boolean isMouseOn();  // 마우스가 도형위에 놓여있는지 판단.
    abstract boolean isPointOn(Point point);  // 특정한 점이 도형위에 놓여있는지 판단.  
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////      set menu     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    void set_point            (float x, float y){set_x(x); set_y(y);}  
    void set_x                (float x){this.x = x;}
    void set_y                (float y){this.y = y;}
    void set_w                (float w){this.w = w;}
    void set_h                (float h){this.h = h;}  
    
    void set_isFill           (boolean isFill){this.isFill = isFill;}  
    void set_fillColor        (color fillColor){this.fillColor = fillColor;}  
    
    void set_isStroke         (boolean isStroke){this.isStroke = isStroke;}  
    void set_strokeColor      (color strokeColor){this.strokeColor = strokeColor;}
    void set_strokeWeight     (float strokeWeight){this.strokeWeight = strokeWeight;}  
    
    void set_rotate           (float rotate){this.rotate = rotate;} 
    
    void set_isText           (boolean isText){this.isText = isText;}
    void set_text             (String text){this.text = text;}
    void set_textColor        (color c){this.textColor = c;}
    void set_textSize         (float textSize){this.textSize = textSize;}
    
    void set_onLeft           (boolean onLeft){ this.onLeft = onLeft;}
    void set_onRight          (boolean onRight){ this.onRight = onRight;}
    void set_onTop            (boolean onTop){ this.onTop = onTop;}
    void set_onBottom         (boolean onBottom){ this.onBottom = onBottom;}
    void set_onIn             (boolean onIn){ this.onIn = onIn;}
    
    void set_isPressed        (boolean isPressed){this.isPressed = isPressed;}
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////      set menu +   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////      get menu     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Point get_point()          {return new Point(x, y);}
    float get_x()              {return x;}
    float get_y()              {return y;}
    float get_w()              {return w;}
    float get_h()              {return h;}
    
    color get_fillColor()      {return fillColor;}
    
    boolean get_isFill()       {return isFill;}
    boolean get_isStroke()     {return isStroke;}
    color get_strokeColor()    {return strokeColor;}
    float get_strokeWeight()   {return strokeWeight;}
    
    float get_rotate()         {return rotate;}
    
    String get_text()          {return text;}
    color get_textColor()      {return textColor;}
    float get_textSize()       {return textSize;}
    
    boolean get_onLeft()       {return onLeft;}
    boolean get_onRight()      {return onRight;}
    boolean get_onTop()        {return onTop;}
    boolean get_onBottom()     {return onBottom;}  
    boolean get_onIn()         {return onIn;}
    
    boolean get_isPressed()    {return isPressed;}
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////     get menu +   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Point getCenterPoint()     {return new Point(x+w/2, y+h/2);}// 중심 좌표 반환
    
    Point getPoint_LT()        {return new Point(x  , y  );}             // 왼쪽 위 좌표 반환
    Point getPoint_LB()        {return new Point(x  , y+h);}  // 왼쪽 아래 좌표 반환
    Point getPoint_RT()        {return new Point(x+w, y  );}  // 오른쪽 위 좌표 반환
    Point getPoint_RB()        {return new Point(x+w, y+h);}  // 오른쪽 아래 좌표 반환
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////      fuction      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public void set_relationBtweenMouse() {  // 마우스 클릭시 도형과 마우스 간의 위치 관계 설정
        Point rotatePoint = rotatePoint(new Point(mouseX, mouseY));
        float pointX = rotatePoint.get_x();  // 회전을 고려한 점의 x좌표
        float pointY = rotatePoint.get_y();  // 회전을 고려한 점의 y좌표
   
        onLeft = onRight = onTop = onBottom = false;
        onIn = true;
        
        if (  (x-JUDGE_RANGE <= pointX)  &&  (pointX <= x+JUDGE_RANGE)  ) {  // 왼쪽 잡아당김
            onLeft = true;
            onIn = false;
        }
        else if (  (x+w-JUDGE_RANGE <= pointX)  &&  (pointX <= x+w+JUDGE_RANGE)  ) {  // 오른쪽 잡아당김
            onRight = true;
            onIn = false;
        }
    
        if (  (y-JUDGE_RANGE <= pointY)  &&  (pointY <= y+JUDGE_RANGE)  ) {  // 위쪽 잡아당김
            onTop = true;
            onIn = false;
        }
        else if (  (y+h-JUDGE_RANGE <= pointY)  &&  (pointY <= y+h+JUDGE_RANGE)  ) {  // 아래쪽 잡아당김
            onBottom = true;
            onIn = false;
        }
    
        if (onIn) {
            if (isMouseOn())
                onIn = true;
            else
                onIn = false;
        }
    }
  
    public void isMouseDragged() {  // 마우스 드레그를 통해 도형 이동, 크기 전환
        isMouseDragged(onIn, onLeft, onRight, onTop, onBottom);
    }
    
    public void isMouseDragged(boolean onIn, boolean onLeft, boolean onRight, boolean onTop, boolean onBottom) {  // 마우스 드레그를 통해 도형 이동, 크기 전환
        
        if(onIn){
            this.x += (mouseX-pmouseX);
            this.y += (mouseY-pmouseY);
        }
        else{
            if(onLeft){
                this.x += mouseX-pmouseX;
                w -= (mouseX-pmouseX);
            }
            else if(onRight){
                w += (mouseX-pmouseX);
            }
            
            if(onTop){
                this.y += mouseY-pmouseY;
                h -= (mouseY-pmouseY);
            }
            else if(onBottom){
                h += (mouseY-pmouseY);
            }
        }
    }
    
    boolean isPointOn(float x, float y){
        return isPointOn(new Point(x, y));
    }
    
    void printText(){  // 텍스트 출력 함수
        if(isText){
            if(text != null){
                pushMatrix();  // 좌표계 기억
                NEW.new_translate(getCenterPoint());  // 좌표계 이동
                rotate(radians(rotate));  // 좌표계 회전
                PALETTE.setting_text(textSize, textColor);
                NEW.new_text(text, get_point().minus(getCenterPoint()),w,h);  // 도형 안에 텍스트 넣기
                popMatrix();  // 좌표계 반환
            }
        }
    }
    
    void move(Point point){move(point.get_x(), point.get_y());}
    void move(float x, float y){
        this.x += x;
        this.y += y;
    }
    
  
    void moveTo(Point point) {moveTo(point.get_x(), point.get_y());}
    void moveTo(float x, float y){
        this.x = x-w/2;
        this.y = y-h/2;
    }
  
    void paintRange() {  //도형의 범위를 나타낸다.
        noFill();
        stroke(0);
        strokeWeight(2);
    
        pushMatrix();
        NEW.new_translate(getCenterPoint());
        rotate(radians(rotate));
        NEW.new_rect(get_point().minus(getCenterPoint()), w, h);  // 사각형 범위 표시

        
        fill(255);
        stroke(0);
        strokeWeight(2);
        new Point(x, y).minus(getCenterPoint()).sketch(5);  // 범위 사각형 위에 드래그 점 표시
        new Point(x+w, y).minus(getCenterPoint()).sketch(5);
        new Point(x+w, y+h).minus(getCenterPoint()).sketch(5);
        new Point(x, y+h).minus(getCenterPoint()).sketch(5);
        new Point(x+w/2, y).minus(getCenterPoint()).sketch(5);
        new Point(x+w, y+h/2).minus(getCenterPoint()).sketch(5);
        new Point(x+w/2, y+h).minus(getCenterPoint()).sketch(5);
        new Point(x, y+h/2).minus(getCenterPoint()).sketch(5);
        popMatrix();
    }
    
    boolean isInRange(Rect range){  // 사각형 안에 도형이 있는지 판단.
        if(range.isPointOn(rotatePoint(getPoint_LT())))
        if(range.isPointOn(rotatePoint(getPoint_LB())))
        if(range.isPointOn(rotatePoint(getPoint_RT())))
        if(range.isPointOn(rotatePoint(getPoint_RB())))  
            return true;
        return false;
    }
    
    Point rotatePoint(Point point) {  // 중심좌표로 부터 원하는 각 만큼 회전된 좌표를 계산하여 Point로 반환
      float x = point.get_x();
      float y = point.get_y();
      float centerX = getCenterPoint().get_x();
      float centerY = getCenterPoint().get_y();
  
      float dist = dist(x, y, centerX, centerY);  // 점과 중심점 사이의  거리를 계산한다.
      float angle = acos((x - centerX)/dist);  // 점과 중심 점이 이루는 각을 계산한다.
  
      if ((y-centerY)>0)  // sin값을 이용하여  acos()을 일대일 함수처럼 사용할 수 있다.
          angle = 2*PI-angle;
  
      float rotateX = centerX+dist*cos(-angle-radians(rotate));  // 회전된 x좌표
      float rotateY = centerY+dist*sin(-angle-radians(rotate));  // 회전된 y좌표
      return new Point(rotateX, rotateY);  // 좌표를 중심으로 부터 회전시켜서 반환
  }
}




public class Point {

    final float JUDGE_RANGE = 3;  // 범위 판단 여유 값
  
    private float x;  // w좌표
    private float y;  // y좌표
    private float size = 3;
  
    public Point()                  {setPoint(0, 0);}
    public Point(float x, float y)  {setPoint(x, y);}
    public Point(Point point)       {setPoint(point);}
    
    void setPoint(Point point)      {setPoint(point.get_x(), point.get_y());}
  
    void setPoint(float x, float y) {
        this.x = x;
        this.y = y;
    }
  
    void set_x(float x)             {this.x = x;}
    void set_y(float y)             {this.y = y;}
  
    float get_x()                   {return x;}
    float get_y()                   {return y;}
  
    boolean isPointOn(float x, float y) {return isPointOn(new Point(x, y));}
    boolean isPointOn(Point point) {  // 어떤 점의 좌표가 점 위에 있는지 판단.
        if (dist(this.x, this.y, point.get_x(), point.get_y())<=JUDGE_RANGE)
            return true;
        return false;
    }
    
    void addition(float x, float y) {addition(new Point(x,y));}  // 점에 벡터를 더함
    void addition(Point point) {
        x += point.get_x();
        y += point.get_y();
    }
  
    void subtraction(float x, float y) {subtraction(new Point(x,y));}  // 점의 좌표에 벡터를 뺌
    void subtraction(Point point) {
        x -= point.get_x();
        y -= point.get_y();
    }
  
    Point plus(Point point) { return new Point(x+point.get_x(), y+point.get_y());}
    Point plus(float x, float y) {return new Point(this.x+x, this.y+y);}
    
    Point minus(Point point) {return new Point(x-point.get_x(), y-point.get_y());}
    Point minus(float x, float y) {return new Point(this.x-x, this.y-y);}
    
    void sketch(float size) {ellipse(x, y, 2*size, 2*size);}
    
    Point getMousePoint(){return new Point(mouseX, mouseY);}
}

public class Rect extends Figure {

    public Rect(Point point, float w, float h) {  // 직사각형 생성자.
        super(point, w, h);
    }
  
    public Rect(float x, float y, float w, float h) {
        super(new Point(x, y), w, h);
    }
  
  
    @Override
    void sketch() {  // 직사각형 그리기
        pushMatrix();  // 좌표계 기억
        NEW.new_translate(getCenterPoint());  // 좌표계 이동
        rotate(radians(get_rotate()));  // 좌표계 회전
        PALETTE.setting_pen(isFill, isStroke, fillColor, strokeColor, strokeWeight);  // 펜 설정
        NEW.new_rect(get_point().minus(getCenterPoint()), w, h);  // 직사각형 그리기
        popMatrix();  // 좌표계 반환
    
        printText(); // 텍스트 출력
    }
  
    @Override
    boolean isMouseOn() {  // 마우스가 도형위에 있는지 판단
        return isPointOn(new Point(mouseX, mouseY));
    }
  
    @Override
    boolean isPointOn(Point point) {  //판단할 점의 좌표, 범위가 될 사각형, 회전 각
      
        Point rotatePoint = rotatePoint(point);  // 회전을 고려한 점의 좌표
      
        float rotateX = rotatePoint.get_x();  // x좌표
        float rotateY = rotatePoint.get_y();  // y좌표
    
        if (x <= rotateX && rotateX <= x+w)
        if (y <= rotateY && rotateY <= y+h)
            return true;
        return false;
    }
}

public class Ellipse extends Figure {
  
    public Ellipse(Point point, float w, float h) {
        super(point, w, h);
    }
  
    public Ellipse(float x, float y, float w, float h) {
        super(new Point(x, y), w, h);
    }
  
    @Override
        void sketch() {
        pushMatrix();  // 좌표계 기억
        NEW.new_translate(getCenterPoint());  // 좌표계 이동
        rotate(radians(rotate));  // 좌표계 회전
        PALETTE.setting_pen(isFill, isStroke, fillColor, strokeColor, strokeWeight);  // 펜 설정
        NEW.new_ellipse(new Point(0, 0), w, h);  // 타원 그리기
        popMatrix();  // 좌표계 반환
    
        printText(); // 텍스트 출력
    }
  
    @Override
    boolean isMouseOn() {
        return isPointOn(new Point(mouseX, mouseY));
    }
  
    @Override
    boolean isPointOn(Point point) {  // 특정 점이 도형위에 있는지 판단
        float a = w/2;
        float b = h/2;
    
        Point centerPoint = getCenterPoint();  // 중점의 죄표 구하기
        float centerX = centerPoint.get_x();
        float centerY = centerPoint.get_y();
    
        Point rotatePoint = rotatePoint(point);  // 회전된 좌표 구하기
        float rotateX = rotatePoint.get_x();
        float rotateY = rotatePoint.get_y();
        if (sq(rotateX-centerX)*b*b + sq(rotateY-centerY)*a*a <= a*a*b*b)  // 타원의 방정식을 이용
            return true;
        return false;
    }
}

public class Triangle extends Figure {
  
    public Triangle(Point point, float w, float h) {
        super(point, w, h);
    }
  
    public Triangle(float x, float y, float w, float h) {
        super(new Point(x, y), w, h);
    }
  
    @Override
    void sketch() { 
        pushMatrix();  // 좌표게 기억
        NEW.new_translate(getCenterPoint());  // 좌표계 이동
        rotate(radians(rotate));  // 좌표계 회전
        PALETTE.setting_pen(isFill, isStroke, fillColor, strokeColor, strokeWeight);  // 펜 설정
        NEW.new_triangle(getPoint1().minus(getCenterPoint()), getPoint2().minus(getCenterPoint()), getPoint3().minus(getCenterPoint()));  //삼각형 그리기
        popMatrix();  // 좌표계 반환
    
        printText(); // 텍스트 출력
    }
  
    @Override
    boolean isMouseOn() {    // 마우스가 도형위에 있는지 판단
        return isPointOn(new Point(mouseX, mouseY));
    }
  
    @Override
    boolean isPointOn(Point point) {  // 특정 점이 도형위에 있는지 판단
        point = rotatePoint(point);  // 선분의 중심을 기준으로 회전한 점을 구한다.
        Line line1 = new Line(getPoint1(), getPoint2());  // 선분 1
        Line line2 = new Line(getPoint2(), getPoint3());  // 선분 2
        Line line3 = new Line(getPoint3(), getPoint1());  // 선분 3
        if (line1.isPointIn(point, getCenterPoint()))  // 선분 1 안쪽에 있는가?
        if (line2.isPointIn(point, getCenterPoint()))  // 선분 2 안쪽에 있는가?
        if (line3.isPointIn(point, getCenterPoint()))  // 선분 3 안쪽에 있는가?
            return true;
        return false;
    }
  
    Point getPoint1() {
        return new Point(x, y+h);
    }
  
    Point getPoint2() {
        return new Point(x+w/2, y);
    }
  
    Point getPoint3() {
        return new Point(x+w, y+h);
    }
}

public class Line extends Figure {

    public Line (Point point, float w, float h) {
        super(point, w, h);
    }
  
    public Line(float x, float y, float w, float h) {
        super(new Point(x, y), w, h);
    }
  
    public Line (Point point1, Point point2) {
        super(point1, point2.get_x() - point1.get_x(), point2.get_y() - point1.get_y());
    }
  
    @Override
    void sketch() {
        pushMatrix();
        NEW.new_translate(getCenterPoint());
        rotate(radians(rotate));
        PALETTE.setting_pen(isFill, isStroke, fillColor, strokeColor, strokeWeight);
        NEW.new_line(new Point(-w/2, -h/2), new Point(w/2, h/2));
        popMatrix();
    
        printText(); // 텍스트 출력
    }
  
    @Override
    boolean isMouseOn() {  // 마우스가 도형위에 있는지 판단
        return isPointOn(new Point(mouseX, mouseY));
    }
  
    @Override
    boolean isPointOn(Point point) {  // 특정 점이 도형위에 있는지 판단  => 선분의 경우 직선을 덮고있는 두 직선과 직선으로부터 떨어진 거리를 통해 계산한다.
        Point centerPoint = getCenterPoint();
        Point point1 = getPoint1();
        Point point2 = getPoint2();
    
        point = rotatePoint(point);  // 선분의 중심을 기준으로 회전한 점을 구한다.
    
        float range = strokeWeight/2+JUDGE_RANGE;
        float theta;
    
        if (abs(w)<1)
            theta = PI/2;
        else
            theta = atan(h/w);
    
        Point point1_1 = point1.plus(new Point(range*sin(theta), -range*cos(theta)));  // 직선1의 점1
        Point point1_2 = point2.plus(new Point(range*sin(theta), -range*cos(theta)));  // 직선1의 점2
        Point point2_1 = point1.plus(new Point(-range*sin(theta), range*cos(theta)));  // 직선2의 점1
        Point point2_2 = point2.plus(new Point(-range*sin(theta), range*cos(theta)));  // 직선2의 점2
    
        Line line1 = new Line(point1_1, point1_2);  // 직선 1
        Line line2 = new Line(point2_1, point2_2);  // 직선 2
    
        if (line1.isPointIn(point, centerPoint))  // 직선 1 안에 있는가?
        if (line2.isPointIn(point, centerPoint))  // 직선 2 안에 있는가?
        if (NEW.new_dist(centerPoint, point) <= NEW.new_dist(centerPoint, point1)+range)
                return true;
        return false;
    }
  
    boolean isPointIn(Point point, Point stdPoint) {//  계산할 좌표, 기준좌표, 직선의 방정식을 나타낼 직선위의 두 좌표
        float x = point.get_x();  //  직선의 기준좌표
        float y = point.get_y();
    
        float stdX = stdPoint.get_x();  // 판단의 기준 좌표(내부의 위치를 판단.)
        float stdY = stdPoint.get_y();
    
        float X = this.x;  // 직선에 대한 정보들
        float Y = this.y;
    
        float m = h/w;  // 기울기
    
        if ((stdY-Y) > m*(stdX-X)) {  // 직선의 방정식을 이용해서 판단
            if ((y-Y) > m*(x-X))
                return true;
            else
                return false;
        } else {
            if ((y-Y) < m*(x-X))
                return true;
            else
                return false;
        }
    }
  
    Point getPoint1() {  // 직선의 첫번재 점을 반환
        return new Point(x, y);
    }
  
    Point getPoint2() {  // 직선의 두번째 점을 반환
        return new Point(x+w, y+h);
    }
}
