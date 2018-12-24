

PVector[] poss;


public void loadRecPp(){
  int[] acceptedSpris = new int[]{
    3 * 3 * 2 * 2, 2 * 3 * 2 * 2
  };
  
 // PVector[] poss;
  String[] info = getInfo(getPath() + "/Dia/spri/" + isNR + "Spos.txt");
  
  
  possLen = info.length;
  
  if(isNR){
    possLen = (int) cap(possLen, acceptedSpris[0], true);
  } else {
    possLen = (int) cap(possLen, acceptedSpris[1], true);
  }
  
  String[] sp;
  poss = new PVector[possLen];
  for(int i = 0; i < possLen; i ++){
    sp = info[i].split(" ");
    
    
    poss[i] = new PVector(Float.parseFloat(sp[0]), Float.parseFloat(sp[1]));
  }
  
  
  int xSize = width;
  
  
  // w : 2 * h / 7 WARNING v
  int ySize = (int) (xSize * 2.0 * height / (7.0 * width));
  //int ySize = (int) (xSize * height / width);
  
  
  
  
  float div = 1000.0 * poss.length;
  
  //float num = 10;
  float max = 0;
  float min = height;
  //float xPos, yPos;
  
  
  
  
  
  
  float c;
  float[][] sum = new float[xSize][ySize];
  for(int y = 0; y < ySize; y ++){
    for(int x = 0; x < xSize; x ++){
      
      c = div / getC(x, y, poss, xSize, ySize);
      sum[x][y] = c;
      if(c > max){
        max = c;
        
        xRecPos = width * x / xSize;
        yRecPos = 2.0 * height * y / (ySize * 7.0);
        
      } else if(c < min){
        min = c;
        
        //xxPos = width * x / xSize;
        //yyPos = height * y / ySize;
      }
    }
  }
  
  
  
  // I need the highest
  // color each layer + alpha -> div
  // -> <: red(255 0 0) >: green(0 255 0)
  // need num of layers... -> make rest dependend on that? how?
  // 
  
  float a;
  PImage rV = createImage(xSize, ySize, ARGB);
  rV.loadPixels();
  for(int y = 0; y < ySize; y ++){
    for(int x = 0; x < xSize; x ++){
      
      a = 255 * (sum[x][y] - min) / (max - min);
      
      rV.pixels[y * xSize + x] =
        color(255 - a, a, 0, 255 * getTrans(sum[x][y], min, max));
        // min -> 0; middle -> 255; max -> 0
        
    }
  }
  rV.updatePixels();
  
  recPp = rV;
  
  useProc.doRender(); //WARNING
  
}




public float getTrans(float pos, float min, float max){
  float rV = (pos - min) / (max - min);
  rV = 2.0 * rV - 1;
  rV = 1.0 - rV * rV;
  
  return rV;
}






public float calcImportance(float pos, float max){
  float rV = 0;// exp(pos);
  //rV = max - pos / 2.0;
  //rV = 1.0 / (1.0 + exp(pos / max - 0.5));
  // with sigmoid function
  rV = sigmoid(pos + 1, 0, max, false);
  return rV;
}




public float getExtra(float x, float y, float xS, float yS, float imp){
  float rV = 0;
  if(isNR){
    
    rV = imp / dist(x, y, xS / 2.0, yS / 2.0);
    
    
  } else {
    
    rV = imp / dist(x, y, x, yS / 2.0);
    
    
  }
  
  return rV;
}


public float getC(float x, float y, PVector[] poss, float xSize, float ySize){
  float c = 0;
  float impor = 0.5 * poss.length + 0.5;
  float imporX = impor * impX;
  float imporY = impor * impY;
  
  
  float frame = x;
  if(xSize - x < x){
    frame = xSize - x;
  }
  c += imporX / frame;
  
  frame = y;
  if(ySize - y < y){
    frame = ySize - y;
  }
  c += imporY / frame;
  
  
  c += getExtra(x, y, xSize, ySize, impor);
  
  float d;
  for(int i = 0; i < poss.length; i ++){
    d = dist(xFactor, x, y, poss[i].x * xSize, poss[i].y * ySize);
    c += 4.0 * calcImportance(i, poss.length) / d;
  }
  
  return c;
}


