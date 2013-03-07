class S extends Letter {
  int radius;
  S() {
  }
  
  void setup(){
    radius = unit;
  }
  void drawSpecific() {  
    //rect(0, 0, 100, 100);
    translate(radius, radius); 
    
    fill(0);
    noStroke();
    beginShape();     
    arcVertexes(90, 270, radius, true);
    arcVertexes(90, 270, radius/2, false);
    endShape(CLOSE);
    
    noFill();
    stroke(0);    
    beginShape();
    arcVertexes(90, 360, radius, true);
    endShape();
    
    translate(0, 2*radius);
    beginShape();
    arcVertexes(-90, 180, radius, true);
    endShape();
    
    translate(-(radius + radius/2), 0);
    line(0, 0, radius, 0);
    
  }
  
}

