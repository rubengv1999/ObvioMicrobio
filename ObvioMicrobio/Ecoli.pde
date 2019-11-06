class Ecoli extends SquareBacteria {
  Ecoli(float x, float y) {
    super(x, y, 10, 20);
    this.img = loadImage("images/ecoli.png");
    this.incrementSize = 1.0005;
  }

  public void applyOxygen() {
  }
}
