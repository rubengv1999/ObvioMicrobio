class Tuberculosis extends Bacteria {
  Tuberculosis(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.img = loadImage("images/tuberculosis.png");
  }

  void createBody() {
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.setPosition(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bodyDef);

    PolygonShape shape = new PolygonShape();
    float w2d = box2d.scalarPixelsToWorld(w/2);
    float h2d = box2d.scalarPixelsToWorld(h/2);
    shape.setAsBox(w2d, h2d);

    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.density = 1;
    fixtureDef.friction = 0.3;
    fixtureDef.restitution = 0.5;

    body.createFixture(fixtureDef);
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
    rect(0, 0, w, h);
    image(img, -(w/2), -(h/2), w, h);
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
}
