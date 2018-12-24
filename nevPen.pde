


public Pen[] append(Pen[] ary, Pen p){
  Pen[] rV = new Pen[ary.length + 1];
  for(int i = 0; i < ary.length; i ++){
    rV[i] = ary[i];
  }
  rV[ary.length] = p;
  return rV;
}


public class NevPen extends List{
  
  
  public NevPen(){
    super();
    
    initNevPs();
    int len = nevPs.length;
    len ++; // back
    
    String[] things = new String[len];
    for(int i = 0; i < nevPs.length; i ++){
      things[i] = nevPs[i].name;
    }
    
    things[len - 1] = "<";
    
    
    setNames(things);
    
  }
  
  
  
  public void tickButtons(){
    super.tickButtons();
    if(tickButton()){
      String but = getButton();
      if(but.equals("<")){
        backScreen();
      } else {
        spriPen = nevPs[getPos()];
        if(isNR){
          nr = append(nr, spriPen);
        } else {
          l3m = append(l3m, spriPen);
        }
        
        
        String nrE = "l3m";
        if(isNR){
          nrE = "nr";
        }
        // in FileSystem..
        FileManager f = new FileManager("/Dia/baseValues/spri/" + nrE + "/nev/info.txt");
        String[] info = f.getStrings();
        String[] nev = remove(info, spriPen.name);
        f.setStrings(nev);
        nevPs = null;
        
        new FileManager("/Dia/baseValues/spri/" + nrE + "/cur/info.txt")
        .addString(spriPen.name + ":300:0", true);
        
        f = new FileManager("/Dia/baseValues/spri/" + nrE + "/nev/" + spriPen.name + ".txt");
        new FileManager("/Dia/baseValues/spri/" + nrE + "/cur/" + spriPen.name + ".txt").setStrings(f.getStrings());
        f.delete();
        
        
        
        // TODO move the name.txt file to cur done20181102/1852
        // TODO add pen to cur/info.txt done20181102/1849
        
        nextScreen(new Times());
      }
      
    }
  }
  
  
  public void render(){
    super.render();
    c(11);
  }
  
  
}


Pen[] nevPs;


public void initNevPs(){
  if(nevPs != null){
    return;
  }
  
  String[] info = new FileManager("/Dia/baseValues/spri/nr/nev/info.txt").getStrings();
  nevPs = new Pen[info.length];
  for(int i = 0; i < info.length; i ++){
    //sp = info[i].split(":");
    nevPs[i] = new Pen(info[i], 300, 0, 0);
  }
  
  
}

