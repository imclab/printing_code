import geomerative.*;
import processing.pdf.*;
import java.util.Calendar;

float print_width;
float print_height;
float make_bigger;
boolean saveImage;

ModularGrid grid;
boolean showGrid;
ArrayList<RShape> shapes; 
RShape title;
RShape titleBackground;

void setup()
{
  print_width = 14; 
  print_height = 17;
  make_bigger = 35;  
  saveImage = true; 
  showGrid = false;
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  smooth();
  
  setupShapes();
  background(0);
  generate();
}

void draw() {
  
}

void generate() {
  background(0);
  
  int minCols = 2;
  int maxCols = 7;
  int minRows = 2;
  int maxRows = 10;
  
  int cols = (int)random(minCols, maxCols);
  int rows = (int)random(minRows, maxRows);
  int gutter = (int)random(40, 80);
  int pageMargin = (int)random(40, 80);
  grid = new ModularGrid(cols, rows, gutter, pageMargin);

  //lines
  strokeWeight(random(0.1, 0.5));
  int numberOfLines = (int)random(2, 50);
  int numberOfModules = (int)random(3, grid.rows);
  
  for (int i = 0; i < numberOfModules; i++) {
    boolean vertical = random(0, 1) > 0.5; //half the groups of lines will be vertical, half horizontal
    int moduleX = (int)random(0, grid.cols);
    int moduleY = (int)random(0, grid.rows);
    
    pushMatrix();
    rotate(radians(random(-20, 20)));
    
    for (int j = 0; j < numberOfLines; j++) {      
      Module module = grid.modules[moduleX][moduleY];      

      stroke(255);      
      if (vertical){
        float xi = module.x +(float)j*module.w/numberOfLines;
        line(xi, -height, xi, 2*height);//grid.getInnerHeight()+ pageMargin
      }
      else {
        float yi = module.y + (float)j*module.h/numberOfLines;
        line(-width, yi, 2*width, yi); // grid.getInnerWidth() + pageMargin
      }
    }
    popMatrix();
  }

  //title background
  int moduleX = (int)random(0, grid.cols/2);
  int moduleY = (int)random(0, grid.rows/2);
  Module module = grid.modules[moduleX][moduleY];  

  //float randomWidth = random(title.width + 2*gutter, width); //grid.cols*module.w
  float randomWidth = title.width + 2*gutter; //not using random for now
  float randomHeight = random(title.height + 2*gutter, grid.rows*module.h);//grid.rows*module.h
  
  pushMatrix();
  scale(random(0.2, 1));
  fill(255);
  rect(module.x, module.y, randomWidth, randomHeight);  

  //title
  fill(0);
  stroke(0);  
  float scale = (title.width - 2*gutter)/module.w;
  translate(module.x + gutter, module.y + gutter);
  title.draw();
  popMatrix();  
}

void keyPressed() {
  if (key == 'g') {
    if (saveImage) 
  {
    beginRecord(PDF, "prints/+" + timestamp() + ".pdf");
  }
  generate();
  if (showGrid) {
    grid.display();
  }
  if (saveImage) 
  {
    endRecord();    
    //saveImage = false;
  }
    
  }
  if (key == 's') { //save
    saveImage = true;
  }
  if (key == 'd') {
    showGrid = !showGrid;
  }
}


void setupShapes()
{
  RG.init(this);
  RG.ignoreStyles(true);
  shapes = new ArrayList<RShape>();

  title = RG.loadShape("title_0.svg");
  titleBackground = RG.loadShape("title_back.svg");  

  shapes.add(title);
  shapes.add(titleBackground);
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

