class Tuberculosis extends SquareBacteria {
  Tuberculosis(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/tuberculosis.png");
    this.incrementSize = 1.0; //especializar
    this.acidityPerfect = 6.6;
  }

  public void applyOxygen() {
    if (!oxygen) energy--;
  }
}
