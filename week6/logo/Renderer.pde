interface Renderer{
  public void handleEvent(ControlEvent theEvent);
  void draw(PVector[] points, PGraphics g);
}
