class Estafilococo extends SquareBacteria {
  Estafilococo(float x, float y) {
    super(x, y, 20, 18);
    this.img = loadImage("images/estafilococo.png");
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
