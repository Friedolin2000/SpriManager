

public class ChangeVal extends UseProc {
  
  
  public ChangeVal(){
    super();
    
    
    f = new FileManager("/Dia/baseValues/spri/amount.txt");
    vars = f.loadValues();
    
    // init missing vars:
    String txt = "spriL3mMor";
    if(vars.get(txt) == null){
      vars.put(txt, "12");
    }
    
    txt = "spriL3mEve";
    if(vars.get(txt) == null){
      vars.put(txt, "28");
    }
    
    txt = "spriNrAvg";
    if(vars.get(txt) == null){
      vars.put(txt, "30");
    }
    
    
    
    String[] entr = vars.keySet().toArray(new String[0]);
    
    buts = new Button[entr.length];
    navi = new Button[2];
    
    float ySize = height / (buts.length + 1.0);
    
    for(int i = 0; i < buts.length; i ++){
      buts[i] = new Button();
      buts[i].setPosSize(0, i * ySize, width, ySize);
      buts[i].setTxt(entr[i] + ": " + vars.get(entr[i]));
    }
    
    
    float xSize = width / 2.0;
    navi[0] = new Button();
    navi[0].setPosSize(0, height - ySize, xSize, ySize);
    navi[0].setTxt("<");
    
    navi[1] = new Button();
    navi[1].setPosSize(xSize, height - ySize, xSize, ySize);
    navi[1].setTxt(">");
    
  }
  
  
  Button[] buts, navi;
  
  FileManager f;
  HashMap<String, String> vars;
  
  
  public void render(){
    c(7);
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    for(int i = 0; i < navi.length; i ++){
      navi[i].render();
    }
  }
  
  
  public void tickButtons(){
    
    for(int i = 0; i < buts.length; i ++){
      if(buts[i].tickButton()){
        String[] sp = buts[i].getTxt().split(": ");
        carryOn = sp[1];
        varForNum = sp[0];
        nextScreen(new VarSet());
      }
    }
    
    if(navi[0].tickButton() || navi[1].tickButton()){
      keyEnter();
    }
    
    
  }
  
  public void keyEnter(){
    f.setVars(vars); // not needed act but whatever
      initVars();
      nextScreen(new Selection());
  }
  
  public void onBackScreen(){
    super.onBackScreen();
    vars.put(varForNum, carryOn);
    
    keyEnter();
  }
  
  
  
  
}