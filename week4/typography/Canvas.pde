class Canvas {
  ArrayList<Figure> figures;
  int w, h;

  Canvas() {
    w = width;
    h = height;
  }
  
  void draw() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).draw();
    }
  }

  void generate() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).generate();
    }
  }

  //Grid
  int x(int gridPosX) {
    return w/12 * gridPosX;
  }

  int y(int gridPosY) {
    return h/12 * gridPosY;
  }

  int w(int units) {
    return x(units);
  }

  int h(int units) {
    return y(units);
  }
  
  void moveLeft(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).x -= 5;
    }
  }
  
  void moveRight(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).x += 5;
    }
  }
  
  void moveUp(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).y -= 5;
    }
  }
  
  void moveDown(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).y += 5;
    }
  }
  
  void bigger(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).w--;
      figures.get(i).h--;
    }
  }
  
  void smaller(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).w++;
      figures.get(i).h++;
    }
  }
  
  void nextMode(){
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).nextMode();
    }
  }
  
}

