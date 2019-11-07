class Estafilococo extends SquareBacteria {
  Estafilococo(float x, float y) {
    super(x, y, 20, 18);
    this.img = loadImage("images/estafilococo.png");
    this.incrementSize = 1.0; //especializar
  }

  public void applyOxygen() {
    if (oxygen)
    {
      startMoving();
    } else
    {
      slowDown(-1, 0.01);      
    }
  }
}
