class Figure {
  int x, y, w, h;
  float rotate;
  TColor c;  
  int mode;
  
  float strokeWeight;
  
  Figure(){
    x = width/12*2;
    y = width/12*2;  
    w = width/12*4;
    h = height/12*8; 
    rotate = 0;
    
    strokeWeight = 0.25; 
    
    c = ColorRange.INTENSE.getColor();

    mode = 0;
    generate();  
  }
  

  void generate() {
    
  }
  
  int getWidth(){//to be overriden by subclasses
    return 0;
  } 

  void draw() {   
    strokeWeight(strokeWeight);
    fill(c.toARGB());   
    pushMatrix();
    translate(x,y);
    rotate(rotate);
    drawSpecific();
    popMatrix();
  }
  

  void drawSpecific() { //to be overriden by subclasses.
  }

  void nextMode() {
    mode = (mode + 1) % 4;
  }
}

