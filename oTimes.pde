




/*
public class oTimes extends UseProc{
  
  public oTimes(){
    super();
    
    thread("initSpris");
    
    
    
    setAfterNextRender(true);
    
  }
  
  //int firstEvents;
  
  float ySize;
  
  boolean testWasSucces;
  //Event[] events;
  
  
  public void render(){
    ySize = height / (2 + spris.size() + events.length);
    
    for(int i = 0; i < firstEvents; i ++){
      events[i].setPosSize(0, i * ySize, width, ySize);
      events[i].render();
    }
    
    fill(250);
    if(testWasSucces){
      fill(200);
    }
    rect(0, firstEvents * ySize, width, ySize);
    new TextPanel("test", 0, firstEvents * ySize, width, ySize).render();
    
    int j;
    for(int i = 0; i < spris.size(); i ++){
      j = firstEvents + 1 + i;
      if(spris.get(i) instanceof TestSpri || spris.get(i).isSprid()){
        fill(200);
      } else {
        fill(255);
      }
      rect(0, j * ySize, width, ySize);
      new TextPanel(spris.get(i).getRender(), 0, j * ySize, width, ySize).render();
      //spris.get(i).render(j * ySize, ySize);
    }
    
    for(int i = firstEvents; i < events.length; i ++){
      j = 1 + spris.size() + i;
      //println(i + " " + j);
      events[i].setPosSize(0, j * ySize, width, ySize);
      events[i].render();
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
  }*
  
  public void tickButtons(){
    int y = (int) (mouseY / ySize);
    if(y < firstEvents){
      events[y].tick();
    } else if(y < firstEvents + 1){
      nextScreen(new TestSpri());
    } else if(y < firstEvents + 1 + spris.size()){
      y -= firstEvents + 1;
      spris.get(y).doRender();
      nextScreen(spris.get(y));
    } else if(y < events.length + 1 + spris.size()){
      y -= spris.size() + 1;
      events[y].tick();
    } else {
      if(mouseX < width / 2){
        backScreen();
      } else {
        nextScreen(new ComTag());
      }
    }
    
  }
  
}*/


