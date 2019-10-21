abstract class Bacteria {
  float x, y, w, h, energy, initW, initH, incrementSize, trashPercent;
  Body body;
  color c;
  PImage img;
  boolean dead;
  ArrayList<Nutrient> nutrients;

  Bacteria(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.initW = w;
    this.initH = h;
    this.c = color(#FFFFFF);
    this.dead = false;
    this.energy = 100;
    this.trashPercent = 0;
    nutrients = new ArrayList();
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
    body.setUserData(this);
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

  void isDead() {
    if (energy <= 0)
      dead = true;
  }

  void changeColor() {
    c = color(#6281D3);
  }
  void revertColor() {
    c = color(#880062);
  }

  void addNutrient(Nutrient nutrient) {
    this.nutrients.add(nutrient);
    changeColor();
  }

  void removeNutrient(Nutrient nutrient) {
    this.nutrients.remove(nutrient);
    revertColor();
  }

  public void restart() {
    w = initW;
    h = initH;
    Vec2 pos = box2d.getBodyPixelCoord(body);
    x = pos.x;
    y = pos.y;
    box2d.destroyBody(body);
    createBody();
  }
  
  void applyForce(Vec2 force){
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
  
  public void applyNutrients() {
    if (nutrients.size() > 0) {
      for (Nutrient nutrient : this.nutrients) {
        w = w * incrementSize;
        h = h * incrementSize;
        //changeColor();
        nutrient.capacity -= 0.1;
        trashPercent += 0.05;
      }
      Vec2 pos = box2d.getBodyPixelCoord(body);
      x = pos.x;
      y = pos.y;
      box2d.destroyBody(body);
      createBody();
    }
  }
  
  public boolean generateTrash(){
    if (trashPercent >= 40){
      trashPercent = 0;
      return true;
    }
    else
      return false;
  }
  
  public abstract void applyAcidity(); 
  public abstract void applyHumidity();
  public abstract void applyOxygen();
  abstract boolean isReady();
}
