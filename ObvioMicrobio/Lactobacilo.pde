class Lactobacilo extends CircularBacteria {
  Lactobacilo(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/lactobacillus.png");
    this.incrementSize = 1.0; //especializar
  }

  public void applyOxygen() {
  }
}
