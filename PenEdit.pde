
public String nr(){
  if(isNR){
    return "nr";
  }
  return "l3m";
}

public class PenEdit extends UseProc{
  
  public PenEdit(Pen toEdit){
    super();
    
    f = new FileManager("/Dia/baseValues/spri/" + nr() + "/cur/" + toEdit.name + ".txt");
    vars = f.loadValues();
    
    this.toEdit = toEdit;
    
    
    buts = new Button[3];
    navi = new Button[2];
    
    float ySize = height / (buts.length + 1.0);
    
    int ind = 0;
    String entr;
    entr = "left";
    buts[ind] = new Button();
    buts[ind].setPosSize(0, ind * ySize, width, ySize);
    buts[ind].setTxt(entr + ": " + vars.get(entr));
    ind ++;
    
    entr = "needle";
    buts[ind] = new Button();
    buts[ind].setPosSize(0, ind * ySize, width, ySize);
    buts[ind].setTxt(entr + ": " + vars.get(entr));
    ind ++;
    
    entr = "place";
    buts[ind] = new Button();
    buts[ind].setPosSize(0, ind * ySize, width, ySize);
    buts[ind].setTxt(entr + ": " + vars.get(entr));
    ind ++;
    
    
    
    
    
    float xSize = width / 2.0;
    navi[0] = new Button();
    navi[0].setPosSize(0, height - ySize, xSize, ySize);
    navi[0].setTxt("<");
    
    navi[1] = new Button();
    navi[1].setPosSize(xSize, height - ySize, xSize, ySize);
    navi[1].setTxt(">");
    
  }
  
  Pen toEdit;
  
  
  Button[] buts, navi;
  
  FileManager f;
  HashMap<String, String> vars;
  
  
  public void render(){
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    for(int i = 0; i < navi.length; i ++){
      navi[i].render();
    }
  }
  
  
  public void tickButtons(){
    // TODO
    for(int i = 0; i < buts.length; i ++){
      if(buts[i].tickButton()){
        String[] sp = buts[i].getTxt().split(": ");
        if(sp[0].equals("place")){
          
        } else {
          carryOn = sp[1];
          varForNum = sp[0];
          nextScreen(new VarSet());
        }
      }
    }
    
    if(navi[0].tickButton() || navi[1].tickButton()){
      keyEnter();
    }
    
    
  }
  
  public void keyEnter(){
    
    onBackScreen();
  }
  
  public void onBackScreen(){
    super.onBackScreen();
    println("set " + varForNum + " -> " + carryOn);
    vars.put(varForNum, carryOn);
    
    
    String[] info = new FileManager("/Dia/baseValues/spri/" + nr() + "/cur/info.txt").getStrings();
    String[] sp;
    for(int i = 0; i < info.length; i ++){
      sp = info[i].split(":");
      
      if(sp[0].equals(toEdit.name)){
        
        
        if(varForNum.equals("left")){
          sp[1] = carryOn;
        } else if(varForNum.equals("needle")){
          sp[2] = carryOn;
        } else if(varForNum.equals("place")){
          // TODO
        } else {
          println("THIS SHOULDNT HAPPEN: PenEdit.onBackScreen()");
        }
        
        
        info[i] = sp[0] + ":" + sp[1] + ":" + sp[2];
        try{
          info[i] += ":" + sp[3];
        } catch(Exception e){
          
        }
        println("INFO: " + info[i]);
        
        break;
      }
    }
    new FileManager("/Dia/baseValues/spri/" + nr() + "/cur/info.txt").setStrings(info);
    
    
    
    // THIS WAS IN KEYENTER v
    f.setVars(vars); // not needed act but whatever -> it is in order to save anything
    initSavedSpri();
    if(!isNR){
      act = l3m;
    }
    
    
    nextScreen(new Times());
  }
  
  
  
  
}