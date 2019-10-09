class Bacteria {
  float x, y, w;
  Body body;
  color c;

  Bacteria(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.c = color(random(255), random(255), random(255));
    createBody();
  }

  void createBody() {
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.setPosition(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bodyDef);

    CircleShape shape = new CircleShape();
    shape.setRadius(box2d.scalarPixelsToWorld(w/2));

    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.density = 1;
    fixtureDef.friction = 0.3;
    fixtureDef.restitution = 0.5;

    body.createFixture(fixtureDef);
  }


  void display() {
    fill(c);
    stroke(255);
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    ellipse(0, 0, w, w);
    popMatrix();
  }


  boolean isDead() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height + w)
    {
      box2d.destroyBody(body);
      return true;
    }
    return false;
  }
}
