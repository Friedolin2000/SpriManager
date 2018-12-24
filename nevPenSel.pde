public class PenSel extends List{
  
  public PenSel(){
    super();
    if(!isNR){
      act = l3m;
    }
    
    firstRows = 2;
    
    int len = act.length;
    len += firstRows + 1; // nevPen + (edit) + back
    
    //editPos = len - 2;
    filterPos = 0;
    
    filter = 2;
    filtAsc = true;
    sort(filtAsc);
    
    setNames(getNames());
    
  }
  
  int filterPos, filter;
  //boolean edit;
  
  // buts[].setTxt();
  
  public String getFilter(int f){
    switch(f){
      case 0:
        return "time";
      case 1:
        return "name";
      case 2:
        return "left";
      case 3:
        return "needle";
      case 4:
        return "com";
    }
    return "null";
  }
  
  public void tickButtons(){
    super.tickButtons();
    if(tickButton()){
      String but = getButton();
      if(but.equals("<")){
        nextScreen(new Times());
      } else if(but.equals("nevPen")){
        
        nextScreen(new NevPen());
        
      }/* else if(but.equals("edit")){
        edit = !edit;
        if(edit){
          getBut(getPos()).setTxtCol(0).setCol(255);
        } else {
          getBut(getPos()).setTxtCol(255).setCol(0);
        }
        
      }*/ else {
        if(getPos() == filterPos){
          
          if(mouseX < width / 3.0){
            filtAsc = !filtAsc;
            
          } else {
            filter ++;
            filter %= 5;
          }
          
          
          sort(filtAsc);
          
          setNames(getNames());
          //getBut(getPos()).setTxt("filter: " + getFilter(filter));
        } else if(3.0 * width / 4.0 < mouseX){
          nextScreen(new PenEdit(act[getPos() - firstRows]));
        } else {
          spriPen = act[getPos() - firstRows];
          nextScreen(new Times());
        }
      }
      
      
      
    }
    
  }
  
  boolean filtAsc;
  
  public void render(){
    super.render();
    c(3);
  }
  
  int firstRows;
  
  public String[] getNames(){
    int len = act.length;
    len += 4; // nevPen +( edit )+ back
    int first = firstRows;
    
    String[] things = new String[len];
    for(int i = 0; i < act.length; i ++){
      if(act[i].isCom()){
        things[i + first] = act[i].name + " (" + act[i].left + ", " + act[i].needle + "): " + act[i].com;
      } else {
        things[i + first] = act[i].name + " (" + act[i].left + ", " + act[i].needle + ")";
      }
    }
    
    things[len - 2] = "nevPen";
    things[0] = "sort: " + getFilter(filter);
    //things[len - 2] = "edit";
    things[len - 1] = "<";
    things[1] = "<";
    
    return things;
  }
  
  
  
  public boolean isGreater(Pen a, Pen b){
    switch(filter){
      case 0:
        return a.tim < b.tim; // time
      case 1:
        return getGreat(a.name, b.name); // name
      case 2:
        return a.left < b.left;
      case 3:
        return a.needle < b.needle;
      case 4:
        return getGreat(a.com, b.com); // com
    }
    return false;
  }
  
  public boolean getGreat(String a, String b){
    if(a == null || b == null){
      
      
      if(a == null){
        a = "";
      }
      if(b == null){
        b = "";
      }
      
      return a.compareToIgnoreCase(b) > b.compareToIgnoreCase(a);
    }
    return a.compareToIgnoreCase(b) < b.compareToIgnoreCase(a);
  }
  
  public boolean isLess(Pen a, Pen b){
    switch(filter){
      case 0:
        return a.tim > b.tim; // time
      case 1:
        return getLess(a.name, b.name); // name
      case 2:
        return a.left > b.left;
      case 3:
        return a.needle > b.needle;
      case 4:
        return getLess(a.com, b.com); // com
    }
    return false;
  }
  
  public boolean getLess(String a, String b){
    if(a == null || b == null){
      
      
      if(a == null){
        a = "";
      }
      if(b == null){
        b = "";
      }
      
      //return a.compareToIgnoreCase(b) < b.compareToIgnoreCase(a);
    }
    return a.compareToIgnoreCase(b) > b.compareToIgnoreCase(a);
  }
  
  public boolean negIf(boolean asc, Pen a, Pen b){
    
    if(asc){
      return isGreater(a, b);
    }
    return isLess(a, b);
  }
  
  public void sort(boolean asc) {
    Pen temp;
    
    for (int i = 1; i < act.length; i++) {
      for (int j = i; j > 0; j--) {
        if (negIf(asc, act[j], act[j - 1])) {
          temp = act[j];
          act[j] = act[j - 1];
          act[j - 1] = temp;
        }
      }
    }
  }


  
}