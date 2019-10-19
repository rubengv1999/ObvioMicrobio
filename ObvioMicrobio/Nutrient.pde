class Nutrient {
  float x, y, capacity, size;
  Body body;
  

  Nutrient() {
    float randomX, randomY;
    double distance;
    do {
      randomX = random(width);
      randomY = random(height);
      distance = Math.hypot(Math.abs(height/2 - randomY), Math.abs(width/2 - randomX));
    } while (distance >  height / 2 - 10);
    this.x = randomX;
    this.y = randomY;
    this.capacity = random(100);
    size = (float)Math.sqrt(capacity);
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
  }

  void display() {
    fill(0,capacity);
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
    if (capacity <= 0){
      box2d.destroyBody(body);
      return true;
    }
    return false;
 }
}
