class Clostridium extends CircularBacteria {
  Clostridium(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/clostridium.png");
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
