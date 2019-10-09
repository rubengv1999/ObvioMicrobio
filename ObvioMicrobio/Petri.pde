class Petri {
  ArrayList<Vec2> points;

  Petri() {
    points = new ArrayList();
    makeBody();
  }

  void makeBody() {
    BodyDef bodyDef = new BodyDef();
    bodyDef.setPosition(new Vec2(0, 0));

    Body body = box2d.createBody(bodyDef);

    //Crear Puntos
    float angle = TWO_PI / 50;
    float radius = height / 2;
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = width/2 + cos(a) * radius;
      float sy = height/ 2 + sin(a) * radius;
      points.add(new Vec2(sx, sy));
    }
    points.add(new Vec2(width/2 + cos(0) * radius, height/ 2 + sin(0) * radius));  

    Vec2[] worldPoints = new Vec2[points.size()];
    for (int i = 0; i < points.size(); i++) {
      worldPoints[i] = box2d.coordPixelsToWorld(points.get(i));
    }

    ChainShape chainShape = new ChainShape();
    chainShape.createChain(worldPoints, worldPoints.length);

    body.createFixture(chainShape, 1);
  }

  void display() {
    strokeWeight(3);
    stroke(255);
    for (int i = 0; i < points.size() - 1; i++) {
      Vec2 a = points.get(i);
      Vec2 b = points.get(i+1);
      line(a.x, a.y, b.x, b.y);
    }
  }
}
