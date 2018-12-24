

public class SetSpriValue extends NumPad{
  
  Spri sup;
  public SetSpriValue(Spri sup, int val){
    super();
    this.sup = sup;
    
    writeValue = val + "";
    
   // writeValue = "30";
    
    name = new String[]{"spri"}; // set
    unit = new String[]{"units"}; // set
    length = new int[]{2}; // set
    komma = new int[]{0}; // sey
    
    //doRender();
    refreshType();
    refreshValText();
    
  }
  
  
  public void render(){
    super.render();
    
  }
  
  public void keyBack(){
    backScreen();
    sup.doRender();
  }
  
  public void keyEnter(){
    
    sup.value = Integer.parseInt(writeValue);
    backScreen();
    sup.doRender();
  }
  
  
  
}



