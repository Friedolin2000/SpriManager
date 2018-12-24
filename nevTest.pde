
public class TestSpri extends Spri {
  
  
  public void savePos(){}
  
  public String autoSave(){
    String rV = standard("0");
    rV += bar;
    rV += rad.getLine();
    rV += bar;
    rV += autoSaveTime(testT);
    
    rV += bar;
    rV += ""; // ininfo
    
    
    return rV;
  }
  
  //EventManager events;
  
  public TestSpri(String autoSave){
    this();
    String[] sp = autoSave.split(bar);
    int ind = doStandard(autoSave);
    
    rad.setLine(Float.parseFloat(sp[ind]));
    ind ++;
    
    testT = loadAutoSaveTime(sp[ind]);
    ind ++;
    // TODO added = true?
    
    added = true;
  }
  
  float xPos;
  
  public TestSpri(){
    super(0, -1);
    
    
    
    //setAfterNextRender(true);
    
    //strokeWeight(4);
    drops = new ArrayList<Drop>();
    
    float ySize = height / (3.0 + 2.0);
    
    rad = new RadioButton();
    rad.setTxt("Strahl");
    rad.setPosSize(0, 3.0 * ySize, width, ySize);
    rad.setLine(50);
    
    sace = new Button[]{
      new Button().setTxt("<"),
      //new Button().setTxt("change"),
      new Button().setTxt("save")
      
      
    };
    
    yPos = height - ySize;
    float xSize = width / sace.length;
    for(int i = 0; i < sace.length; i ++){
      sace[i].setPosSize(i * xSize, yPos, xSize, ySize);
      
    }
    
    yPos -= ySize; // for line
    
    events = new EventManager();
    
    eves = new Event[]{
      events.get("1"),
      events.get("2")
      
    };
    
    xPos = 5.0 * width / 7.0;
    for(int i = 0; i < eves.length; i ++){
      eves[i].setPosSize(0, i * ySize, xPos, ySize);
    }
    
    but = new Button();
    but.setTxt("change");
    but.setPosSize(0, eves.length * ySize, xPos, ySize);
    
    
    
  }
  
  public boolean isSprid(){
    
    
    return added;
  }
  
  float yPos;
  
  boolean added;
  
  
  RadioButton rad; // saved
  Button[] sace; // dont save
  
  Button but; // dont dace
  Event[] eves; // dont savw
  
  Time testT; // ?
  
  public String getData(){
    String rV = value + ", ";
    //rV += testT.toTime(true) + ", ";
    
    rV += events.getData() + ", ";
    
    rV += "t(" + (100.0 - rad.getLine()) + ")";
    return rV;
  }
  
  public void render(){
    if(pos != -1){
      c(8, pos);
    } else {
      c(10);
    }
    
    for(int i = 0; i < sace.length; i ++){
      sace[i].render();
    }
    
    for(int i = 0; i < eves.length; i ++){
      eves[i].render();
    }
    
    but.render();
    
    renderLine();
    strokeWeight(1);
    
    
    rad.setTxt("stream: " + (100 - rad.getLine()));
    rad.render();
    //rad.afterRender();
    
    
    
  }
  
  public void tickPress(){
    rad.tickPress();
    
  }
  
  public void tickRelease(){
    rad.tickRelease();
    autoSave();
  }
  
  public void tickButtons(){
    for(int i = 0; i < sace.length; i ++){
      if(sace[i].tickButton()){
        if(sace[i].getTxt().equals("<")){
          next();
        } else if(sace[i].getTxt().equals("save")){
          
          next();
        }
        
      }
    }
    
    if(but.tickButton()){
      
      
      nextScreen(new SpriSelec());
    }
    
    
    for(int i = 0; i < eves.length; i ++){
      if(eves[i].tickButton()){
        carryOn = eves[i].getTxt();
        onBackScreen();
        
        
      }
    }
    
    
    
  }
  
  
  
  public void next(){
    
    testT = eves[0].getTime();
    println("in next");
    if(testT != null){
      value = Integer.parseInt(eves[0].getTxt());
      println("val: " + value);
    }
    
    if(value > 0 && !added){
      added = true;
      
      
      
      //time.put("got", new Time());
      // TODO timehabdeling
      // -> do I need that?
      
      pos = spris.size();
      
      spris.add(this);
    }
    backScreen();
    println("what about " + value);
  }
  
  public String getRender(){
    println(testT);
    String rV = "tested " + value + " (" + testT.toTime() + ")";
    
    return rV;
  }
  
  
  
  
  
  public void renderLine(){
    
    stroke(0);
    fill(255);
    rect(xPos, 0, width - xPos, yPos);
    
    
    
    
    for(int i = 0; i < drops.size(); i ++){
      try{
      if(
      drops.get(i).tick(yPos, drops.get(i + 1))){
        drops.remove(i);
        i --;
        continue;
      }
      } catch(Exception e){
        if(drops.get(i).tick(yPos, null)){
          drops.remove(i);
          i --;
          continue;
        }
      }
      
      drops.get(i).render();
      
      
    }
    
    strokeWeight(1);
    
  }
  
  ArrayList<Drop> drops;
  
  
  public void tick(){
    
    // getLine() / 8 was good
    // kleiner is mehr line?
    
    
    if(rad.getLine() == 0 || makeDrop(rad.getLine())){
      drops.add(new Drop());
    }
    
    renderLine(); // is act just the bg
    
    
    
    //renderLine();
    
  }
  
  
  public void onBackScreen(){
    
    eves = new Event[]{
      events.get(carryOn)
      
    };
    
    float ySize = 3.0 * height / 5.0;
    ySize /= 2.0;
    
    eves[0].setPosSize(0, 0, xPos, ySize);
    but.setPosSize(0, ySize, xPos, ySize);
    doRender();
    super.onBackScreen();
  }
  
}


public class Drop {
  
  public Drop(){
    this.x = 6.0 * width / 7.0;
    this.size = 16;
    
    ac = 0.18;
    v = 0;
    y = 0;
    
    
    
    with = 4;
    
  }
  
  float ac;
  float v;
  float y;
  
  
  float x;
  float size;
  
  float with;
  
  
  
  public boolean tick(float yPos, Drop a){
    
    y += v;
    v += ac;
    
   // try{
      
      //size = 1.0 / (y - a.y - size / 2.0 - a.size / 2.0);
      
      
      
      // -> size * with = A
      // A = 4 * 4 = 16
      
      // size = sth with 1/x
      if(a == null){
        a = new Drop();
      }
      
      size = getSize(y, a.y);
      
      
      
      
      /*
      
        1 = contante -> wie nah zum connecten...
        
        eng -> 1/0
        con -> 1/1
        far -> 1/infinity
        
        
        
        size = wie viel geht.
        0 = 16 //-dann max 16
        infinit = 4 //-wenn unendlich gehts richtung size = with -> 4
        
        e^(-x) * 16 + 4
        
        -> but monoton fallend mit steigendem gefàlle
        not schwàcher werdendem
        
        x >= 0
        
        16 - e^x * 4
        but x <= 0
        
        1/e^x + 1
        
      */
      
      
      
   // } catch(Exception e){}
    
    if(size > yPos - y){
      if(y - 2 > yPos){
        return true;
      } else {
        size = yPos - y;
      }
      
    }
    
    with = dropSize / size;
    
    //if(
    return false;
  }
  
  public void render(){
    stroke(0);
    fill(0);
    strokeWeight(with);
    line(x, y, x, y + size);
    
    
    
  }
}


public boolean makeDrop(float line){
  float xx = 100.0 - line;
  float nextDrop = ((((stromung[1] - stromung[0]) / 100.0) * xx + stromung[0]) / xx);
  return frameCount % nextDrop < 1;
}

float stromung[] = new float[]{1000, 100};


public float getSize(float y, float ay){
  float xx = y - ay;
  if(xx < 0){
    xx = 0;
  }
  // sigmoid
  //xx = exp(xx - 64);
  // 1/e^-x + 1
  
  
  xx = intervalEnd(xx, li, 100) * xx / li
     + intervalStart(xx, li, 100) / (exp((xx - julian) / 8.0) + 1.0);
  
  if(xx > 1.0){
    //xx = 1;
  }
  
  //xx = 0;
  
  return dropSide + xx * (dropSize - dropSide);
}

float dropSide = 4;
float dropSize = dropSide * dropSide;

float li = 24;
float julian = 64.0;
