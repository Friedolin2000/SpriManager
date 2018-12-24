

public class Countdown extends Button{
  
  public Countdown(){
    super();
    
    setCountCol(color(255, 0, 0));
    setState(1);
    setMax(2);
    
    setTimeFormat(format_state_max_minus);
    setTimePos(timePos_middle);
    setInteger(true);
    
  }
  
  
  public Countdown setCountCol(int col){
    this.countCol = col;
    return this;
  }
  
  public Countdown setState(float state){
    this.state = state;
    return this;
  }
  
  public Countdown setMax(float max){
    this.max = max;
    return this;
  }
  
  
  public Countdown setTimeFormat(String format){
    this.timeFormat = format;
    return this;
  }
  
  public Countdown setTimePos(int timePos){
    this.timePos = timePos;
    return this;
  }
  
  public Countdown setInteger(boolean real){
    this.format_int = real;
    return this;
  }
  
  public String format_state = "num";
  public String format_state_max = "num / max";
  public String format_state_minus = "minus";
  public String format_state_max_minus = "minus / max";
  public boolean format_int;
  
  public int timePos_full = 0;
  public int timePos_middle = 1;
  
  int countCol;
  
  float state, max;
  
  String timeFormat;
  
  int timePos;
  
  //float xFormatPos, yFormatPos, xFormatSize, yFormatSize;
  
  public void render(){
    renderSuper();
    renderBar();
    renderTime();
    
    
  }
  
  public void renderSuper(){
    super.render();
  }
  
  public void renderBar(){
    float size = state * xSize / max;
    if(size < 0){
      size = 0;
    } else if(size > xSize){
      size = xSize;
    }
    
    fill(countCol);
    rect(xPos, yPos, size, ySize);
    
  }
  
  
  public void renderTime(){
    String txt = "";
    String st = state + "";
    String ma = max + "";
    String mi = (max - state) + "";
    if(format_int){
      st = (int) state + "";
      ma = (int) max + "";
      mi = (int) (max - state) + "";
    }
    
    if(timeFormat.equals(format_state)){
      txt = st;
    } else if(timeFormat.equals(format_state_max)){
      txt = st + " / " + ma;
    } else if(timeFormat.equals(format_state_minus)){
      txt = mi;
    } else if(timeFormat.equals(format_state_max_minus)){
      txt = mi + " / " + ma;
    }
    
    float xFPos, yFPos, xFSize, yFSize;
    xFPos = xPos;
    yFPos = yPos;
    xFSize = xSize;
    yFSize = ySize;
    
    switch(timePos){
      case 0:
        
        break;
      case 1:
        yFSize /= 3;
        yFPos += yFSize;
        break;
      default:
      
    }
    
    new TextPanel(txt, xFPos, yFPos, xFSize, yFSize).render();
    
  }
  
  
  
  
  
  
}

public class TimeCounter extends Countdown{
  
  
  public TimeCounter(){
    super();
    
    setToWait(new Time(1, 0, 0, 0));
    
    
    
    counting = false;
  }
  
  
  public TimeCounter setToWait(Time toWait){
    this.toWait = toWait;
    setMax(toWait.getSecs());
    return this;
  }
  
  public TimeCounter setStart(Time desiredStart){
    start();
    this.start = desiredStart;
    //counting = true;
    end = new Time(start).addTime(toWait);
    return this;
  }
  
  
  public boolean isCounting(){
    return counting;
  }
  
  public boolean tickButton(){
    boolean rV = super.tickButton();
    if(rV){
      start();
    }
    return rV;
  }
  
  public void start(){
    start = new Time();
    counting = true;
    end = new Time(start).addTime(toWait);
  }
  
  Time start;
  Time toWait;
  Time end;
  
  boolean counting;
  public void tick(){
    if(counting){
      long cur = new Time().subTime(start).getSecs();
      
      setState(cur);
      try{
        useProc.doRender();
      } catch(Exception e){}
      
      if(state >= max){
        counting = false;
      }
    }
  }
  
  
  
  public void render(){
    super.render();
    
    try{
      float ySmSize = ySize / 3.0;
      new TextPanel(start.toDate(), xPos, yPos, xSize, ySmSize).render();
      new TextPanel(end.toDate(), xPos, yPos + 2.0 * ySmSize, xSize, ySmSize).render();
      
      
      new TextPanel(txt, xPos, yPos, xSize, ySize).render();
      
      
    } catch(Exception e){}
    
    
    
    
  }
  
  
}