import processing.pdf.*;
import java.util.Calendar;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;


int print_width;
int print_height;
float make_bigger;
boolean saveImage;

Poster poster;

void setup() {
  print_width = 22; 
  print_height = 22;
  make_bigger = 35;  
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  smooth();
  saveImage = false; 
  poster = new Poster();
}

void draw() {
  background(255);
  if (saveImage) 
  {
    beginRecord(PDF, "prints/+" + timestamp() + ".pdf");
  }

  poster.draw();

  if (saveImage) 
  {
    endRecord();    
    saveImage = false;
  }
}

void keyPressed() {
  if (key == 'g') {
    poster.generate();
  }
  if (key == 'm') { //drawing mode
    poster.nextMode();
    
  }
  if (key == 's') { //save
    saveImage = true;
  }   
  if (keyCode == LEFT) {
    poster.moveLeft();
  }
  if (keyCode == RIGHT) {
    poster.moveRight();
  }
  if (keyCode == UP) {
    poster.moveUp();
  }
  if (keyCode == DOWN) {
    poster.moveDown();
  }
  if (key == '1') {
    poster.bigger();
  }
  if (key == '2') {
    poster.smaller();
  }
  if (key == '3') {
    poster.setNumberOfLines(poster.numberOfLines + 1);
  }
  if (key == '4') {
    poster.setNumberOfLines(poster.numberOfLines - 1);
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

