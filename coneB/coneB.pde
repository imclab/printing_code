import processing.pdf.*;

int print_width;
int print_height;
float make_bigger;

void setup(){
  print_width = 17; 
  print_height = 22;
  make_bigger = 35;
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  
  beginRecord(PDF, "grab.pdf");
  background(0);
  noStroke();
  ellipseMode(CORNER);  
  background(255);

  fill(0);
  //background
  rect(0, 0, 612, 436);
  triangle(0, 435, 612, 574, 612, 435);
  //ice cream
  ellipse(238, 477, 141, 141); 
  fill(255);
  //hide bottom
  rect(230, 583, 156, 50); 
  //spill
  fill(0);    
  ellipse(197, 545, 207, 54);
  ellipse(159, 596, 51, 13);
  //cone
  fill(255);  
  triangle(361, 261, 262, 495, 374, 521);
  endRecord();
  
}



