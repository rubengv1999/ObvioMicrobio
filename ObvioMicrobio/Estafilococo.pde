class Estafilococo extends SquareBacteria {
  Estafilococo(float x, float y) {
    super(x, y, 20, 18);
    this.img = loadImage("images/estafilococo.png");
  }

  public void applyOxygen() {
    if (oxygen && humidity >= 0.9)
    {
      startMoving();
    } else
    {
      slowDown(-1, 0.01);      
    }
  }
}
