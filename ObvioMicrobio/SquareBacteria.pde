abstract class SquareBacteria extends Bacteria {
  SquareBacteria(float x, float y, float w, float h) {
    super(x, y, w, h);
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
    body.setLinearVelocity(speed);//applyForce(speed);
    setRotation();
    body.setUserData(this);
  }
}
