class JaggedRect extends Figure{
  
  int jagMin, jagMax;
  
  int shiftA;
  int shiftB;
  int shiftC;
  int shiftD;
 
  int shiftAB;
  int shiftBC;
  int shiftCD;
  int shiftDA;
  
  
  
  JaggedRect(){
  }
  
  JaggedRect(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    generate();
  }
  
  void generate(){
    
    jagMin = 1; 
    jagMax = 4; 
    shiftAB = (int)random(-jagMax,jagMax);
    shiftBC = (int)random(-jagMax,jagMax);
    shiftCD = (int)random(-jagMax,jagMax);
    shiftDA = (int)random(-jagMax,jagMax);
    
    float vertexJagMin = jagMin*1.5;
    float vertexJagMax = jagMax*1.5;
    shiftA = (int)random(vertexJagMin, vertexJagMax);
    shiftB = (int)random(vertexJagMin, vertexJagMax);
    shiftC = (int)random(vertexJagMin, vertexJagMax);
    shiftD = (int)random(vertexJagMin, vertexJagMax);
  }
  
  void drawSpecific() { 
    
    beginShape();
    vertex(x + shiftA, y + shiftA); //A
    vertex(x + w/2, y + shiftAB);  //AB it's a horizontal line, so shift Y  
    
    vertex(x + w - shiftB, y + shiftB); //B
    vertex(x + w + shiftBC, y + h/2); //BC it's a vertical line, so shift X
    
    vertex(x + w - shiftC, y + h - shiftC); //C
    vertex(x + w/2, y + h + shiftCD);//CD is horizontal
    
    vertex(x + shiftD, y + h - shiftD); //D
    vertex(x + shiftDA, y + h/2); //DA is vertical
    
    endShape();        
  }
}
