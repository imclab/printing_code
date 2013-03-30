

import processing.opengl.*;
import java.util.List;
import controlP5.*;

import ddf.minim.*;
import ddf.minim.ugens.*;

Figure figure;

Minim       minim;
AudioOutput out;
Oscil       waveX , waveY, waveZ;
int minFreq, maxFreq;
int baseFreq;

ControlP5 cp5;
RadioButton r;
PVector currentScale;
int interfaceHeight, interfaceYpos;
int viewWidth, viewHeight;
int printPixelWidth, printPixelHeight;
boolean black_white;

// ------ mouse interaction ------
int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0, zoom = 140;
float rotationX = 0, rotationY = 0, targetRotationX = 0, targetRotationY = 0, clickRotationX, clickRotationY; 


void setup() {  
  minFreq = 220;
  maxFreq = 440;
  baseFreq = minFreq;
  black_white = true;  
  size(600, 800, P3D);
  background(0);
  interfaceHeight = 200;  
  interfaceYpos = height - interfaceHeight;
  viewWidth = width;
  viewHeight = height - interfaceHeight;  
  
  //in inches: 8*10
  printPixelWidth = width*4;
  printPixelHeight = height*4;
  /*
  printPixelWidth = 5000;
  printPixelHeight = 3750;
  */    
     
  figure = new Figure(viewWidth, viewHeight, printPixelWidth, printPixelHeight);
  //setupAudio();  
  setupInterface();
}

void draw() {
  
  drawFigure();  
  //updateAudio();
  
}

void updateAudio(){
  baseFreq = (int)map(figure.screenPoints.freqX, 1, 20, minFreq, maxFreq); //hack: these are the possible slider values.
  waveX.setFrequency(baseFreq);
  float ratioY = figure.screenPoints.freqY/figure.screenPoints.freqX;
  float ratioZ = figure.screenPoints.freqZ/figure.screenPoints.freqX;  
  waveY.setFrequency(baseFreq * ratioY);
  waveZ.setFrequency(baseFreq * ratioZ);
}

void drawFigure(){
  updateViewCamera();  
  image(figure.getScreenImage(), 0, 0, viewWidth, viewHeight);
  
}
void updateViewCamera() {
  if (mousePressed && mouseY < interfaceYpos) {
    offsetX = mouseX-clickX;
    offsetY = mouseY-clickY;
    targetRotationX = min(max(clickRotationX + offsetY/float(viewWidth) * TWO_PI, -HALF_PI), HALF_PI);
    targetRotationY = clickRotationY + offsetX/float(viewHeight) * TWO_PI;
  }
  rotationX += (targetRotationX-rotationX)*0.25; 
  rotationY += (targetRotationY-rotationY)*0.25;  
  figure.rotationX =-rotationX;
  figure.rotationY = rotationY;
}

void setupAudio(){
  minim = new Minim(this);
  out = minim.getLineOut();
  waveX = new Oscil( baseFreq, 0.5f, Waves.SINE );
  float ratioY = figure.screenPoints.freqY/figure.screenPoints.freqX;
  float ratioZ = figure.screenPoints.freqZ/figure.screenPoints.freqX;
  
  waveY = new Oscil( baseFreq * ratioY, 0.5f, Waves.SINE);
  waveZ = new Oscil( baseFreq * ratioZ, 0.5f, Waves.SINE );
  waveX.patch(out);
  waveY.patch(out);
  waveZ.patch(out);
}

void setupInterface() {  
  cp5 = new ControlP5(this);
  cp5.setColorBackground(color(40,40,40));
  int space = 10; 
  
  cp5.addSlider("freqX", 1, 20)
    .setNumberOfTickMarks(20)
    .setValue(3)
    .snapToTickMarks(true)
    .setPosition(50, interfaceYpos + space)
      .linebreak();

  cp5.addSlider("freqY", 1, 24)
  .setPosition(50, interfaceYpos + space * 2)
    .setValue(4)
    .snapToTickMarks(true)
    .setNumberOfTickMarks(24)
      .linebreak();

  cp5.addSlider("freqZ", 1, 29)
    .snapToTickMarks(true)
    .setValue(5)
    .setNumberOfTickMarks(29)
    .setPosition(50, interfaceYpos + space*3)
      .linebreak();
      
      
  cp5.addSlider("zoom", 3000, 100)
  .setPosition(235, interfaceYpos + space)  
  .linebreak(); 
  
  
  cp5.addSlider("phiX", 0, 360)
  .setPosition(235, interfaceYpos + space*2)  
  .linebreak();    
  
  cp5.addSlider("phiY", 0, 360)
  .setPosition(235, interfaceYpos + space*3)  
  .linebreak();    
  
  cp5.addSlider("trazo", 0.5, 10)
  .setPosition(400, interfaceYpos + space)  
  .linebreak();    
  
  cp5.addSlider("pointCount", 400, 500)
  .setPosition(400, interfaceYpos + space*2) 
  .linebreak(); 
  
  cp5.addSlider("size", 10, 100)
  .setPosition(50, interfaceYpos + space*10)
    .setValue(4)
      .linebreak();
      
  cp5.addToggle("rect_ellipse")
  .setPosition(50, interfaceYpos + space*12)
    .setColorActive(100)
      .setColorBackground(color(255, 255, 255))
        .setSize(50, 20)
          .setValue(true)
            .setMode(ControlP5.SWITCH)
              .linebreak();
  

List<ControllerInterface<?>> list = cp5.getAll();
  for (ControllerInterface c: list) {
    ((controlP5.Controller)c).addListener(figure);
    ((controlP5.Controller)c).setColorForeground(color(255,255,255));
    ((controlP5.Controller)c).setColorValueLabel(color(0,0,0));
    ((controlP5.Controller)c).setColorBackground(color(50,50,50));
    ((controlP5.Controller)c).setColorActive(color(255,255,255));
  }
  
  cp5.addToggle("black_white")
  .setPosition(50, interfaceYpos + space*6)
    .setColorActive(100)
      .setColorBackground(color(255, 255, 255))
        .setSize(50, 20)
          .setValue(true)
            .setMode(ControlP5.SWITCH)
              .linebreak();
  
  cp5.addButton("saveImage")
  .setPosition(235, interfaceYpos + space*10)
  .linebreak();
  
  
  
  cp5.loadProperties("poster.properties");
}

public void controlEvent(ControlEvent theEvent) {          
  if (theEvent.getName() == "saveImage") { 
    String timestamp = year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second();       
    String filename = "prints/image_" + timestamp;
    println("Saving image...");  
    //SMALL PNG
    figure.saveScreenImage(filename );
    //BIG TIFF 
    figure.savePrintImage(filename);
    //PDF
    //figure.savePDF("image_" + timestamp + ".pdf");
    
    
    //settings (for reference)
    this.g.save("settings_" + timestamp + ".png");
    
    println("Image saved. Timestamp: " + timestamp); 
  }
  if(theEvent.getName() == "updateImage"){
    //drawFigure();  
  }
  if(theEvent.getName() == "black_white"){
    if(black_white){
      figure.strokeColor = 255;
      figure.background = 255;
      black_white = true;
    }
    else{
      figure.strokeColor = 255;
      figure.background = 0;
      black_white = false;
    }
  }
}

void mousePressed() {
  clickX = mouseX;
  clickY = mouseY;
  clickRotationX = rotationX;
  clickRotationY = rotationY;
}

void exit() {
  cp5.saveProperties(("poster.properties"));
}

