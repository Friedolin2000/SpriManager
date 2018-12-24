public class InInfo extends UseProc{
  
  Spri sup;
  
  public void loadAutoSave(String[] sp, int ind){
    for(int i = 0; i < buts.length; i ++){
      buts[i].setLine(Float.parseFloat(sp[ind]));
      ind ++;
    }
    
    radioBut.loadAutoSave(sp[ind]);
    ind ++;
    
  }
  
  public String autoSave(String bar){
    String rV = "";
    for(int i = 0; i < buts.length; i ++){
      rV += buts[i].getLine();
      rV += bar;
    }
    
    rV += radioBut.autoSave();
    rV += bar;
    
    
    return rV;
  }
  
  public InInfo(Spri sup){
    super();
    
    
    this.sup = sup;
    
    buts = new RadioButton[4];
    navi = new Button[2];
    // 2 extra r for painLvl + 1 for navi
    ySize = height / (buts.length + 3.0);
    float xSize = width / 2.0;
    
    
    buts[0] = new RadioButton();
    buts[0].setTxt("insOut");
    buts[0].setPosSize(0, 0, width, ySize);
    buts[0].setLine(100);
    
    buts[1] = new RadioButton();
    buts[1].setTxt("bloodOut");
    buts[1].setPosSize(0, ySize, width, ySize);
    buts[1].setLine(100);
    
    buts[2] = new RadioButton();
    buts[2].setTxt("bump");
    buts[2].setPosSize(0, 2.0 * ySize, width, ySize);
    buts[2].setLine(100);
    
    buts[3] = new RadioButton();
    buts[3].setTxt("abdruck");
    buts[3].setPosSize(0, 3.0 * ySize, width, ySize);
    buts[3].setLine(100);
    
    
    
    radioBut = new GraphButton();
    radioBut.setPosSize(0, 4.0 * ySize, width, 2.0 * ySize);
    radioBut.setTxt("painLvl");
    
    //radioBut.setGraph(new float[]{25, 10, 5, 10, 25});
    radioBut.setGraph(new float[]{0, 0, 0, 0, 0});
    
    radioBut.setPointSize(ySize / 32);
    
    
    
    
    navi[0] = new Button();
    navi[0].setPosSize(0, height - ySize, xSize, ySize);
    navi[0].setTxt("<");
    
    
    
    navi[1] = new Button();
    navi[1].setTxt("// TODO mark");
    
    //navi[1] = sup.events.
    //n0ll = false;
    
    
  }
  /*
    insOut
    bloodOut
    bump
    abdruck
    < >
    
    make a radio bar:
    title + ": " + info
    
    
    
    
  */
  
  //boolean n0ll;
  
  float ySize;
  
  RadioButton[] buts;
  Button[] navi;
  GraphButton radioBut;
  
  public void tick(){
    
    
    float xSize = width / 2.0;
    navi[1] = sup.events.get(" mark  ");
    navi[1].setPosSize(xSize, height - ySize, xSize, ySize);
    
    
  }
  
  public void render(){
    c(9, sup.pos);
    background(255);
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
      
    }
    
    for(int i = 0; i < navi.length; i ++){
      navi[i].render();
      
    }
    
    
    
    radioBut.render();
    float ySize = height / 7.0;
    float xSize = width / 12.0;
    float yPos = 6.0 * ySize;
    ySize /= 4.0;
    new TextPanel(day() + "", width - xSize, yPos - ySize, xSize, ySize).render();
    
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].afterRender();
      
    }
    
    radioBut.afterRender();
    
    
    
    
  }
  
  public void tickButtons(){
    
    
    //for(int i = 0; i < navi.length; i ++){
    if(navi[0].tickButton()){
      backScreen();
      //n0ll = true;
    } else if(navi[1].tickButton()){
      //backScreen();
      //n0ll = false;
      //events[reNe].tickTime();
      // TODO tick mark()
      
      
    }
      
    //}
  }
  
  public void tickRelease(){
    for(int i = 0; i < buts.length; i ++){
      buts[i].tickRelease();
      
    }
    aSave();
    //radioBut.tickPress();
  }
  
  
  public void tickPress(){
    for(int i = 0; i < buts.length; i ++){
      buts[i].tickPress();
      
    }
    
    radioBut.tickPress();
  }
  
  
  public String getData(){
    String rV = "";// = "insOut(50.0), ";
    /*
    if(n0ll){
      rV += "pressedBack, ";
      //return rV;
    }*/
    
    for(int i = 0; i < buts.length; i ++){
      rV += buts[i].txt + "(" + (100 - buts[i].getLine()) + ")";
      //if(i < buts.length - 1){
        rV += ", ";
     // }
    }
    
    
    float[] painLvlGraph = radioBut.getGraph();
    
    //rV += bar;
    rV += "painLvlGraph[";
    for(int i = 0; i < painLvlGraph.length; i ++){
      
      rV += painLvlGraph[i];
      if(i != painLvlGraph.length - 1){
        rV += ", ";
      } else {
        rV += "]";
      }
    
    }
    
    
    
    return rV;
  }
  
  
  
  
}