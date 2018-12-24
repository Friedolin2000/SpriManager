public class oPenSel extends UseProc{
  
  public oPenSel(){
    super();
    
    
    Pen[] pens = l3m;
    if(isNR){
      pens = nr;
    }
    
    int len = 0;
    for(int i = 0; i < pens.length; i ++){
      if(pens[i].left > 0){// spriAmount){
        len ++;
      }
    }
    
    pins = new Pen[len];
    ySize = height / (len + 1.0);
    int ind = 0;
    for(int i = 0; i < pins.length; i ++){
      if(pens[ind].left > spriAmount + 1){
        pins[i] = pens[ind];
        
      } else {
        i --;
      }
      ind ++;
    }
    
    
  }
  
  float ySize;
  boolean extendedList;
  //boolean isNR;
  Pen[] pins;
  TextPanel[] texts;
  
  
  public void render(){
    c(3);
    String txt;
    for(int i = 0; i < pins.length; i ++){
      fill(250);
      rect(0, i * ySize, width, ySize);
      txt = pins[i].name + " with " + pins[i].left;
      new TextPanel(txt, 0, i * ySize, width, ySize).render();
    }
    fill(250);
    rect(0, pins.length * ySize, width, ySize);
    txt = "<";
    new TextPanel(txt, 0, pins.length * ySize, width, ySize).render();
    
  }
  
  
  public void tickButtons(){
    int y = ((int) (mouseY / ySize));
    if(y == pins.length){
      backScreen();
      return;
    } else if(y == pins.length - 1 && !extendedList){
      PenSel nev = new PenSel();
     // nev.extendedList = true;
      //nev.pens = 
      nextScreen(nev);
      return;
    }
    spriPen = pins[y];
    
    nextScreen(new Times());
  }
}


public class Pen{
  
  public Pen(String n, int l, int e, int tim){
    this(n, l, e, tim, null);
  }
  
  public Pen(String name, int left, int needle, int tim, String c){
    this.name = name;
    this.left = left;
    this.needle = needle;
    this.com = c;
    this.tim = tim;
    
  }
  
  String name, com;
  int left, needle, tim;
  
  public boolean isCom(){
    if(com != null){
      return true;
    }
    return false;
  }
  
  
}


