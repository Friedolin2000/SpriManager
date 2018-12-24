
public class Scroll extends UseProc{
  
  //boolean shouldRender;
  
  
  public Scroll() {
    //this.s = p;
    super();
    
    //setPosSize(width - width / 12.0, 0, width / 12.0, height);
    setSize(width / 12);
    setPos(true);// = width - xSize;
    
    setTotalSize(height * 2);
    //this.totalSize = totalSize
    pos = 0;
    
    setAcc(0.1);
    
  }
  
  public Scroll setTotalSize(float size){
    this.totalSize = size;
    this.ratio = height / totalSize;
    
    rBar = totalSize > height;
    
    this.size = height * ratio;
    return this;
  }
  
  public Scroll setSize(float xSize){
    this.xSize = xSize;
    return this;
  }
  
  public Scroll setPos(boolean right){
    if(right){
      xPos = width - xSize;
    } else {
      xPos = 0;
    }
    return this;
  }
  
  public Scroll setAcc(float acc){
    this.a = acc;
    return this;
  }
  
  float a, v;
  
  
  float xPos, xSize;
  float pos, size, totalSize;
  float lastY, firstY;
  float ratio;
  
  // wether bar should be rendered (cuz when too big/small?
  boolean rBar;
  
  public float getSize(){
    return xSize;
  }
  
  public float getStartPos() {
    // pos -> * height
    float rV = -pos / ratio;
    // size = height * height / totalSize
    return rV;
  }
  
  
  public void render() {
    //background(0);
    // background
    if(rBar){
      renderBar();
    }
    //println("super.render()");
    
   // if(shouldRender){
      //fill(255, 255, 0);
      //ellipse(width/4, height / 3, width / 4, width / 4);
    //}
      //new TextPanel(v + "", width/4 - width/8, height / 3 - width/8, width / 4, width / 4).render();
    //}
    
  }
  
  public void renderBar(){
    fill(128);
    rect(xPos, 0, xSize, height);
    
    //System.out.println("should render: " + pos);
    // movable tile
    fill(255);
    rect(xPos, pos, xSize, size);
    
  }
  
  public void tickPressStart() {
    lastY = mouseY;
    firstY = mouseY;
  }
  
  public void tickPress() {
    
    if(isOnScroll()){
      v = mouseY - lastY;
      // setPos
     // println("\ntickPress");
      pos = mouseY - size / 2;
      //pos += mouseY - lastY;
      //v = 0;
    } else {
      //println("// TODO real pos moving here");
      v = (mouseY - lastY) * ratio;
      //pos -= (mouseY - lastY) * ratio;
      
      
      
    }
    
    
    
    lastY = mouseY;
    doRender();
  }
  
  public void tick(){
    boolean com1, com2;
    com1 = false;
    com2 = false;
    
    //if(a <= 0 && v <= 0){
      //return;
     // 
    
    //fill(255);
    //ellipse(width/4, height / 2, width / 4, width / 4);
    
    if(isOnScroll()){
      // setPos
      pos += v;
      v = 0;
     
    } else {
      pos -= v;
      
      
      //if(a > 0 && v != 0){
        
        if(v < 0){
          com1 = true;
          a *= -1;
        }
        
        v -= a;
        
        if(v < 0){
          com2 = true;
        }
        
        if(com1 != com2){
          v = 0;
        }
        
        a = abs(a);
        
        
      //}
      
      //v -= a;
    }
    
    
    //println("beforePos: " + pos);
    
    if(pos > height - size){// && size < height) {
     // println("but too big");
      pos = height - size;
      //if(pos < 0){
        //pos = 0;
     // }
      
      //fill(255, 0, 0);
      //ellipse(width/4, 3 * height / 4, width / 4, width / 4);
      //shouldRender = true;
      
      
    }
    
    if(pos < 0) {
      pos = 0;
      //fill(255, 0, 0);
      //ellipse(width/4, 3*  height / 4, width / 4, width / 4);
      //println("shouldRender");
      //shouldRender = true;
      
    }
    
    //println(pos + " " + v);
    doRender();
  }
  
  public boolean isOnScroll(){
    if(mouseX > xPos && mouseX < xPos + xSize){
      return true;
    }
    return false;
  }
  
  public boolean tickButton(){
    return tickButton(height / 64);
  }
  
  public boolean tickButton(float offset){
    if(isOnScroll()){
      //println("onScroll");
      return false;
    }
    
    if(abs(mouseY - firstY) > offset){
      //println("moved: " + (mouseY - firstY));
      return false;
    }
    // false if on scroll
    // but also when short pressed BUT HOW?
    // / not rly moved ->
    return true;
  }
  
  
  
}

public class List extends Scroll {
  
  public List() {
    super();

    setOnScreen(6);
    
    
    setNames(new String[]{"set", "Names", "!!!"});
    

    
    //refreshSizes();
    //afterN = false;
  }
  
  
  public List setOnScreen(int onScreen){
    this.onScreen = onScreen;
    ySize = height / onScreen;
    return this;
  }
  
  public List setNames(String[] names){
    buts = new Button[names.length];
    for (int i = 0; i < names.length; i ++) {
      buts[i] = new Button();
      buts[i].setTxtCol(255);
      buts[i].setCol(0);
      buts[i].setX(0, width - getSize()).setYSize(ySize);
      buts[i].setTxt(names[i]);
      //buttons[i].setTxt(names[i]);
    }
    setTotalSize(buts.length * ySize);
    return this;
  }
  
  //boolean afterN;
  
  public Button getBut(int i){
    return buts[i];
  }

  int onScreen;
  //int start;
  float ySize;

  Button[] buts;

  public void render() {
    background(0);
    stroke(255);
    int ind = (int) (-getStartPos() / ySize);

    float rPos = getStartPos() + ind * ySize;
   // println("render");
    for (int i = ind; i < ind + onScreen + 1; i ++) {
      try {
        buts[i].setYPos(rPos);
        buts[i].render();
        rPos += ySize;
      } catch(Exception e) {
      }
    }
   // println("-render");
    super.render();
    
    
    
    
    
  }

  /*
  public void refreshSizes(){
   for(int i = 0; i < onScreen; i ++){
   buttons[start + i].setYPos(i * ySize);
   }
   }*/

  public int getPos(){
    return (int) ((mouseY - getStartPos()) / ySize);
  }

  public String getButton() {
    String rV = "";
    // so it only renturns sth if sb act pressed on a name
    if (tickButton()) {
      // - cuz pos has to be + and - - = +
      int ind = getPos();
      //println(ind);
      
      
      
        try {
          rV = buts[ind].getTxt();
        } catch(Exception e) {
          rV = "null";
        }
        //nextScreen(new Action());
      
       //}
    }
    
    return rV;
  }
  
  
}



