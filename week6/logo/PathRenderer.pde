class PathRenderer implements Renderer {
  int innerPaths;
  float trazo;

  PathRenderer() {
    trazo = 0.5;
    innerPaths = 1;
  }
  void draw(PVector[] points, PGraphics g) {
    g.noFill();
    g.strokeWeight(trazo * g.width);
    
    float step = 1 - 1/(float)innerPaths;
    pushMatrix();
    
    for(int i = 0; i < innerPaths; i ++){      
      drawPath(points, g);      
      g.scale(step);       
    }    
    popMatrix();
  }
  
  void drawPath(PVector[] points, PGraphics g){
    g.beginShape();
    for (int i=0; i< points.length; i++) {//512 or more vertexes: crashes!! why?? there are 601 vertexes in array.
      g.vertex(points[i].x, points[i].y, points[i].z);
    }
    g.endShape();
    
    
  }

  public void handleEvent(ControlEvent theEvent) {
    if (theEvent.getName() == "trazo") {
      trazo = theEvent.getController().getValue()/100.0;
    }  
    if (theEvent.getName() == "innerPaths") {      
      innerPaths = (int)theEvent.getController().getValue();
    }  
  }
}

