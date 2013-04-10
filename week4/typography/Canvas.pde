class Canvas {
  ArrayList<Figure> figures;
  int w, h;
  boolean drawGrid;
  int cols, rows;

  Canvas() {
    w = width;
    h = height;
    drawGrid = true;
    cols = 5;
    rows = 5;
  }

  void draw() {
    if (drawGrid) {
      for (int i=0; i < cols; i++) {
        line(x(i), 0, x(i), height);
      }
      for (int j=0; j < rows; j++) {
        line(0, y(j), width, y(j));
      }
    }
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
    return w/cols * gridPosX;
  }

  int y(int gridPosY) {
    return h/rows * gridPosY;
  }

  int w(int units) {
    return x(units);
  }

  int h(int units) {
    return y(units);
  }

  void moveLeft() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).x -= 5;
    }
  }

  void moveRight() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).x += 5;
    }
  }

  void moveUp() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).y -= 5;
    }
  }

  void moveDown() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).y += 5;
    }
  }

  void bigger() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).w--;
      figures.get(i).h--;
    }
  }

  void smaller() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).w++;
      figures.get(i).h++;
    }
  }

  void nextMode() {
    for (int i = 0; i < figures.size(); i++) {
      figures.get(i).nextMode();
    }
  }
}

