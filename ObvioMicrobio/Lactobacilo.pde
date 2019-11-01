class Lactobacilo extends CircularBacteria {
  Lactobacilo(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/lactobacillus.png");
    this.incrementSize = 1.0; //especializar
  }

  void display() {
    noFill();
    noStroke();
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    image(img, -(w/2), -(w/2), w, w);
    popMatrix();
  }

  public void applyOxygen() {
  }
}
