public class Spri extends UseProc{
  
  
  public void savePos(){
    //nev[0] = (spriX / ((float) width)) + " " + ((spriY - 4 * ySize) / (2 * ySize)) + " " + info.length;
    Event e = events.get(getRender());
    
    saveSPos((spriX / ((float) width)), ((spriY - 4 * ySize) / (2 * ySize)), value, e.getTime());
    
  }
  
  int pos;
  
  String bar = ";";
  
  public String standard(String bool){
    String rV = bool;
    rV += bar;
    rV += events.autoSave();
    rV += bar;
    rV += value;
    
    // inimfo, spriX, spriY
    
    return rV;
  }
  
  public String autoSave(){
    String rV = standard("1");
    rV += bar;
    rV += spriX;
    rV += bar;
    rV += spriY;
    rV += bar;
    rV += inInfo.autoSave(bar); // ininfo
    
    return rV;
  }
  
  public int doStandard(String autoSave){
    String[] sp = autoSave.split(bar);
    int ind = 0;
    ind ++;
    
    events.loadAutoSave(sp[ind]);
    ind ++;
    
    value = Integer.parseInt(sp[ind]);
    ind ++;
    
    return ind;
  }
  
  public Spri(String autoSave, int pos){
    this(0, pos);
    
    
    String[] sp = autoSave.split(bar);
    int ind = doStandard(autoSave);
    
    spriX = Float.parseFloat(sp[ind]);
    ind ++;
    
    spriY = Float.parseFloat(sp[ind]);
    ind ++;
    
    inInfo.loadAutoSave(sp, ind);
    
  }
  
  
  public Spri(int value, int pos){
    
    
    this.pos = pos;
    
    this.value = value;
    xSize = width / 2.0;
    
    ySize = height / 7.0;
    
    events = new EventManager();
    //time = new HashMap<String, Time>();
    spriPos = ySize * 4;
    
    secs = -1;
    
    
    xOutPos = width / 12;
    yOutPos = 2 * height / 7;
    
    xOutSize = (width - 2 * xOutPos) / 3;
    yOutSize = height / 2.0 - yOutPos;
    
    
    inInfo = new InInfo(this);
    
    
    counter = new TimeCounter();
    counter.setPosSize(0, 0, 0, 0);
    counter.setToWait(new Time(0, 0, 12, 0));
    
    
    thread("loadRecPp");
  }
  
  
  EventManager events;
  //HashMap<String, Time> time;
  //Time done;
  
  float spriX, spriY, spriPos;
  
  float xOutPos, yOutPos, xOutSize, yOutSize;
  
  InInfo inInfo;
  
  int secs;
  
  boolean undo;
  
  int value;
  //boolean tested;
  //float line;
  
  float xSize;
  float ySize;
  
  String mark = " mark  ";
  
  int counting;
  // 0 = nothing; 1 = spriing; 2 = wait; 3 = done
  
  
  TimeCounter counter;
  
  
  public void render(){
    c(8, pos);
    float spriS = width / 60.0;
    
    float yPos = 0;
    try{
      image(belly, 0, yPos, width, 2.0 * ySize);
      image(recPp, 0, yPos, width, 2.0 * ySize);
      // float spriS = width / 60;
      
      stroke(0);
      line(xRecPos - spriS, yRecPos - spriS, xRecPos + spriS, yRecPos + spriS);
      line(xRecPos - spriS, yRecPos + spriS, xRecPos + spriS, yRecPos - spriS);
      
    } catch(Exception e){
      println("E: " + belly);
    }
    
    if(counting > 2){
      new TextPanel(day() + "", 0, yPos, width, 2 * ySize).render();
      
    }
    
    
    yPos = 2 * ySize;
    //float ySize = height / 2;
    fill(255);
    //rect(0, yPos, xSize, ySize);
    //rect(xSize, yPos, xSize, ySize);
    
    events.get("start").render();
    events.get(getRender()).render();
    events.get("done").render();
    
    //new TextPanel(getRender(), 0, yPos, xSize, ySize).render();
    //new TextPanel("done", xSize, yPos, xSize, ySize).render();
    
    
    yPos += ySize;
    events.get(mark).render();
    
    //float ySize = height / 2;
    fill(255);
    //rect(0, yPos, xSize, ySize);
    rect(xSize, yPos, xSize, ySize);
    
    //new TextPanel("mark", 0, yPos, xSize, ySize).render();
    new TextPanel("result", xSize, yPos, xSize, ySize).render();
    
    
    /*
    recPP
    spri, done
    mark, undo
    actPP
    <
    
    */
    try{
      image(belly, 0, spriPos, width, 2 * ySize);
    } catch(Exception e){
      println("E: " + belly);
    }
    
    
    
    
    yPos += 3 * ySize;
    //float ySize = height / 2;
    fill(255);
    rect(0, yPos, xSize, ySize);
    rect(xSize, yPos, xSize, ySize);
    
    new TextPanel("<", 0, yPos, xSize, ySize).render();
    new TextPanel("save", xSize, yPos, xSize, ySize).render();
    
    
    if(events.get(getRender()).isTimeSet()){
      stroke(225, 0, 0);
      //float spriS = width / 60;
      line(spriX - spriS, spriY - spriS, spriX + spriS, spriY + spriS);
      line(spriX - spriS, spriY + spriS, spriX + spriS, spriY - spriS);
      if(mousePressed){
        line(0, spriY, width, spriY);
        line(spriX, 0, spriX, height);
      }
      
      stroke(0);
    }
    
    counter.render();
    
    
    fill(0);
    stroke(0);
    textSize(height / 32.0);
    text(poss.length + "", 0, 0, width, height / 6.0);
    
    
  }
    
    
    
    
  
  
  public void tickRelease(){
    doRender();
  }
  
  public void tickPress(){
    int y = (int) (mouseY / ySize);
    if(y > 3 && y < 6){
      spriX = mouseX;
      spriY = mouseY;
      
      doRender();
    }
  }
  
  public void onBackScreen(){
    inits = false; 
  }
  
  
  boolean inits;
  public void tick(){
    if(inits){
      return;
    }
    
    
    
    float yPos = 2 * ySize;
    float xss = width / 4.0;
    float xs = (width - xss) / 2.0;
    
    events.get("start").setPoint(true).setPosSize(0, yPos, xss, ySize);
    events.get(getRender()).setPosSize(xss, yPos, xs, ySize);
    events.get("done").setPosSize(xss + xs, yPos, xs, ySize);
    
    
    yPos += ySize;
    events.get(mark).setPosSize(0, yPos, xSize, ySize);
    
    
    inits = true;
  }
  
  public void tickButtons(){
    
    
    
    int y = (int) (mouseY / ySize);
    boolean setUndo = false;
    if(y < 2){
      // recPP
      if(mouseX > width / 2.0){
        nextScreen(new SetSpriValue(this, value));
      }
      
    } else if(y < 3){
      if(events.get("start").tickButton()){
        doRender();
      } else if(events.get(getRender()).tickButton()){
        if(counting != 1){
          thread("startSpriHelper");
        }
        sprid = new Time();
        /*
        if(events.get("done").getE("end").isTimeSet() || events.get("done").getE("after").isTimeSet()){
          nextScreen(inInfo);
          inInfo.doRender();
        }*/
        
        doRender();
      } else if(events.get("done").tickButton()){
       // if(time.get("done") == null){
          //time.put("done", new Time());
          
          if(events.get("done").getE("end").isTimeSet() || events.get("done").getE("after").isTimeSet()){
            nextScreen(inInfo);
            inInfo.doRender();
          }//renderInsOut = true;
       // }
        //if(undo){
         // time.put("done", null);
        //}
        doRender();
      }
    } else if(y < 4){
     // if(mouseX < xSize){
      if(events.get(mark).tickButton()){
          //time.put("mark", new Time());
        //}
        //if(undo){
         // time.put("mark", null);
       // }
        doRender();
      } else {
        
        nextScreen(inInfo);
        inInfo.doRender();
        //setUndo = true;
      }
    } else if(y < 6){
      // actPP
    } else{
      
      if(!hasData() && false){// TODO for false: if there is another unused spri? -> del this?
        
      }
      
      nextScreen(new Times());
      
      
      
    }
    if(setUndo){
      undo = true;
    } else {
      undo = false;
    }
    
  }
  
  
  
  public String getRender(){
    String rV = "spri " + value;
    return rV;
  }
  
  
  public String getTimeData(){
    /*String rV = "";
    String[] keys = time.keySet().toArray(new String[0]);
    for(int i = 0; i < keys.length; i ++){
      rV += keys[i] + " " + time.get(keys[i]).toTime(true) + ", ";
    }*/
    return events.getData();
  }
  
  public String getData(){
    String rV = value + ", ";
    rV += getTimeData();
    rV += inInfo.getData();
    //
    if(events.get(getRender()).isTimeSet()){
      rV += ", pos(" + (spriX / ((float) width)) + ", " + ((spriY - 4 * ySize) / (2 * ySize)) + ")";
    }
    return rV;
  }
  
  
  public void spriHelper(){
    counting = 1;
    spriX = width / 2;
    spriY = spriPos + ySize;
    secs = maxSecs;
    
    counter.setSize(width, 2.0 * ySize);
    counter.start();
    // setstuff
    
    //counter =
    
    while(secs > -1){
      counter.tick(); // ?
      doRender();
      SystemClock.sleep(pause);
      secs --;
      
      if(secs == 0){
        vibrate(100);
      } else if(secs == -1){
        vibrate(75);
      } else if(secs == -2){
        vibrate(25);
      }
      //renderCountdown(secs);
      if(events.get("done").isTimeSet()){
        
        break;
      }
    }
    
    counter.setSize(0, 0);
    counting = 3;
    //vibrate(50);
    doRender();
    
  }
  
  
  public boolean isSprid(){
    Event e = events.get(getRender());
    return e.isTimeSet() || events.get("done").isTimeSet();
  }
  
  public boolean hasData(){
    // TODO for false: every other event....: start,
    return isSprid() || events.get("start").isTimeSet();
  }
  
  
}

public void startSpriHelper(){
  ((Spri) useProc).spriHelper();
}

PImage belly;
PImage recPp;
float xRecPos, yRecPos;

public void initSpris(){
  
  int alrSprid = 0;
  if(spris == null){
    spris = new ArrayList<Spri>();
  } else {
    int i = 0;
    while(i < spris.size()){
      if(spris.get(i) instanceof TestSpri || spris.get(i).hasData()){
        if(!(spris.get(i) instanceof TestSpri) && spris.get(i).isSprid()){
          alrSprid += spris.get(i).value;
        }
        i ++;
        
      } else {
        
        spris.remove(i);
      }
    }
    
  }
  
  
  if(isNR){
    
    belly = loadImage(getBelly());
  } else {
    belly = loadImage(getLegs());
  }
  
  
  int num = (spriAmount - alrSprid) / 30;
  if(spriAmount % 30 > 0){
    num ++;
  }
  if(num < 1){
    return;
  }
  int spriAvg = spriAmount / num;
  int extr = spriAmount % num;
  spriAvg ++;
  spriAvg -= alrSprid; // TODO REMOVE THIS IF DOESNT WORK
  
  for(int i = 0; i < num; i ++){
    if(i == extr){
      spriAvg --;
    }
    if(spriAvg > 0){
      spris.add(new Spri(spriAvg, spris.size()));
    }
  }
  
  useProc.doRender();
  
}




int possLen;
