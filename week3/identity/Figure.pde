class Figure {
  int w, h, x, y;
  float rotate;
  TColor c;  
  int mode;

  Figure() {
    x = width/12*2;
    y = width/12*2;  
    w = width/12*4;
    h = height/12*8; 
    rotate = 0;
    
    c = ColorRange.INTENSE.getColor();

    mode = 0;
    generate();
  }

  void generate() {
  }

  void draw() {   
    noStroke();
    fill(c.toARGB());   
    pushMatrix();
    //rotate(rotate);
    drawSpecific();
    popMatrix();
  }

  void drawSpecific() { //to be overriden by subclasses.
  }

  void nextMode() {
    mode = (mode + 1) % 4;
  }
}

