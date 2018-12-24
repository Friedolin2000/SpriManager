

  
// -> time

/*
class AccSens implements SensorEventListener {  
  public void onSensorChanged(SensorEvent event) {   
    acc[0] = event.values[0]; 
    acc[1] = event.values[1];  
    acc[2] = event.values[2];
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
    acc[3] = accuracy;
  }
}

public byte[] float2b(float[] values){
  ByteBuffer buffer = ByteBuffer.allocate(4 * values.length);
  for (float value : values){
    buffer.putFloat(value);
  }
  return buffer.array();
}
*/
public byte[] int2b(int value){
  return ByteBuffer.allocate(4).putInt(value).array();
}
/*
float[] acc;

import android.content.Context;
import android.hardware.Sensor; 
import android.hardware.SensorManager; 
import android.hardware.SensorEvent; 
import android.hardware.SensorEventListener;
*/
import java.nio.ByteBuffer;/*
//SystemClock
import android.os.SystemClock;





/*
public byte[] getAppName(){
  return appName.get(this + "");// TODO if null -> add the app
}

public String getAccSave(){
  Time act = new Time();
  return getPath() + "/files/year" + year() + "/week" + act.toWeek() + "/" + act.toDate(true, false, false) + "/appInfo.txt";
}

public String getSettings(){
  return getPath() + "/else/appInfo.txt";
}








//int len;






public void initAcc(){
  SensorManager manager;
  Sensor sensor;
  AccSens listener;
  
  saves = new ArrayList<byte[]>();
  acc = new float[4];
  appName = getAppConverter();
  //len = 4;
  
  manager = (SensorManager) getActivity().getSystemService(Context.SENSOR_SERVICE); 
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  listener = new AccSens();
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
}








// shhdgdgdhdhdhdhdhdhdhddhdhhd
// warzondhdhdhfhjdjdjdhdhdhdhdhdhdh



public void autoAcc(){
  while(true){
    saveAcc();
    SystemClock.sleep(pauseAcc);
  }
}

public void autoSave(){
  while(true){
    //addSave(-1);
    flush("autoSave");
    SystemClock.sleep(pauseSave);
  }
}

// nextLayer dhdhdhdhdhdhdhdhdhdhdhdhdhdhd

public void saveAcc(){
  byte[] rV = new byte[12];
  byte[] val;
  if(last != acc[3]){
    val = float2b(new float[]{acc[3]});
    for(int j = 0; j < val.length; j ++){
      rV[j] = val[j];
    }
    addSave(rV, event.get("sensor"));
    last = acc[3];
  }
  
  
  for(int i = 0; i < 3; i ++){
    val = float2b(new float[]{acc[i]});
    for(int j = 0; j < val.length; j ++){
      rV[i * val.length + j] = val[j];
    }
  }
  // time : data
  
  addSave(rV, event.get("acc"));
}


public void addSave(byte[] values, byte id){
  byte[] rV = new byte[dataLength];
  byte[] cur = new Time().getBytes(id);
  for(int i = 0; i < cur.length; i ++){
    rV[i] = cur[i];
  }
  
  for(int i = 0; i < values.length; i ++){
    rV[cur.length + i] = values[i];
  }
  
  
  saves.add(rV);
}

float last;

ArrayList<byte[]> saves;
HashMap<String, Byte> event;

// gghhffghjehdhdhdhrhrjrururururur

public void addSave(String eventName){
  String appN = this + "";
  byte[] rV = appName.get(appN); // = appName
  if(rV == null){
    String[] info = loadStrings(getSettings());
    int ind = Integer.parseInt(info[0].split(": ")[1]);
    
    int id = info.length - ind;
    String[] nev = new String[info.length + 1];
    for(int i = 0; i < info.length; i ++){
      nev[i] = info[i];
    }
    
    rV = int2b(id);
    appName.put(appN, rV);
    nev[nev.length - 1] = appN + ":%: " + rV[0];
    for(int i = 1; i < rV.length; i ++){
      nev[nev.length - 1] += ":" + rV[i];
    }
    saveStrings(getSettings(), nev);
    
  }
  addSave(rV, event.get(eventName));
}

public HashMap<String, byte[]> getAppConverter(){
  HashMap<String, byte[]> appName = new HashMap<String, byte[]>();
  String[] info = loadStrings(getSettings());
  int ind = Integer.parseInt(info[0].split(": ")[1]);
  String[] sp;
  String[] bu;
  byte[] byt;
  for(int i = ind; i < info.length; i ++){
    //
    sp = info[i].split(":%: ");
    bu = sp[1].split(":");
    byt = new byte[bu.length];
    for(int j = 0; j < bu.length; j ++){
      byt[j] = Byte.parseByte(bu[j]);
    }
    appName.put(sp[0], byt);
  }
  //rV.put(this + "", null);
  
  pauseSave = Integer.parseInt(info[1].split(": ")[1]);
  pauseAcc = Integer.parseInt(info[2].split(": ")[1]);
  last = Float.parseFloat(info[3].split(": ")[1]);
  
  // also times + events
  initImportant();
  return appName;
}

HashMap<String, byte[]> appName;

int pauseSave, pauseAcc;

public void initImportant(){
  //pauseSave = 60000;
  //pauseAcc = 30000;
  
  event = new HashMap<String, Byte>();
  event.put("resume", (byte) 3); // app
  event.put("setup", (byte) 4); // app
  event.put("autoSave", (byte) 1); // app
  event.put("acc", (byte) 0); // data
  event.put("pause", (byte) 2); // app
  event.put("sensor", (byte) 5); // data + app?
  
  dataLength = 15; // 3 Time + 3x 4 acc
}

int dataLength;

// dhhdhdhddhhdjdjddjjdjfhfjfjfjfjfjf

public void flush(String eventName){
  addSave(eventName);
  // time : eventName : appName
  
  // id : time : 4 : 4 : 4
  
  byte[] info;
  try{
    info = loadBytes(getAccSave());
  } catch(Exception e){
    info = new byte[0];
  }
  byte[] nev = new byte[info.length + saves.size() * dataLength];
  byte[] cur;
  for(int i = 0; i < saves.size(); i ++){
    cur = saves.get(saves.size() - 1 - i);
    for(int j = 0; j < dataLength; j ++){
      nev[i * dataLength + j] = cur[j];
    }
  }
  for(int i = 0; i < info.length; i ++){
    nev[saves.size() * dataLength + i] = info[i];
  }
  
  saveBytes(getAccSave(), nev);
  saves = new ArrayList<byte[]>();
  
}


public void accSetup(){
  initAcc();
  addSave("setup");
  thread("autoAcc");
  thread("autoSave");
}

public void accResume(){
  try{
    addSave("resume");
    saveAcc();
  }catch(Exception e){}
}



public void accPause(){
  //printause " + new Time().toTime(true));
  saveAcc();
  //addSave("pause");
  flush("pause");
}
*/

