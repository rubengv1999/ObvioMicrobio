class Lactobacilo extends CircularBacteria {
  Lactobacilo(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/lactobacillus.png");
  }

  public void applyOxygen() {
  }
}
