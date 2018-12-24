public class Times extends UseProc{
  
  public Times(){
    super();
    
    
    initSpris();
    
    spriPenName = "setPen";
    
    
    //setAfterNextRender(true);
    
    eventsFirst = new Event[]{
      nevEvents.get("getNeedle").setPoint(false),
      nevEvents.get("getMarker").setPoint(false),
      nevEvents.get("openNeedle"),
      nevEvents.get("setNeedle").setPoint(false)
      //nevEvents("removeNeedle").setPoint(fa
    };
    
    eventsAfter = new Event[]{
      nevEvents.get("removeNeedle")
    };
    
  }
  
  //int firstEvents;
  
  float ySize;
  
  boolean testWasSucces;
  Event[] eventsFirst, eventsAfter;
  
  
  String spriPenName;
  
  
  public void render(){
    c(5);
    try{
      spriPenName = spriPen.name;
    } catch(Exception e){}
    
    ySize = height / (4.0 + spris.size() + eventsFirst.length + eventsAfter.length);
    stroke(128);
    float p = 0;
    fill(220);
    if(spriPenName.equals("setPen")){
      fill(255);
    }
    rect(0, p * ySize, width, ySize);
    new TextPanel(spriPenName, 0, p * ySize, width, ySize).render();
    p ++;
    
    fill(220);
    rect(0, p * ySize, width, ySize);
    new TextPanel("spriAm: " + spriAmount, 0, p * ySize, width, ySize).render();
    p ++;
    
    for(int i = 0; i < eventsFirst.length; i ++){
      eventsFirst[i].setPosSize(0, p * ySize, width, ySize);
      eventsFirst[i].render();
      p ++;
    }
    
    fill(250);
    //if(testWasSucces){  fill(200);}
    rect(0, p * ySize, width, ySize);
    new TextPanel("test", 0, p * ySize, width, ySize).render();
    
    p ++;
    
    for(int i = 0; i < spris.size(); i ++){
      
      if(spris.get(i) instanceof TestSpri || spris.get(i).isSprid()){
        fill(200);
      } else {
        fill(255);
      }
      rect(0, p * ySize, width, ySize);
      new TextPanel(spris.get(i).getRender(), 0, p * ySize, width, ySize).render();
      p ++;
      //spris.get(i).render(j * ySize, ySize);
    }
    
    int bg = 250;
    try{
      if(spriPen.needle < acceptedNeSpris){
        bg = 200;
      }
    } catch(Exception e){}
    nevEvents.get("removeNeedle").setBgCol(bg);
    for(int i = 0; i < eventsAfter.length; i ++){
      eventsAfter[i].setPosSize(0, p * ySize, width, ySize);
      eventsAfter[i].render();
      p ++;
    }
    
    fill(200);
    float yPos = height - ySize;
    float xSize = width / 2;
    rect(0, yPos, xSize, ySize);
    
    new TextPanel("<", 0, yPos, xSize, ySize).render();
    fill(250);
    rect(xSize, yPos, xSize, ySize);
    new TextPanel(">", xSize, yPos, xSize, ySize).render();
  }
  
  
  /*public int avalibleEvents(){
    return 3; // TODO
  }*/
  
  public void tickButtons(){
    int y = (int) (mouseY / ySize);
    if(y < 1){
      nextScreen(new PenSel());
    } else if(y < 2){
      nextScreen(new SetValue());
    } else if(y < eventsFirst.length + 2){
      eventsFirst[y - 2].tickButton();
    } else if(y < eventsFirst.length + 3){
      nextScreen(new TestSpri());
    } else if(y < eventsFirst.length + 3 + spris.size()){
      y -= eventsFirst.length + 3;
      spris.get(y).doRender();
      nextScreen(spris.get(y));
    } else if(y < eventsFirst.length + eventsAfter.length + 3 + spris.size()){
      y -= spris.size() + 3 + eventsFirst.length;
      eventsAfter[y].tickButton();
    } else {
      if(mouseX < width / 2.0){
        nextScreen(new Selection());
      } else {
        if(spriPen != null){
          nextScreen(new ComTag());
        } else {
          spriPen = new Pen("noPenSet", 0, 0, 0);
          doRender();
        }
      }
    }
    
  }
  
}
