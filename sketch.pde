import android.os.Environment;
import android.os.Vibrator;
import android.content.Context;


int acceptedNeSpris = 1;

float xFactor = 8;
float yFactor = 4;
float impX = 1;
float impY = 0.7;

/*
todo:

-new spri selection for new pen + refresh in file


*/



//-------

public String getThing(){
  return getPath() + "/path";
}

public String getSpriSave(){
  return getPath() + "/Dia/spri/spriLog.txt";
}

public String getBelly(){
  //return getPath() + "/Dia/pics/belly1.jpg";
  return "belly1.jpg";
}

public String getLegs(){
  //return getPath() + "/Dia/pics/legs1.png";
  return "legs1.png";
}






//------

boolean autoLoaded;

void setup(){
  
  nevEvents = new EventManager();
  
  
  fullScreen();
  //accSetup();
  init();
  lastP = new ArrayList<UseProc>();
  //nextScreen(new Selection());
  if(!autoLoaded){
    thread("loadAutoSave");
    autoLoaded = true;
  }
  
  //nextScreen(new Spri());
  
  
}

ArrayList<UseProc> lastP;
UseProc useProc;

//boolean resumed;

int vibSetup = 100;
int vibStand = 75;
int vibBut = 25;

float tpsCool = 4.5;
float start = 1;

Time wait;

// ------
public void init(){
  carryOn = "3";
  
  /*
    // TODO
    maxSecs = secsToWait bei spri -> 10?
    spriAmount = totalSpri
    
  */
  
  
  // from here is oldFags
  
  initVars();
  initSavedSpri();
  
  maxSecs = 15;
  
  //open = new Time();
  spriAmount = spriSaved[2];
  
  
  
}

int pause = 1000;
int smPause = 100;

int maxSecs;


int[] spriSaved;
Pen[] l3m, nr;
Pen[] act;

// save

boolean isNR;

Time sprid;
int spriAmount;
Pen spriPen;
ArrayList<Spri> spris;

EventManager nevEvents;

// -------



public void initVars(){
  int avg = 30;
  
  try{
    String[] forAvg = new FileManager("/Dia/spri/trueSam.txt").getStrings();
    float n = 0;
    double am = 0;
    float p;
    String[] sp;
    for(int i = 0; i < forAvg.length; i ++){
      sp = forAvg[i].split(": ");
      //p = 1.0 - abs(((float) (new Time().setStringDate(sp[0]).subTime(new Time()).getSecs())) / ((float) new Time(6, 0, 0, 0).getSecs()));
      //if(p < 0){p = 0;}
      p = getP(new Time().difTime(new Time().setStringDate(sp[0])).getSecs());
      //println("p: " + p + " with " + sp[1] + " at " + sp[0]);
      n += p;
      am += Float.parseFloat(sp[1]) * p;
      
    }
    am /= n;
    avg = round((float) am);
    if(avg < 1){
      avg = 30;
    }
  } catch(Exception e){
    println(e);
  }
  
  FileManager f = new FileManager("/Dia/baseValues/spri/amount.txt");
  f.setVal("spriNrAvg", avg + "");
  spriSaved = new int[3];
  spriSaved[0] = Integer.parseInt(f.getVar("spriL3mMor", "12"));
  spriSaved[1] = Integer.parseInt(f.getVar("spriL3mEve", "28"));
  spriSaved[2] = Integer.parseInt(f.getVar("spriNrAvg", avg + ""));
  
  
  
  wait = new Time(0, 10, 0, 0);
  
  
}

public void initSavedSpri(){
  //initVars();
  
  String[] sp, info;
  
  info = new FileManager("/Dia/baseValues/spri/nr/cur/info.txt").getStrings();
  nr = new Pen[info.length];
  for(int i = 0; i < info.length; i ++){
    sp = info[i].split(":");
    try{
      nr[i] = new Pen(sp[0], Integer.parseInt(sp[1]), Integer.parseInt(sp[2]), i, sp[3]);
    } catch(Exception e){
      nr[i] = new Pen(sp[0], Integer.parseInt(sp[1]), Integer.parseInt(sp[2]), i);
    }
  }
  
  info = new FileManager("/Dia/baseValues/spri/l3m/cur/info.txt").getStrings();
  l3m = new Pen[info.length];
  for(int i = 0; i < info.length; i ++){
    sp = info[i].split(":");
    try{
      l3m[i] = new Pen(sp[0], Integer.parseInt(sp[1]), Integer.parseInt(sp[2]), i, sp[3]);
    } catch(Exception e){
      l3m[i] = new Pen(sp[0], Integer.parseInt(sp[1]), Integer.parseInt(sp[2]), i);
    }
  }
  
  act = nr;
  
}



public void nextScreen(UseProc nev){
  lastP.add(useProc);
  useProc = nev;
  useProc.setRender();
}

public void backScreen(){
  useProc = lastP.remove(lastP.size() - 1);
  useProc.onBackScreen();
  
}

void draw(){
  try{
  useProc.drawHelper();
  } catch(Exception e){}
}



void onResume(){
  //resumed = true;
  //open = new Time();
  super.onResume();
  //accResume();
  try{
    useProc.setDoRender(true);
  }catch(Exception e){}
  super.onResume();
}


