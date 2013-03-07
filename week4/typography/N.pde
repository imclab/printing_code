class N extends Letter {  
  N() {
    
  }
  
  void setup(){
    h = 4 * unit;
    w = ceil(6/10.0 * h);
  }
  
  void drawSpecific() {  
    //pendiente: deltaX / deltaY = w/h
    // = (w-unit/2) / (h - y) => (
    noFill();
    stroke(0);
    line(0, 0, 0, h);
    
    fill(0);    
    beginShape();
    vertex(0, 0);
    vertex(unit/2, 0);
    vertex(w, (w - unit/2)*h/w);
    vertex(w, h);    
    endShape(CLOSE);
    
    line(w, h, w, 0);
    line(w, 0, w - unit/2, 0);
    
    float separation = w / (float)numberOfLines;
    for(int i = 0; i < numberOfLines; i++){
      //strokeWeight(map(i, 0, numberOfLines, strokeMin, strokeMax));
      line(0, 0, separation*i, h);   
    }
    
  }
}

