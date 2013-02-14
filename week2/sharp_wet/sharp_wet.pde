import processing.pdf.*;

int print_width;
int print_height;
float make_bigger;
boolean saveImage;
int mode;

int w, h, posX, posY;
int numberOfSawPoints; 
int[] sawHeights;
int separation;

void setup(){
  print_width = 17; 
  print_height = 22;
  make_bigger = 35;  
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  
  saveImage = false;
  mode = 0;
  
  posX = width/3;
  posY = 196;//height/3;  
  w = width/3;
  h = height/4;
  numberOfSawPoints = 20;
  sawHeights = new int[numberOfSawPoints];
  separation = 4;
  
  generateSawHeights();
  drawShapes();
  
}

void generateSawHeights(){
  for(int i = 0; i <  numberOfSawPoints; i++){
    sawHeights[i] = round(random(0, h));
  }
}

void draw(){
  if(saveImage) 
  {
    beginRecord(PDF, "prints/sharp_wet_" + second() + millis() + ".pdf");
  }
  drawShapes();
  if(saveImage) 
  {
    endRecord();    
    saveImage = false;
  }
}

void drawShapes(){
  //ice  
  background(0);
  noStroke();
  beginShape();
  vertex(posX, posY + h/2);
  drawSaw();
  vertex(posX + w, posY + h/2);
  vertex(posX + w, posY + h);
  vertex(posX, posY + h);
  endShape();
  int iceBottom = posY + h;
  //water
  if(mode == 0){ 
    stroke(255);
    strokeWeight(0.5);
    line(0, iceBottom, width, iceBottom);
  }  
  //reflection
  else if(mode == 1){
    int y = iceBottom + separation;
    rect(posX, y, w, height - y); 
  }
  //solid water
  else if(mode == 2){
    rect(0, iceBottom - 1, width, height -iceBottom);
  }  
  // reflection lines
  else if(mode == 3){
    int lineHeight = 7;
    for(int i = 1; i < 10; i++){
      int y = iceBottom + i*lineHeight; 
      stroke(255); 
      strokeWeight(1); 
      //rect(posX, y + i*lineHeight + i*separation, w, lineHeight/i);
      line(posX, y, posX + w, y);
    }
    
  }
    
}

void drawSaw(){
  for(int i = 0; i <  numberOfSawPoints; i++){
    int shiftX = round(random(-5, 3));
    vertex( posX + (w / numberOfSawPoints * i), posY + sawHeights[i]);
    //vertex( posX + (w / numberOfSawPoints * i), posY + h - 5); //go back down
  }
}

void keyPressed(){
  if(key == 'g'){ //regenerate
    generateSawHeights();
  }
  if(key == 'm'){ //drawing mode
    mode = (mode + 1) % 4;
  }
  if(key == 's'){ //save
    saveImage = true;
  }   
  if(keyCode == LEFT){
    posX -= 5;
  }
  if(keyCode == RIGHT){
    posX += 5;
  }
  if(keyCode == UP){
    posY -= 5;
    println(posY);
  }
  if(keyCode == DOWN){
    posY += 5;
  }
  if(key == '1'){
    w--;
    h--;
  }
  if(key == '2'){
    w++;
    h++;
  }
  if(key == 'o'){
    separation --;
  }
  if(key == 'p'){
    separation ++;
  }  
  
}

