class Clostridium extends CircularBacteria {
  Clostridium(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/clostridium.png");
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
