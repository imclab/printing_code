import processing.pdf.*;

public enum Shape{ELLIPSE, RECT};
class Figure implements ControlListener {
  LissajousPoints screenPoints, printPoints;
  PGraphics screen, print;
  ArrayList<Renderer> renderers;
  float zoom; 
  float rotationX, rotationY, scaleX, scaleY;
  int strokeColor, background;
  //background shape
  int mode; //for background shape. 0: ellipse. 1: rect.
  int size;
  int printSize;
  int originalSize;
  int originalPrintSize;

  Figure(int screenWidth, int screenHeight, int printWidth, int printHeight) {
    strokeColor = 255;
    background = 0;
    zoom = -0.8; //hack
    scaleX = 1;
    scaleY = 1;
    rotationX = 0;
    rotationY = 0;
    
    screen = createGraphics(screenWidth, screenHeight, P3D);      
    print = createGraphics(printPixelWidth, printPixelHeight, P3D);
    
    screenPoints = new LissajousPoints(screen.width);
    printPoints = new LissajousPoints(print.width);
    renderers = new ArrayList<Renderer>();
    renderers.add(new PathRenderer());
    
    mode = 0;
    originalSize = size = (int)(screenHeight*1.5);
    originalPrintSize = printSize = (int)(printHeight*1.5);
  }
  
  PGraphics getScreenImage(){
    draw(screen, screenPoints);
    return screen;
  }
  
  PGraphics getPrintImage(){
    draw(print, printPoints);
    return print;
  }
  
  void saveScreenImage(String filename){
    size = (int)(screen.height*1.5);
    getScreenImage().save(filename + ".png");
  }
  
  void savePrintImage(String filename){
    size = (int)(print.height*1.5);
    getPrintImage().save(filename + ".tiff");
  }
  
  //doesn't work (need to do projection to 2D before using PDF renderer)
//  void savePDF(String filename){
//    beginRecord(PDF, "prints/" + filename);
//    background(background);
//    stroke(strokeColor);
//    translate(g.width/2, g.height/2, zoom * g.width); 
//    scale(scaleX, scaleY);  
//    rotateX(-rotationX);
//    rotateY(rotationY); 
//    renderers.get(mode).draw(screenPoints.getPoints(), g);    
//
//    endRecord();
//  }

  void draw(PGraphics g, LissajousPoints points) {
    g.beginDraw();
    g.background(background);
    g.translate(g.width/2, g.height/2, 0);     
    
    //draw background image
    g.pushMatrix();
    g.translate(0, 0, zoom * g.width * 2);    
    g.fill(0,0,0);
    g.noStroke();
    g.rectMode(CENTER);
    switch(mode){
      case 0:
        g.ellipse(0,0,size,size);
      break;
      case 1:
        g.rect(0,0,size,size);
      break;
    }
    
    g.popMatrix();
    
    //g.translate(g.width/2, g.height/2, zoom * g.width); 
    g.translate(0, 0, zoom * g.width); 
    g.stroke(strokeColor);
    g.scale(scaleX, scaleY);  
    g.rotateX(-rotationX);
    g.rotateY(rotationY); 
        
    renderers.get(0).draw(points.getPoints(), g);    
    g.endDraw();
  }

  public void controlEvent(ControlEvent theEvent) {    
    //zoom = (int)theEvent.getController().getValue();
    if (theEvent.getName() == "zoom") {      
      zoom = -(int)theEvent.getController().getValue()/screen.width; //should be handled in main event handler (renderer shouldn't know about 'view')
    }
    if (theEvent.getName() == "size") {            
      size = (int)((float)theEvent.getController().getValue()/(float)50.0 * originalSize); //should be handled in main event handler (renderer shouldn't know about 'view')
      printSize =   (int)((float)theEvent.getController().getValue()/(float)50.0 * originalPrintSize);
  }
    if (theEvent.getName() == "rect_ellipse") {            
      mode += 1;
      mode = mode % 2;
    }
    screenPoints.handleEvent(theEvent); 
    printPoints.handleEvent(theEvent);  
    for(int i = 0; i < renderers.size(); i++){
      renderers.get(i).handleEvent(theEvent);
    }
    
  }
}

