public class GraphButton extends Button{
  
  public GraphButton(){
    super();
    
    
    setPointSize(0);
    setTxtHeight(ySize / 4.0);
    setOffset(txtHeight / 4);
    setGraphSize((int) abs((xSize - 2 * offset) / 12));
    setFrameCol(0);
    setLineCol(color(39, 76, 148));
    
    
    txtHeightSet = false;
    graphSizeSet = false;
    
    
    renderH = -1;
  }
  
  public String autoSave(){
    String rV = "";
    for(int i = 0; i < graph.length; i ++){
      rV += graph[i];
      if(i < graph.length - 1){
        rV += ", ";
      }
    }
    
    return rV;
  }
  
  public void loadAutoSave(String auto){
    String[] gGraph = auto.split(", ");
    if(gGraph.length == 1 && gGraph[0].equals("")){
      
      gGraph = new String[0];
    }
    
    float[] zw = new float[gGraph.length];
    for(int i = 0; i < zw.length; i ++){
      zw[i] = Float.parseFloat(gGraph[i]);
    }
    graph = zw;
    
  }
  
  public GraphButton setXSize(float xSize){
    super.setXSize(xSize);
    if(!graphSizeSet){
      setGraphSize((int) ((xSize - 2 * offset) / 12));
    
    }
    
    return this;
  }
  
  boolean txtHeightSet, graphSizeSet;
  
  
  public GraphButton setYSize(float ySize){
    super.setYSize(ySize);
    //refreshLine();
    if(!txtHeightSet){
      setTxtHeight(ySize / 4.0);
    }
    return this;
  }
  
  /**
    0 - 100.0
  */
  public GraphButton setGraphSize(int size){
    this.graph = new float[size]; //xPos + size * xSize / 100.0;
    graphSizeSet = true;
    return this;
  }
  
  public GraphButton setGraph(float[] graph){
    this.graph = graph;
    return this;
  }
  
  public GraphButton setPointSize(float size){
    this.pointSize = size;
    return this;
  }
  
  
  
  
  public GraphButton setOffset(float off){
    this.offset = off;
    return this;
  }
  
  public GraphButton setTxtHeight(float txtHeight){
    this.txtHeight = txtHeight;
    txtHeightSet = true;
    return this;
  }
  
  public GraphButton setFrameCol(int col){
    this.frameCol = col;
    return this;
  }
  
  public GraphButton setLineCol(int lCol){
    this.lineCol = lCol;
    return this;
  }
  
  float txtHeight;
  
  float line;
  float offset;
  
  float[] graph;
  
  float pointSize;
  
  int lineCol, frameCol;
  
  
  public void render(){
    fill(col);
    rect(xPos, yPos, xSize, ySize);
    
    new TextPanel(txt, xPos, yPos, xSize, txtHeight).setCol(txtCol).render();
    
    
    float minPos = yPos + ySize - offset;
    float maxPos = yPos + txtHeight + offset / 2;
    
    float xxPos = xPos + offset;
    
    stroke(frameCol);
    line(xxPos, minPos, xxPos, maxPos);
    line(xxPos, minPos, xPos + xSize - offset, minPos);
    
    float dif = (minPos - maxPos) / 100.0;
    float last = minPos - graph[0] * dif;
    float smallSize = (xSize - 2.0 * offset) / (graph.length - 1);
    
    stroke(lineCol);
    // so that first entry is also rendered
    ellipse(xxPos, last, pointSize, pointSize);
    if(renderH == 0){
      renderHx = xxPos;
      renderHy = last;
    }
    
    float x;
    for(int i = 1; i < graph.length; i ++){
      
      line(xxPos + (i - 1) * smallSize, last, xxPos + i * smallSize, minPos - graph[i] * dif);
      last = minPos - graph[i] * dif;
      
      x = xxPos + i * smallSize;
      ellipse(x, last, pointSize, pointSize);
      
      if(i == renderH){
        renderHx = x;
        renderHy = last;
      }
    }
    
    
  }
  
  float renderHx, renderHy;
  
  public void afterRender(){
    if(renderH != -1){
      
      
      line(renderHx, 0, renderHx, height);
      line(0, renderHy, width, renderHy);
      
      
      renderH = -1;
    }
  }
  
  
  
  public float[] getGraph(){
    return graph;
  }
  
  
  public void tickPress(){
    if(tickButton()){
     int x = (int) ((graph.length - 1) * (mouseX - offset - xPos) / (xSize - 2 * offset) + 0.5);
     if(x < 0){
       x = 0;
     } else if(x >= graph.length){
       x = graph.length - 1;
     }
     
     float y = 100 * (mouseY - offset / 2 - txtHeight - yPos) / (ySize - 1.5 * offset - txtHeight);
     if(y < 0){
       y = 0;
     } else if(y > 100){
       y = 100;
     }
     
     y = 100 - y;
     
     graph[x] = y;
     
     renderH = x;
     
     useProc.doRender();
    }
  }
  
  int renderH;
  
}