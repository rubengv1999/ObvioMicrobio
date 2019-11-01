class Ecoli extends SquareBacteria {
  Ecoli(float x, float y) {
    super(x, y, 10, 20);
    this.img = loadImage("images/ecoli.png");
    this.incrementSize = 1.0005;
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
    image(img, -(w/2), -(h/2), w, h);
    popMatrix();
  }

  public void applyOxygen() {
  }
}
