class Petri {
  int sides;
  float radius;

  Petri() {
    sides = 100;
    radius = height / 2;
    makeBody();
  }

  void makeBody() {
    BodyDef bodyDef = new BodyDef();
    bodyDef.setPosition(new Vec2(0, 0));
    Body body = box2d.createBody(bodyDef);

    //Crear Puntos
    Vec2[] worldPoints = new Vec2[sides];
    float angle = TWO_PI / sides;
    float a = 0;
    for (int i = 0; i < sides - 1; i++) {
      float sx = width/2 + cos(a) * radius;
      float sy = height/ 2 + sin(a) * radius;
      Vec2 vec2 = new Vec2(sx, sy);
      worldPoints[i] = box2d.coordPixelsToWorld(vec2);
      a += angle;
    }
    worldPoints[sides - 1] = worldPoints[0];

    //Crear ChainShape
    ChainShape chainShape = new ChainShape();
    chainShape.createChain(worldPoints, sides);
    body.createFixture(chainShape, 1);
  }

  void display() {
    strokeWeight(3);
    stroke(255);
    noFill();
    ellipse(width/2, height/2, radius*2, radius*2);
  }
}
