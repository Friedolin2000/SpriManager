
public String getPath(){
  return android.os.Environment.getExternalStoragePublicDirectory(android.os.Environment.DIRECTORY_DCIM).getParentFile().getAbsolutePath() + 
  "/CODING/static";
}


public class FileManager{
  
  
  public FileManager(String path){
    this.path = path;
  }
  
  public FileManager(String[] path){
    this.path = "";
    for(int i = 0; i < path.length; i ++){
      this.path += "/" + path[i];
    }
  }
  
  String path;
  
  public String[] getStrings(){
    return getStrings(new String[0]);
  }
  
  public String[] getStrings(String[] ifNull){
    String[] rV = null;
    try{
      rV = loadStrings(getPath() + path);
    } catch(Exception e){}
    if(rV == null){
      rV = ifNull;
    }
    return rV;
  }
  
  public void setStrings(String[] nev){
    saveStrings(getPath() + path, nev);
  }
  
  public int addString(String data, boolean start){
    return addStrings(new String[]{data}, start);
  }
  
  public int addStrings(String[] toAdd, boolean atStart){
    String[] info = getStrings();
    String[] nev = new String[info.length + toAdd.length];
    int pos = 0;
    if(atStart){
      pos = toAdd.length;
    }
    for(int i = 0; i < info.length; i ++){
      nev[i + pos] = info[i];
    }
    
    pos = 0;
    if(!atStart){
      pos = info.length;
    }
    for(int i = 0; i < toAdd.length; i ++){
      nev[i + pos] = toAdd[i];
    }
    
    setStrings(nev);
    return nev.length;
  }
  
  public PImage getImg(){
    PImage rV = createImage(2, 2, RGB);
    rV.loadPixels();
    rV.pixels[1] = color(128, 0, 128);
    rV.pixels[2] = rV.pixels[1];
    rV.updatePixels();
    return getImg(rV);
  }
  
  public PImage getImg(PImage ifNull){
    PImage rV = null;
    
    try{
      rV = loadImage(getPath() + path);
    } catch(Exception e){
      //rV = null;
    }
    
    if(rV == null){
      rV = ifNull;
    }
    
    return rV;
  }
  
  
  
  public HashMap<String, String> loadValues() {
    HashMap<String, String> rV = new HashMap<String, String>();
    String[] info = getStrings();
    String[] sp;
    for (int i = 0; i < info.length; i++) {
      sp = info[i].split(": ");
      if (sp.length > 2) {
        // TODO
      }
      try {
        rV.put(sp[0], sp[1]);
      } catch (Exception e) {}
    }
    
    return rV;
  }
  
  protected HashMap<String, String> info;
  protected String ifNull = "";
  
  public FileManager setIfNull(String ifNull) {
    this.ifNull = ifNull;
    return this;
  }
  
  
  // TODO var + val methods...
  
  public String getVal(String keyy) {
    initIfNull();
    return getVar(keyy, ifNull);
  }
  
  public String getVar(String keyy, String ifNull) {
    initVars();
    return getVar(info, keyy, ifNull);
  }
  
  public void setVal(String keyy, String var) {
    initVars();
    this.info.put(keyy, var);
    
    saveValues();
  }
  
  public FileManager saveValues(){
    setVars(info);
    return this;
  }
  
  public void setVars(HashMap<String, String> info) {
    //Set<String> e = info.keySet();
    String[] rV = info.keySet().toArray(new String[0]);
    for (int i = 0; i < rV.length; i++) {
      rV[i] += ": " + info.get(rV[i]);
    }
    setStrings(rV);
  }
  
  private void initIfNull() {
    if (ifNull == null) {
      ifNull = "null";
    }
  }
  
  private void initVars() {
    if (info == null) {
      info = loadValues();
    }
  }
  
  public String getVar(HashMap<String, String> info, String keyy, String ifNull) {
    String rV = info.get(keyy);
    if (rV == null) {
      rV = ifNull;
    }
    return rV;
  }
  
  
  
  public void delete(){
    try{
      new File(getPath() + path).delete();
    } catch(Exception e){
      println("wgilr deleting: " + e);
    }
  }
  
  
  
  
}



