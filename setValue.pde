public class SetValue extends NumPad{
  
  UseProc back;
  
  public SetValue(){
    this(new Times());
  }
  
  public SetValue(UseProc b){
    super();
    
    this.back = b;
    
    
    //this.next = new Time();
    
    writeValue = spriAmount + "";
    type[0] = 1;
    name[0] = "spri";
    unit[0] = "";
    komma[0] = 0;
    length[0] = 3;
    
    
    refreshValue();
  }
  
  public void render(){
    super.render();
    c(4);
  }
  
  
  public void keyEnter(){
    
    spriAmount = (int) getValue();
    if(spriAmount > 0){
      nextScreen(new Times());//new PenSel());
      initSpris();
      //next.doRender();
    }
  }
  
  public void keyBack(){
    spriAmount = (int) getValue();
    //initSpris();
    nextScreen(back);
  }
  
  
  
}