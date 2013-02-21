import processing.pdf.*;
import java.util.Calendar;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

int print_width;
int print_height;
float make_bigger;
boolean saveImage;

ArrayList<Figure> rects;
ColorTheoryStrategy s;
ColorList colorList;

void setup() {
  print_width = 22; 
  print_height = 22;
  make_bigger = 35;  
  size(round(print_width * make_bigger), round(print_height * make_bigger));

  saveImage = false;  

  blendMode(MULTIPLY);
  //BLEND - linear interpolation of colours: C = A*factor + B. This is the default blending mode.
  //ADD - additive blending with white clip: C = min(A*factor + B, 255)
  //SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
  //DARKEST - only the darkest colour succeeds: C = min(A*factor, B)
  //LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)
  //DIFFERENCE - subtract colors from underlying image.
  //EXCLUSION - similar to DIFFERENCE, but less extreme.
  //MULTIPLY - multiply the colors, result will always be darker.
  //SCREEN - opposite multiply, uses inverse values of the colors.
  //REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values

  //bigger vertical figures
  Figure figure1 = new JaggedRect(x(2) - 3, y(2), w(4), h(8));
  Figure figure2 = new JaggedRect(x(6) + 3, y(2), w(4), h(8));
  //long on bottom
  Figure figure3 = new JaggedRect(x(3), y(7), w(5), h(2));

  rects = new ArrayList<Figure>();
  rects.add(figure1);
  rects.add(figure2);
  rects.add(figure3);

  generate();
}

void draw() {
  background(255);
  if (saveImage) 
  {
    beginRecord(PDF, "prints/+" + timestamp() + ".pdf");
  }

  for (int i = 0; i < rects.size(); i++) {
    rects.get(i).draw();
  }

  if (saveImage) 
  {
    endRecord();    
    saveImage = false;
  }
}

void generate() {
    
  ColorRange redPinks = new ColorRange(new FloatRange(0.9, 0.95), new FloatRange(0.8, 0.95), new FloatRange(0.8, 1), "red_pink");
  redPinks.addBrightnessRange(new FloatRange(0.3, 0.35));
  
  ColorRange blueGreens = new ColorRange(new FloatRange(0.43, 0.5), new FloatRange(0.8, 0.95), new FloatRange(0.8, 1), "red_pink");
  blueGreens.addBrightnessRange(new FloatRange(0.3, 0.35));
  
  ColorRange yellowOranges = new ColorRange(new FloatRange(0.1, 0.2), new FloatRange(0.8, 0.95), new FloatRange(0.8, 1), "yellow_orange");
  
  rects.get(0).c = redPinks.getColor();
  rects.get(1).c = blueGreens.getColor();
  rects.get(2).c = yellowOranges.getColor();
  
//  s = ColorTheoryRegistry.getRegisteredStrategies().get(9);
//  //8: compound
//  //9: complementary
//  TColor c = new ColorRange(new FloatRange(0.9, 0.95), new FloatRange(0.8, 0.95), new FloatRange(0.8, 1), "red_pink").getColor;
//  colorList = ColorList.createUsingStrategy(s, col);
//   for (int i = 0; i < rects.size(); i++) {
//   rects.get(i).c = colorList.get(i);
//   }   
  
  for (int i = 0; i < rects.size(); i++) {
    rects.get(i).generate();
  }
}

//Grid
int x(int gridPosX) {
  return width/12 * gridPosX;
}

int y(int gridPosY) {
  return height/12 * gridPosY;
}

int w(int units) {
  return x(units);
}

int h(int units) {
  return y(units);
}



void keyPressed() {
  if (key == 'g') {
    generate();
  }
  if (key == 'm') { //drawing mode
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).nextMode();
    }
  }
  if (key == 's') { //save
    saveImage = true;
  }   
  if (keyCode == LEFT) {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).x -= 5;
    }
  }
  if (keyCode == RIGHT) {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).x += 5;
    }
  }
  if (keyCode == UP) {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).y -= 5;
    }
  }
  if (keyCode == DOWN) {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).y += 5;
    }
  }
  if (key == '1') {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).w--;
      rects.get(i).h--;
    }
  }
  if (key == '2') {
    for (int i = 0; i < rects.size(); i++) {
      rects.get(i).w++;
      rects.get(i).h++;
    }
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

