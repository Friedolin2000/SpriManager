


public class ComTag extends UseProc {
  
  public ComTag(){
    super();
    
    
    xSize = width / 2;
    
    tagSize = width / 3;
    
    ySaveSize = height / 6;
    ySavePos = height - ySaveSize;
    
    saveTxt = new TextPanel[2];
    saveTxt[0] = new TextPanel("<", 0, ySavePos, xSize, ySaveSize);
    saveTxt[1] = new TextPanel("save", xSize, ySavePos, xSize, ySaveSize);
    
    String[] info = null;
    try{
      info = loadStrings(getTagInfo());
    } catch(Exception e){}
    
    if(info == null){
      info = new String[0];
    }
    
    tags = new Tag[info.length];
    for(int i = 0; i < tags.length; i ++){
      tags[i] = new Tag(info[i]);
    }
    
    tagInd = 0;
  }
  
  float tagSize;
  
  float xSize;
  
  float ySavePos;
  float ySaveSize;
  TextPanel[] saveTxt;
  
  
  float xTagPos;
  int tagInd;
  Tag[] tags;
  
  float xMousePos;
  
  public void render(){
    c(1);
    background(225);
    renderTags();
    
    renderSave();
  }
  
  public void renderTags(){
    for(int y = 0; y < 3; y ++){
      for(int x = 0; x < 4; x ++){
        fill(255);
        rect(xTagPos + x * tagSize, y * tagSize, tagSize, tagSize);
        //new TextPanel((tagInd * 3 + x * 3 + y) + "", xTagPos + x * tagSize, y * tagSize, tagSize, tagSize).render();
        
        try{
          tags[tagInd * 3 + x * 3 + y].render(xTagPos + x * tagSize, y * tagSize, tagSize);
        } catch(Exception e){
          
        }
      }
    }
    
  }
  
  public void renderSave(){
    fill(225);
    rect(0, ySavePos, xSize, ySaveSize);
    rect(xSize, ySavePos, xSize, ySaveSize);
    
    saveTxt[0].render();
    saveTxt[1].render();
  }
  
  public void tickButtons(){
    if(mouseY < width){
      int x = 3 * mouseX / width;
      int y = 3 * mouseY / width;
      try{
        int i = tagInd * 3 + x * 3 + y;
        //printlw Time().toDate() + ": " + i + " (" + mouseX + " " + mouseY);
        tags[i].tick();
        
        coolActivate();
      }catch(Exception e){}
      
    }
    
    if(mouseY > ySavePos){
      if(mouseX < xSize){
        back();
      } else {
        sace();
      }
    }
  }
  
  public void tickPress(){
    if(mouseX < 3 * tagSize){
      //float change = 
      // what is this doing? the moving?
      xTagPos += mouseX - xMousePos;
      if(xTagPos > 0){
        xTagPos -= tagSize;
        tagInd --;
        if(tagInd < 0){
          tagInd ++;
          xTagPos = 0;
        }
      } else if(xTagPos < -tagSize){
        xTagPos += tagSize;
        tagInd ++;
        if(tagInd + 3 > (tags.length - 1) / 3){
          tagInd --;
          xTagPos = -tagSize;
        }
      }
      setDoRender(true);
    
    }
    
    xMousePos = mouseX;
  }
  
  
  public void tickPressStart(){
    xMousePos = mouseX;
  }
  
  public String getTags(){
  String rV = "";
  for(int i = 0; i < tags.length; i ++){
    rV += tags[i].getNameIf(", ");
  }
  return rV;
}
  
  
  
}



public class Tag{
  
  
  public Tag(String info){
    // name:3:2
    //name:disNums:actNums
    //int rand;
    
    sp = info.split(":");
    //printl.length);
    //int left = sp.length;
    folder = null;
    try{
    name = sp[0];
    
    show = false;
    //try{
    if(sp[1].equals("2")){
      show = true;
      folder = sp[4];
    } else if(sp[2].equals("1")){
      show = true;
    }
    
    d = Integer.parseInt(sp[2]);
    a = Integer.parseInt(sp[3]);
    refreshImg();
    
    
    } catch(Exception e){
      
      switch(sp.length){
        case 0:
          name = "";
        case 1:
          show = true;
        case 2:
          d = 1;
        case 3:
          a = 1;
        
      }
      
    }
    
    
  }
  
  //int disNum;
  //int actNum;
  String[] sp;
  
  String name;
  
  String folder;
  
  int d, a;
  PImage dis;
  PImage act;
  
  boolean active;
  
  boolean show;
  
  public void refreshImg(){
    int rand;
    name = sp[0];
    if(sp[1].length() == 0){
      dis = createImage(2, 2, RGB);
    } else {
      rand = (int) random(d);
      //rand = (int) random(Integer.parseInt(sp[1]));
      rand ++;
      dis = loadImage(getTags() + name + rand + ".png");
      //printlis);
      if(dis == null){
        dis = createImage(2, 2, RGB);
      }
    }
    
    if(sp[2].length() == 0){
      act = createImage(2, 2, RGB);
    } else {
      rand = (int) random(a);
      //rand = (int) random(Integer.parseInt(sp[2]));
      rand ++;
      act = loadImage(getTags() + name + "-" + rand + ".png");
      if(act == null){
        act = createImage(2, 2, RGB);
      }
    }
    
  }
  
  public void render(float xPos, float yPos, float size){
    //fill(255);
    //rect(xPos, yPos, size, size);
    
    if(active){
      image(act, xPos, yPos, size, size);
    } else{
      image(dis, xPos, yPos, size, size);
    }
    
    if(show){
      float halfS = size /2;
      if(folder != null){
        halfS = size;
      }
      new TextPanel(name, xPos, yPos + halfS, size, halfS).render();
    }
    
  }
  
  public void tick(){
    //printltive + " changed (" + name);
    active = !active;
    refreshImg();
    useProc.doRender();
  }
  
  public String getNameIf(String betw){
    String rV = "";
    if(active){
      rV = name + betw;
    }
    return rV;
  }
  
  
}



public void sace(){
  Spri s;
  for(int i = 0; i < spris.size(); i ++){
    s = spris.get(i);
    
    s.savePos();
    
  }
  
  String[] info = null;
  try{
    info = loadStrings(getSpriSave());
  } catch(Exception e){}
  if(info == null){
    info = new String[0];
  }
  String[] nev = new String[info.length + 1];
  for(int i = 0; i < info.length; i ++){
    nev[i + 1] = info[i];
  }
  nev[0] = getData();
  //printev[0]);
  saveStrings(getSpriSave(), nev);
  
  
  updatePen();
  
  nextScreen(new Done());
  
  
  
  
}

public void back(){
  //backScreen();
  nextScreen(new Times());
  //useProc = new Done();
}

public String getData(){
  String bar = ":";
  String rV = "";
  rV += new Time().toDate();
  rV += bar;
  rV += "sAm " + spriAmount;
  rV += bar;
  rV += "pen " + spriPen.name + " " + spriPen.left;
  rV += bar;
  Spri s = spris.get(0);
  rV += "spri[" + s.getData();
  //s.savePos();
  println("0: " + s);
  
  for(int i = 1; i < spris.size(); i ++){
    s = spris.get(i);
    rV += "]; [" + s.getData();
    //s.savePos();
    println(i + ": " + s);
  }
  
  rV += "], ";
  
  rV += nevEvents.getData();
  
  /*for(int i = 0; i < events.length; i ++){
    rV += events[i].getIfActivated(", ");
  }*/
  
  rV += bar;
  rV += ((ComTag) useProc).getTags();
  
  return rV;
}

public class Done extends UseProc {
  
  public Done(){
    super();
    
    
    
    counter = new TimeCounter();
    float ySize = 9.0 * width / 16.0;
    counter.setPosSize(0, height / 2.0 - ySize / 2.0, width, ySize);
    counter.setToWait(wait);
    if(sprid != null){
      counter.setStart(sprid);
    }
    
    end = new TimeCounter();
    end.setToWait(new Time(1, 30, 0, 0));
    if(sprid != null){
      end.setStart(sprid);
    }
    
    
    println("DONE CONSTRUCTED Done constructed");
  }
  
  TimeCounter counter;
  
  TimeCounter end;
  
  public void render(){
    c(2);
    background(225);
    println("render");
    
    counter.render();
  }
  
  public void tick(){
    
    if(sprid == null){
      // TODO go to startScreen
      reset();
      return;
    }
    
    println("tick");
    counter.tick();
    
    end.tick();
    if(!end.isCounting()){
      reset();
    }
    doRender();
  }
  
  public void tickButtons(){
    reset();
    
  }
}


public void updatePen(){
  
  String nr = "l3m";
  if(isNR){
    nr = "nr";
  }
  
  
  FileManager f;
  f = new FileManager("/Dia/baseValues/spri/" + nr + "/cur/" + spriPen.name + ".txt");
  //f.addString(getData(), true);
  
  int actLeft = spriPen.left;
  //actLeft = Integer.parseInt(f.getVar("left", spriPen.left + ""));
  
  int rnLeft = actLeft;
  
  for(int i = 0; i < spris.size(); i ++){
    if(spris.get(i).isSprid()){
      actLeft -= spris.get(i).value;
      println(spris.get(i).value + ": " + spris.get(i));
    }
  }
  f.setVal("left", actLeft + "");
  
  
  int leftLog = Integer.parseInt(f.getVar("leftLog", "0"));
  f.setVal("leftLog(" + leftLog + ")", rnLeft + " - " + actLeft);
  f.setVal("leftLog", (leftLog + 1) + "");
  
  
  int spriLog = Integer.parseInt(f.getVar("spriLog", "0"));
  f.setVal("spriLog(" + spriLog + ")", getData());
  f.setVal("spriLog", (spriLog + 1) + "");
  
  int actNeedle = Integer.parseInt(f.getVar("needle", spriPen.needle + ""));
  if(nevEvents.get("removeNeedle").isTimeSet()){
    actNeedle = 0;
  } else {
    actNeedle ++;
  }
  f.setVal("needle", actNeedle + "");
  
  
  if(actLeft <= 0){
    new FileManager("/Dia/baseValues/spri/" + nr + "/used/" + spriPen.name + ".txt"
    ).setStrings(f.getStrings());
    f.delete();
    
    
    
  }
  
  
  
  // info.txt --------------
  
  f = new FileManager("/Dia/baseValues/spri/" + nr + "/cur/info.txt");
  String[] info = f.getStrings();
  boolean after = false;
  String[] sp;
  if(actLeft > 0){
    for(int i = 0; i < info.length; i ++){
      sp = info[i].split(":");
      
      if(sp[0].equals(spriPen.name)){
        
        sp[1] = actLeft + "";
        sp[2] = actNeedle + "";
        
        info[i] = sp[0] + ":" + sp[1] + ":" + sp[2];
        try{
          info[i] += ":" + sp[3];
        } catch(Exception e){
          
        }
        
        break;
      }
    }
    
    
  } else {
    
    int sub = 1;
    if(spriPen.name.equals("noPenSet")){
      sub = 0;
    }
    // removes the pen
    after = false;
    String[] old = info;
    info = new String[old.length - sub];
    
    for(int i = 0; i < info.length; i ++){
      if(!after){
        sp = old[i].split(":");
        if(sp[0].equals(spriPen.name)){
          after = true;
          new FileManager("/Dia/baseValues/spri/" + nr + "/used/info.txt")
          .addString(old[i], true);
        }
      }
      
      if(after){
        info[i] = old[i + 1];
      } else {
        info[i] = old[i];
      }
      
    }
    
    
  }
  
  f.setStrings(info);
  
  
  
  
  
}


public void reset(){
  delAutoSave();
  println("resetInDone");
  
  
  setup();
  c(0);
  //nevEvents = null
  spriPen = null;
  spris = null;
  sprid = null;
  nextScreen(new Selection());
  
  
}

