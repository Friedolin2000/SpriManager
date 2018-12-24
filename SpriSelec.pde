public class SpriSelec extends NumPad{
  
  
  public SpriSelec(){
    super();
    
    
    writeValue = carryOn;
    
   // writeValue = "30";
    
    name = new String[]{"test"}; // set
    unit = new String[]{"units"}; // set
    length = new int[]{1}; // set
    komma = new int[]{0}; // sey
    
    //doRender();
    refreshType();
    refreshValText();
    
  }
  
  public void render(){
    super.render();
    c(6);
  }
  
  
  public void keyBack(){
    backScreen();
  }
  
  public void keyEnter(){
    
    carryOn = writeValue;
    backScreen();
  }
  
  
  
}


String carryOn;