class Letter extends Figure{

  int numberOfLines;
  float strokeMin, strokeMax;  
  int unit;
  
  Letter(){
    numberOfLines = 60;
    strokeMin = 0.5; 
    strokeMax = 2; 
    setup();
  }
  
  void setUnit(int _unit){
    unit = _unit;
    setup();
  }
  
  void setup(){ //to be overriden by subclasses
  }
  
 
  
  
  PVector arcVertexes(int start, int stop, int shapeRadius, boolean clockwise){
    PVector lastPoint = new PVector(); 
    float arcRatio = abs(stop-start)/360.0;    
    int numVertices = ceil(arcRatio * 360); //50 vertices: circle.     
    int vertexDegree = abs(start-stop) / numVertices;
    
    
    int step = 1;//should adjust. need less vertices.
    if (clockwise) {
      //for (int alpha = start; alpha <= stop; alpha += step)
      for (int i = 0; i <= numVertices; i++)
      {
        int alpha = i*vertexDegree+start;
        lastPoint = drawVertex(alpha, shapeRadius, false);
        
      }
    }
    else{
      for (int i = numVertices; i >= 0; i--)
      {
        lastPoint = drawVertex(i*vertexDegree+start, shapeRadius, false);
      }
    }
    return lastPoint;
  }

  PVector drawVertex(int alpha, int shapeRadius, boolean curved) {
    PVector lastPoint = new PVector();
    float vertexX = cos(radians(alpha)) * shapeRadius;
    float vertexY = sin(radians(alpha)) * shapeRadius;
    if(curved){
       curveVertex(vertexX, vertexY);       
    }
    else{
      vertex(vertexX, vertexY);
    }
    lastPoint.x = vertexX;
    lastPoint.y = vertexY;
    return lastPoint;
  }
  
}
