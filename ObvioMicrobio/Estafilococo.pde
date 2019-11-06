class Estafilococo extends SquareBacteria {
  Estafilococo(float x, float y) {
    super(x, y, 20, 18);
    this.img = loadImage("images/estafilococo.png");
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
    image(img, -(w/2), -(h/2), w, h);
    popMatrix();
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
