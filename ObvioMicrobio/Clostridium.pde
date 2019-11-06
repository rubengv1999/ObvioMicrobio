class Clostridium extends CircularBacteria {
  Clostridium(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/clostridium.png");
    this.incrementSize = 1.0; //especializar
  }

  public void applyOxygen() {
    if (oxygen)
    {
      startMoving();
    } else
    {
      stopDownOx();
    }
  }
}
