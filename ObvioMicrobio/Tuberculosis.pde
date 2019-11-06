class Tuberculosis extends SquareBacteria {
  Tuberculosis(float x, float y) {
    super(x, y, 13, 13);
    this.img = loadImage("images/tuberculosis.png");
    this.incrementSize = 1.0; //especializar
    this.acidityPerfect = 6.6;
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
    if (!oxygen) energy--;
  }
}
