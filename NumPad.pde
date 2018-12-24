public class NumPad extends UseProc{
  
  /*
  todo:
  
  updateMinus() <----
  keyMinus()
  keyNum().last if
  
  
  ----
  
  String is immer act
  so when working with float:
  -refreshFromString
  
  -refreshToString(valText, writeValue)
  
  */
  
  public NumPad(){
    super();
    writeValue = "6"; // set
    
    yKeyBoardPos = height - width;
    
    yButtonSize = yKeyBoardPos / 3;
    
    
    keySize = width/4;
    keys = new TextPanel[4 * 4];
    setKey(0, 0, "1");
    setKey(0, 1, "2");
    setKey(0, 2, "3");
    setKey(0, 3, "<{]");
    setKey(1, 0, "4");
    setKey(1, 1, "5");
    setKey(1, 2, "6");
    setKey(1, 3, "^");
    setKey(2, 0, "7");
    setKey(2, 1, "8");
    setKey(2, 2, "9");
    setKey(2, 3, "v");
    setKey(3, 0, "<");
    setKey(3, 1, "0");
    setKey(3, 2, ".");
    setKey(3, 3, ">");
    
    //keys[16] = new TextPanel("^", 0, 0, width/3, yButtonSize, yButtonSize/12);
    //keys[17] = new TextPanel("v", 0, 0, width/3, yButtonSize, yButtonSize/12);
    
    
    
    name = new String[]{"test"}; // set
    unit = new String[]{"x"}; // set
    length = new int[]{2}; // set
    komma = new int[]{1}; // sey
    
    setInd = 0; //(set)
    
    type = new int[]{-2}; // set
    
    valPos = new float[4];
    
    refreshType();
    
    refreshValText();
    old = 1;//new int[]{1, 2};
    
    refreshValue(); // implement in constructor
  }
  
  String[] name, unit;
  int setInd;
  int[] type;
  int[] length, komma;
  String writeValue;
  long old;
  
  float yKeyBoardPos, keySize, yButtonSize, arrSize;
  
  float[] valPos;
  
  TextPanel[] keys;
  TextPanel valText;
  
  
  // ---- setup still
  
  protected void setKey(int y, int x, String text){
    keys[x + y * 4] = new TextPanel(text, x * width/4, height - width + y * width/4, width/4, width/4, width/12);
  }
  
  // ----- half
  
  public void refreshValText(){
    String txt = name[setInd] + ": " + writeValue + " " + unit[setInd];
    valText = new TextPanel(txt, 0, yButtonSize, width, yButtonSize, width/12);
    // TODO sizes for keyValue()...
    
    valPos[0] = width / 2 - textWidth(txt) / 2; // namePos
    valPos[1] = valPos[0] + textWidth(name[setInd] + ":"); // valPos
    valPos[2] = valPos[1] + textWidth(writeValue + "  "); // unitPos
    valPos[3] = valPos[2] + textWidth(unit[setInd]); // voidPos
    
    
  }
  
  // ------
  
  public void render(){
    renderButton();
    renderValue();
    renderKeyBoard();
  }
  
  public void renderButton(){
    float x, y, xS, yS;
    int tLen = length[setInd] + komma[setInd];
    y = 0;
    xS = arrSize; //width/3;
    yS = yButtonSize;
    
    for(int i = 0; i < tLen; i ++){
      x = i * xS;
      fill(225);
      rect(x, y, xS, yS);
      new TextPanel("^", x, y, xS, yS).render();
    }
    y = yButtonSize * 2;
    for(int i = 0; i < tLen; i ++){
      x = i * xS;
      fill(225);
      rect(x, y, xS, yS);
      new TextPanel("v", x, y, xS, yS).render();
    }
  }
  
  public void renderValue(){
    fill(250);
    rect(0, yButtonSize, width, yButtonSize);
    //refreshValText();
    valText.render();
  }
  
  
  public void renderKeyBoard(){
    fill(255);
    //rect(0, yKeyBoardPos, width, width);
    for(int y = 0; y < 4; y ++){
      for(int x = 0; x < 4; x ++){
        fill(255);
        rect(x * keySize, yKeyBoardPos + y * keySize, keySize, keySize);
        keys[x + y * 4].render();
      }
    }
  }
  
  
  
  
  
  public void tickButtons(){
    tickAddButton();
    tickChangeButton();
    tickKeyBoard();
  }
  
  public void tickAddButton(){
    if(mouseY < 3 * yButtonSize){
      int dec = (int) ((width - mouseX) / arrSize);
      // todo: length * mouseY/width
      
      //dec -= komma[setInd];
      
      if(mouseY < yButtonSize){
        keyAdd(true, dec);
      } else if(mouseY > 2 * yButtonSize){
        keyAdd(false, dec);
      }
    }
  }
  
  public void tickChangeButton(){
    if(mouseY > yButtonSize && mouseY < 2 * yButtonSize){
      if(mouseX < valPos[0]){
        keyVoid();
      } else if(mouseX < valPos[1]){
        keyName();
      } else if(mouseX < valPos[1]){
        keyValue();
      } else if(mouseX < valPos[1]){
        keyUnit();
      } else {
        keyVoid();
      }
    }
  }
  
  public void tickKeyBoard(){
    int x = mouseX * 4/width;
    int y = (mouseY - (height - width)) * 4/width;
    
    int psi = x + y * 4;
    if(mouseY < height - width){
      psi = -1;
    }
    
    switch(psi){
      case 0:
        keyNum(1);
        break;
      case 1:
        keyNum(2);
        break;
      case 2:
        keyNum(3);
        break;
      case 3:
        keyDelete();
        break;
      case 4:
        keyNum(4);
        break;
      case 5:
        keyNum(5);
        break;
      case 6:
        keyNum(6);
        break;
      case 7:
        keyUp();
        break;
      case 8:
        keyNum(7);
        break;
      case 9:
        keyNum(8);
        break;
      case 10:
        keyNum(9);
        break;
      case 11:
        keyDown();
        break;
      case 12:
        keyBack();
        break;
      case 13:
        keyNum(0);
        break;
      case 14:
        keyMinus();
        break;
      case 15:
        keyEnter();
        break;
      default:
      
    }
    
    
  }
  
  
  public long getValue(){
    long rV = old;
    try{
      String[] sp = writeValue.split("\\.");
      
      String sec = "";
      int lef = komma[setInd];
      try{
        sec += sp[1];
        lef = komma[setInd] - sp[1].length();
      } catch(Exception e){
        //lef = komma[st
      }
      for(int i = 0; i < lef; i ++){
        sec += "0";
      }
      
      rV = Long.parseLong(sp[0] + sec);
    }catch(Exception e){}
    return rV;
  }
  
  public void refreshValue(long value){
    String s = value + "";
    old = value;
    
    writeValue = "";
    for(int i = 0; i < s.length(); i ++){
      if(i == s.length() - komma[setInd]){
        writeValue += ".";
      }
      writeValue += s.charAt(i);
    }
    
    //
    //refreshValText();
    refreshValue();
  }
  
  public void refreshValue(){
    refreshValText();
    renderValue();
  }
  
  
  public void refreshType(){
    arrSize = width / (length[setInd] + komma[setInd]);
    
  }
  
  public void updateMinus(){
    boolean b = false;
    
    updateMinus(b);
  }
  
  public void updateMinus(boolean minus){
    
  }
  
  
  public long convertTo(int oldInd, long oldValue, int nevInd){
    
    // @Override
    return 0;
  }
  
  public void doMinus(){
    
  }
  
  public void doPoint(){
    
  }
  
  
  public void keyAdd(boolean up, int dec){
    long value = getValue();
    
    
    int down = -1;
    if(up){
      down = 1;
    }
    
    value += pow(10, dec) * down;
    
    refreshValue(value);
    vibrate(vibBut);
  }
  
  public void keyVoid(){}
  public void keyName(){}
  public void keyValue(){
    int oldInd = setInd;
    setInd --;
    //int nevInd = setInd;
    if(setInd < 0){
      setInd = unit.length - 1;
    }
    
    if(oldInd != setInd){
      refreshValue(convertTo(oldInd, getValue(), setInd));
      refreshType();
      vibrate(vibBut);
    }
  }
  
  public void keyUnit(){
    int oldInd = setInd;
    setInd ++;
    //int nevInd = setInd;
    setInd %= unit.length;
    if(oldInd != setInd){
      refreshValue(convertTo(oldInd, getValue(), setInd));
      refreshType();
      vibrate(vibBut);
    }
    vibrate(vibBut);
  }
  
  public void keyDelete(){
    try{
      String txt = writeValue;
      writeValue = txt.substring(0, txt.length() - 1); // TODo
      updateMinus();
      refreshValue();
      vibrate(vibBut);
    } catch(StringIndexOutOfBoundsException e){
      
    }
    
  }
  
  public void keyMinus(){
    // TODO
    if(writeValue.length() < 1){
      writeValue += "-";
    } else {
      writeValue += ".";
    }
    refreshValue();
        /*boolean out = false;
        // TODO type
        String[] sp = writeValue.split("");
        for(int i = 0; i < sp.length && !out; i ++){
          if(sp[i].equals(".")){
            out = true;
            break;
          }
        }
        if(!out){
          writeValue += ".";
        }*/
    //vibrate(vibBut);
  }
  
  public void keyNum(int num){
    int l = writeValue.length();
      
    if(l == length[setInd] && abs(type[setInd]) == 2){
      writeValue += "." + num;
      updateMinus(true);
      refreshValue();
      vibrate(vibBut);
    } else if(l < length[setInd] + komma[setInd] + 2){
      writeValue += num + "";
      refreshValue();
      vibrate(vibBut);
    }
  }
  
  
  public void keyBack(){}
  public void keyEnter(){}
  public void keyUp(){}
  public void keyDown(){}
  
}
