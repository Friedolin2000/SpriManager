public class Selection extends UseProc{
  
  public Selection(){
    super();
    
    ySize = height / 5.0;
    
    
    
    String[] txt = new String[]{
      "changeValues",
      "L3m mor spri " + spriSaved[0],
      "L3m eve spri " + spriSaved[1],
      "NR spri " + spriSaved[2],
      "NR set spri"
    };
    
    
    texts = new TextPanel[5];
    texts[0] = new TextPanel(txt[0], 0, 0, width, ySize);
    texts[1] = new TextPanel(txt[1], 0, ySize, width, ySize);
    texts[2] = new TextPanel(txt[2], 0, 2 * ySize, width, ySize);
    texts[3] = new TextPanel(txt[3], 0, 3 * ySize, width, ySize);
    texts[4] = new TextPanel(txt[4], 0, 4 * ySize, width, ySize);
    
  }
  
  float ySize;
  TextPanel[] texts;
  
  public void render(){
    c(0);
    for(int i = 0; i < texts.length; i ++){
      fill(250);
      rect(0, i * ySize, width, ySize);
      texts[i].render();
    }
  }
  
  public void tickButtons(){
    int y = ((int) (mouseY / ySize));
    
    switch(y){
      case 0:
        // TODO
        nextScreen(new ChangeVal());
        break;
      case 1:
        spriAmount = spriSaved[0];
        isNR = false;
        nextScreen(new Times());
        break;
      case 2:
        spriAmount = spriSaved[1];
        isNR = false;
        nextScreen(new Times());
        break;
      case 3:
        spriAmount = spriSaved[2];
        isNR = true;
        nextScreen(new Times());
        break;
      case 4:
        isNR = true;
        nextScreen(new SetValue(this));
        break;
    }
  }
  
  
  
  
  
}