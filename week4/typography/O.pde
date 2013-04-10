class O extends Letter {
  int radius;  
  int separationRatio;

  O() {
    
  }
  
  void setup(){
    radius = 2 * unit;
    separationRatio = 2;
  }
  
  int getWidth(){
    return radius*2;
  } 
  
  void drawSpecific() {  
    //rect(0, 0, 100, 100);
    translate(radius, radius);

    noFill();
    stroke(0);
    beginShape();     
    arcVertexes(0, 360, radius, true);
    endShape(CLOSE);

    fill(0);
    noStroke();
    beginShape();     
    arcVertexes(270, 360+90, radius, true);
    arcVertexes(270, 360+90, radius*7/10, false);
    endShape(CLOSE);

    noFill();
    stroke(0);


    for (int i = 0; i < numberOfLines; i++) {//
      int separation = radius/numberOfLines;
      int r = separation * i * separationRatio;
      

      PVector pTop = new PVector(0, -radius);
      PVector pBottom = new PVector(0, +radius);
      PVector pC1 = new PVector(pTop.x + r, pTop.y);
      PVector pC2 = new PVector(pBottom.x + r, pBottom.y);

      //draw control points
//      fill(0, 255, 0);
//      ellipse(pTop.x, pTop.y, 10, 10);
//      ellipse(pBottom.x, pBottom.y, 10, 10);
//      fill(255, 0, 0);
//      ellipse(pC1.x, pC1.y, 10, 10);
//      ellipse(pC2.x, pC2.y, 10, 10);
      if(pC1.x < radius){
        noFill();      
        //strokeWeight(map(i, 0, numberOfLines, strokeMin, strokeMax));
        beginShape();
        vertex(pTop.x, pTop.y);
        bezierVertex(pC1.x, pC1.y, pC2.x, pC2.y, pBottom.x, pBottom.y);
        endShape();
      }
      
    }
  }
}

