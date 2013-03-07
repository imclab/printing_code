class G extends Letter { 
  int radius;
  
  G() {
    
  }
  
  void setup(){
    radius = 2 * unit;
  }

  void drawSpecific() {  
    translate(radius, radius);

    noFill();
    stroke(0);
    beginShape();     
    arcVertexes(0, 315, radius, true);
    endShape();

    fill(0);
    stroke(0);
    beginShape();     
    PVector lastArcPoint = arcVertexes(0, 15, radius, true);
    vertex(0, lastArcPoint.y);
    vertex(0, 0);    
    endShape(CLOSE);

    for (int i = 0; i <= numberOfLines; i++) {//
      float separation = radius/(float)numberOfLines;
      float r = separation * i;


      PVector pTop = new PVector(r, 2);      
      PVector pC1 = new PVector(r, -10);
      PVector pBottom = new PVector(0, radius);
      PVector pC2 = new PVector(map(i, 0, numberOfLines, 0, radius), radius);

      noFill();      
      stroke(0);
      //strokeWeight(map(i, 0, numberOfLines, strokeMin, strokeMax));
      beginShape();
      vertex(pTop.x, pTop.y);
      bezierVertex(pC1.x, pC1.y, pC2.x, pC2.y, pBottom.x, pBottom.y);
      endShape();
    }
  }
}

