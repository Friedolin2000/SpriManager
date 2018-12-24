

public void saveSPos(float spriX, float spriY, int value, Time time){
      String path = getPath() + "/Dia/spri/" + isNR + "Spos.txt";
      String[] info = null;
      try{info = loadStrings(path);} catch(Exception e){}
      if(info == null){
        info = new String[0];
      }
      
      // sprisPerDay days doublr
      int maxLen = 3 * 3 * 2;
      if(!isNR){
        maxLen = 2 * 3 * 2;
      }
      
      if(info.length < maxLen){
        maxLen = info.length;
      }
      
      String[] nev = new String[maxLen + 1];
      for(int i = 0; i < maxLen; i ++){
        nev[i + 1] = info[i];
      }
      
      
      
      nev[0] = spriX + " " + spriY;
      
      
      /////------------------
      
      new FileManager("/Dia/spri/" + isNR + "Sam.txt").addString(time.toDate() + ": " + value, true);
      
      
     // println("save: " + nev[0]);
      saveStrings(path, nev);
    }
    
    
    


public float getP(float dif){
  //float ddif = dif * dif;
  
  long twelche = new Time(12, 0, 0, 0).getSecs();
  // this is cuz the dif is act dif between days but we need tobmake a difference between difs that r > 12h -> -12h and stuff
  if(dif > twelche){
    dif -= twelche;
    dif = twelche - dif;
  }
  
  float wP = new Time(2, 0, 0, 0).getSecs();
  float in = dif / wP;
  in *= in;
  in *= -1;
  
  float rV = exp(in);
  

  return rV;
}
    