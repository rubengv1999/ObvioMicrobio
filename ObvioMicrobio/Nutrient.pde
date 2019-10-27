class Nutrient {
  float x, y, capacity, size;
  Body body;
  Vec2 speed;
  ArrayList<Bacteria> eaters;


  Nutrient() {
    eaters = new ArrayList();
    float randomX, randomY;
    double distance;
    do {
      randomX = random(width);
      randomY = random(height);
      distance = Math.hypot(Math.abs(height/2 - randomY), Math.abs(width/2 - randomX));
    } while (distance >  height / 2 - 20);
    this.x = randomX;
    this.y = randomY;
    this.capacity = random(100);
    this.speed = new Vec2(random(-25, 25), random(-25, 25));
    this.size = (float)Math.sqrt(capacity);
    createBody();
  }
  void createBody() {
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.setPosition(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bodyDef);

    CircleShape shape = new CircleShape();
    shape.setRadius(box2d.scalarPixelsToWorld(size));

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
    fill(#3723C1, capacity);
    noStroke();
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    ellipse(0, 0, size, size);
    popMatrix();
  }

  boolean isDead() {
    if (capacity <= 0) {
      box2d.destroyBody(body);
      for (Bacteria bacteria : bacterias)
        bacteria.nutrients--;
      return true;
    }
    return false;
  }

  void aliment() {
    for (Bacteria bacteria : eaters) {
      if (!bacteria.dead) {
        bacteria.eat();
        capacity -= 0.1;
      }
    }
  }

  void addBacteria(Bacteria b) {
    b.nutrients--;
    eaters.add(b);
  }

  void removeBacteria(Bacteria b) {
    b.nutrients--;
    eaters.remove(b);
  }
}
