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
    for(int i = 0; i < figures.size(); i++){
      Letter letter = (Letter)figures.get(i);
      letter.setUnit(ceil(random(w(0), w(1))));
      letter.x = x((int)random(2,4));
      letter.y = y((int)random(i,i+2));
      letter.rotate = random(0, 2*PI);
    }
  
  }
  
  void setNumberOfLines(int number){
    numberOfLines = number;
    for(int i = 0; i < figures.size(); i++){
      ((Letter)figures.get(i)).numberOfLines = number;
    }
  }
  
}
