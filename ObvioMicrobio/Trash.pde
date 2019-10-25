class Trash {
  float x, y;
  Body body;
  Vec2 speed;

  Trash(float x, float y) {
    this.x = x;
    this.y = y;
    this.speed = new Vec2(random(-25, 25), random(-25, 25));
    createBody();
  }
  void createBody() {
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.setPosition(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bodyDef);

    CircleShape shape = new CircleShape();
    shape.setRadius(box2d.scalarPixelsToWorld(5));

    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.density = 1;
    fixtureDef.friction = 0.3;
    fixtureDef.restitution = 0.5;

    body.createFixture(fixtureDef);
    body.setUserData(this);

    Vec2 pos = body.getWorldCenter();
    body.applyForce(speed, pos);
  }


  void display() {
    fill(#BC6C04);
    noStroke();
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    ellipse(0, 0, 5, 5);
    popMatrix();
  }
}
