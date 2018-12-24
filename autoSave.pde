

public void delAutoSave(){
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[0]);
}


int clazz;

int poses = 13;

public void c(int c, int sub){
  c(sub * poses + c);
}

public void c(int c){
  int oldC = clazz;
  clazz = c;
  if(oldC != c){
    autoSave();
    println("clazz: " + c);
  }
}

public String autoSaveTime(Time t){
  String rV = "null";
  if(t != null){
    rV = t.toDate();
  }
  return rV;
}

public Time loadAutoSaveTime(String t){
  if(!t.equals("null")){
    return new Time().setStringDate(t);
  }
  return null;
}



public void aSave(){
  autoSave();
}

public void autoSave(){
  // every var:
  /*
    
    
    spriAm, done
    nevEvents, done
    spriPen, done
    spris(value, events, spriPos, inInfo, ...)
    
    
    
  */
  
  
  // + where u r: idk how...
  
  
  thread("actAutoSave");
}

String appName = "SpriManager";


public void actAutoSave(){
  String rV = "";
  String bar = ":";
  
  rV += spriAmount;
  //rV += events.autoSave();
  rV += bar;
  
  rV += nevEvents.autoSave();
  rV += bar;
  
  if(spriPen != null){
    rV += "1";
    rV += bar;
    rV += spriPen.name;
    rV += bar;
    rV += spriPen.left;
    rV += bar;
    rV += spriPen.needle;
    
  } else {
    rV += "0";
  }
  
  rV += bar;
  rV += autoSaveTime(sprid);
  
  rV += bar;
  if(spris != null){
    rV += spris.size();
    rV += bar;
    
    for(int i = 0; i < spris.size(); i ++){
      
      rV += spris.get(i).autoSave();
      rV += bar;
    }
  } else {
    rV += "0" + bar;
  }
  
  rV += isNR;
  rV += bar;
  
  rV += carryOn;
  rV += bar;
  
  rV += varForNum;
  rV += bar;
  
  rV += clazz;
  
  
  
  new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).setStrings(new String[]{rV});
}

public void loadAutoSave(){
  println("startLoadAuto");
  String[] info = new FileManager(new String[]{"autoSave", appName, "autoSave.txt"}).getStrings();
  if(info.length != 1){
    // WARNING: RETURNS IF !1
    nextScreen(new Selection());
    println("lol loading return");
    return;
  }
  
  println("well belly: " + belly);
  
  // how is it saved?
  try{
    String[] sp = info[0].split(":");
    
    println(sp);
    
    int ind = 0;
    
    spriAmount = Integer.parseInt(sp[ind]);
    ind ++;
    
    
    nevEvents.loadAutoSave(sp[ind]);
    ind ++;
    
    
    if(sp[ind].equals("1")){
      ind ++;
      
      spriPen = new Pen(sp[ind], Integer.parseInt(sp[ind + 1]), Integer.parseInt(sp[ind + 2]), 0);
      ind += 2;
      
    }
    ind ++;
    
    
    
    sprid = loadAutoSaveTime(sp[ind]);
    ind ++;
    
    int sprisNum = Integer.parseInt(sp[ind]);
    ind ++;
    
    
    
    
    String type;
    if(sprisNum > 0){
      spris = new ArrayList<Spri>(); // ?
    }
    for(int i = 0; i < sprisNum; i ++){
      type = sp[ind].split(";")[0];
      if(type.equals("1")){
        spris.add(new Spri(sp[ind], spris.size()));
      } else if(type.equals("0")){
        spris.add(new TestSpri(sp[ind]));
      }
      ind ++;
    }
    
    isNR = sp[ind].equals("true");
    ind ++;
    
    carryOn = sp[ind];
    ind ++;
    
    varForNum = sp[ind];
    ind ++;
    
    println("now clazzes: " + sp[ind]);
    
    int claz = Integer.parseInt(sp[ind]);
    
    switch(claz % poses){
      case 0:
        nextScreen(new Selection());
        break;
      case 1:
        nextScreen(new ComTag());
        break;
      case 2:
        nextScreen(new Done());
        break;
      case 3:
        nextScreen(new PenSel());
        break;
      case 4:
        nextScreen(new SetValue());
        break;
      case 5:
        nextScreen(new Times());
        break;
      case 6:
        nextScreen(new SpriSelec());
        break;
      case 7:
        nextScreen(new ChangeVal());
        break;
      case 8:
        initSpris();
        ind = claz / poses;
        nextScreen(spris.get(ind));
        break;
      case 9:
        initSpris(); // ? here ?
        ind = claz / poses;
        nextScreen(spris.get(ind).inInfo);
        break;
      case 10:
        //ind = claz / poses;
        nextScreen(new TestSpri());
        break;
      case 11:
        nextScreen(new NevPen());
        break;
        /*
          
          
          
        */
      
      
      
    }
    println(" -> all loaded");
    useProc.doRender();
  } catch(Exception e){
    println(" -> loading execrptiom: " + e);
  }
  
  
  if(useProc == null){
    nextScreen(new Selection());
  }
  
}

