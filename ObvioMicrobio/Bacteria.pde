abstract class Bacteria {
  float x, y, w, h, energy;
  Body body;
  color c;
  PImage img;
  boolean dead;

  Bacteria(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = color(random(255), random(255), random(255));
    this.dead = false;
    this.energy = 100;
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
    noStroke();
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    ellipse(0, 0, w, w);
    popMatrix();
  }

  public void applyAll() {
    applyAcidity();
    applyHumidity();
    applyOxygen();
    applyNutrients();
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

  public abstract void applyAcidity(); 
  public abstract void applyHumidity();
  public abstract void applyOxygen();
  public abstract void applyNutrients();
}
