class Lactobacilo extends Bacteria {
  Lactobacilo(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.img = loadImage("images/lactobacillus.png");
    this.incrementSize = 1.0; //especializar
  }

  void display() {
    //fill(c);
    noFill();
    noStroke();
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    //ellipse(0, 0, w, w);
    image(img, -(w/2), -(w/2), w, w);
    popMatrix();
  }

  public void applyAcidity() {
  }
  public void applyHumidity() {
  }
  public void applyOxygen() {
  }
  public void applyNutrients() {
  }
  boolean isReady() {
    return false;
  }
}
