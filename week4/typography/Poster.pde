class Poster extends Canvas{
  int numberOfLines;
  
  Poster(){
    figures = new ArrayList<Figure>(w(1)/2);
    numberOfLines = 60;
    
    int unit = w(1)/2;  
    S s = new S();    
    O o = new O();
    N n = new N();
    G g = new G();
    S s2 = new S();

    figures.add(s);
    figures.add(o);
    figures.add(n);
    figures.add(g);
    figures.add(s2);
    
    generate();
  }
  
  void generate(){    
    int cols = 5;
    for(int i = 0; i < figures.size(); i++){
      Letter letter = (Letter)figures.get(i);
      int letterUnit = w(1)/5;
      letter.setUnit(letterUnit);
      
      int xPos = x((i) % cols);
      int yPos = y((int)(i /cols));
      letter.x = xPos + (w(1) - letter.getWidth())/2;//centered
      letter.y = yPos;//centered   // 
    }
  
  }
  
  void setNumberOfLines(int number){
    numberOfLines = number;
    for(int i = 0; i < figures.size(); i++){
      ((Letter)figures.get(i)).numberOfLines = number;
    }
  }
  
}
