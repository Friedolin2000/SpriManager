public class VarSet extends NumPad{
  
  
  public VarSet(){
    super();
    
    
    writeValue = carryOn;
    
   // writeValue = "30";
    
    name = new String[]{varForNum}; // set
    unit = new String[]{"units"}; // set
    length = new int[]{2}; // set
    komma = new int[]{0}; // sey
    
    //doRender();
    refreshType();
    refreshValText();
    
  }
  
  
  public void render(){
    super.render();
    c(7);
  }
  
  public void keyBack(){
    backScreen();
  }
  
  public void keyEnter(){
    
    carryOn = writeValue;
    backScreen();
  }
  
  
  
}

String varForNum;

