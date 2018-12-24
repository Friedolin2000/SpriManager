
public String[] remove(String[] info, String toRem){
  boolean after = false;
  String[] rV = new String[info.length - 1];
  for(int i = 0; i < rV.length; i ++){
    if(!after){
      if(info[i].equals(toRem)){
        after = true;
      }
    }
    
    if(after){
      rV[i] = info[i + 1];
    } else {
      rV[i] = info[i];
    }
  }
  
  if(!after){
    return info;
  }
  
  return rV;
}



// strength: 100 -> abs, 0 -> f'(0) = 1
// in formel: große Zahl -> abs

public float intervalStart(float x, float start, float strength){
  float rV;
  if(strength >= 100){
    if(start < x){
      rV = 1;
    } else if(start == x){
      rV = 0.5;
    } else {
      rV = 0;
    }
  } else {
    rV = 1.0 / (exp((-x - start) * 100.0 / (100.0 - strength)) + 1.0);
  }
  return rV;
}

public float intervalEnd(float x, float end, float strength){
  float rV;
  if(strength >= 100){
    if(end > x){
      rV = 1;
    } else if(end == x){
      rV = 0.5;
    } else {
      rV = 0;
    }
  } else {
    rV = 1.0 / (exp((x - end) * 100.0 / (100.0 - strength)) + 1.0);
  }
  return rV;
}

public float sigmoid(float x){
  return sigmoid(x, 0);
}

public float sigmoid(float x, float strength){
  if(strength == 100){
    if(x < 0){
      return 1;
    } else if(x == 0){
      return 0.5;
    } else {
      return 0;
    }
  }
  return  1.0 / (exp(x * 100.0 / (100.0 - strength)) + 1.0);
}

public float interval(float x, float start, float end, float strength){
  float rV;
  rV = intervalStart(x, start, strength);
  rV += intervalEnd(x, end, strength);
  rV -= 1;
  
  return rV;
}


public float sigmoid(float x, float start, float end, boolean rising){
  float rV = (x - start) / (end - start);
  
  // hoe to plot x between 0 and 1 for start to end
  
  float xx = rV * rV;
  rV = 3 * xx - 2 * rV * xx;
  
  
  // -2x^3 + 3x^2
  /*
    
    1.f(start) = 0
    2.f'(start) = 0
    3.f(start + (end - start) / 2.0) = 0.5
    4.f(end) = 1
    5.f'(end) = 0
    
    6.maybe f'(start + (end - start) / 2.0) = 1 ?
    7.maybe f''(start + (end - start) / 2.0) = 0 ?
    
    f(x) = ax^3 + bx^2 + cx
    f'(x) = 3ax^2 + 2bx + c
    
    
    -> factor of frame and extra must be all sigmoids of posses added together
    
    
    
  */
  
  if(!rising){
    rV = 1 - rV;
  }
  
  
  return rV;
}


public float cap(float x, float cap, boolean up){
  float rV = x;
  
  if((up && x > cap) || (!up && x < cap)){
    rV = cap;
  }
  return rV;
}


public String[] getInfo(String path){
  //String path = getPath() + "/Dia/spri/" + isNR + "Spos.txt";
  String[] info = null;
  try{info = loadStrings(path);
  } catch(Exception e){}
  if(info == null){
    info = new String[0];
  }
  return info;
}




public float dist(float xFac, float x1, float y1, float x2, float y2){
  float x = (x2 - x1);
  x *= x;
  x /= xFac;
  
  float y = (y2 - y1);
  y *= y;
  y /= yFactor;
  
  return sqrt(x + y);
}




