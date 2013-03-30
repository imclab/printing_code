class LissajousPoints {

  PVector[] lissajousPoints;
  int pointCount = 40;//511;//512 or more vertexes: crashes!! why?? there are 601 vertexes in array.
  int freqX = 1;
  int freqY = 4;
  int freqZ = 2;
  float phiX = 0;
  float phiY = 0;
  int w; 

  LissajousPoints(int _w) {    
    w = _w;
  }
  
  PVector[] getPoints(){
    if(lissajousPoints == null){
      calculateLissajousPoints();
    }
    return lissajousPoints;
  }
  
  void calculateLissajousPoints() {
  lissajousPoints = new PVector[pointCount+1];;
  float f = w/2;

  for (int i = 0; i <= pointCount; i++) {
    float angle = map(i, 0, pointCount, 0, TWO_PI);
    float x = sin(angle*freqX+radians(phiX)) * sin(angle*2) * f;
    float y = sin(angle*freqY+radians(phiY)) * f;
    float z = sin(angle*freqZ) * f;
    lissajousPoints[i] = new PVector(x, y, z);
  }
}

  public void handleEvent(ControlEvent theEvent) {    
    boolean changed = false;  
    if (theEvent.getName() == "freqX") {      
      freqX = (int)theEvent.getController().getValue();
      changed = true;
    }
    if (theEvent.getName() == "freqY") {      
      freqY = (int)theEvent.getController().getValue();
      changed = true;
    }
    if (theEvent.getName() == "freqZ") {      
      freqZ = (int)theEvent.getController().getValue();
      changed = true;
    }
    if (theEvent.getName() == "phiX") {      
      phiX = (int)theEvent.getController().getValue();
      changed = true;
    }
    if (theEvent.getName() == "phiY") {      
      phiY = (int)theEvent.getController().getValue();
      changed = true;
    }
    if(theEvent.getName() == "pointCount")
    {
      float countPercentage = (int)theEvent.getController().getValue()/(figure.screen.width + 0.0);//TO DO: this is a hack... should be handled in main.
      pointCount = floor(countPercentage * w);
      changed  = true;
    }
    if(changed){
      calculateLissajousPoints();
    }
    
    
  }  

}

