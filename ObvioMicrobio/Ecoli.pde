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
    rect(0, 0, w, h);
    image(img, -(w/2), -(h/2), w, h);
    popMatrix();
  }

  void isDead() {//Especializar
    super.isDead();
    if (dead)
      this.img.filter(GRAY);
  }


  public void applyAcidity() {
    if (acidity > 9 || acidity < 5) {
      energy -= 1;
    } else if (acidity > 10 || acidity < 3) {
      energy -= 5;
    }
  }
  
  public void applyOxygen() {
  }

  boolean isReady() {
    return ((100 * w) / initW) >= 150;
  }
}
