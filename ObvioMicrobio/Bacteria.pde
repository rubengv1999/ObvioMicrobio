abstract class Bacteria {
  float x, y, w, h, energy, initW, initH, incrementSize, trashPercent;
  Body body;
  Vec2 speed;
  color c;
  PImage img;
  boolean dead;
  ArrayList<Nutrient> nutrients;
  float initialSpeedX;
  float initialSpeedY;

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
    this.initialSpeedX = 1.5;
    this.initialSpeedY = 1.5;
    this.speed = new Vec2(random(-initialSpeedX, initialSpeedX), random(-initialSpeedY, initialSpeedY));
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
    //applyForce(speed);
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

  public void applyAll(){
    applyAcidity();
    applyHumidity();
    applyOxygen();
    applyNutrients();
  }

  void isDead(){
    if (energy <= 0)
      dead = true;
  }

  void changeColor(){
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
   
  
  void setMovement(){
    //Vec2 speed = new Vec2(random(-x, x), random(-y, y));
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pos.add(speed);
    //speed.limit();
    //speed.x = 1;
    //Vec2 force = new Vec2();    
    //force.x = map(humidity, 0, 0.9, 0, initialSpeedX);
    //force.y = map(humidity, 0, 0.9, 0, initialSpeedY);
    println("Speed x = " + speed.x);
    println("Speed y = " + speed.y);
    //speed.x = map(humidity, 0, 1, 0, initialSpeedX);
    //speed.y = map(humidity, 0, 1, 0, initialSpeedY);
    //speed.x = speed.x - (2 - humidity);
    //speed.y = speed.y - (2 - humidity);
    //speed = speed.add(force);
    println("After x = " + speed.x);
    println("After y = " + speed.y);
    
    body.setLinearVelocity(speed);
    //box2d.coordPixelsToWorld(pos);
    x = pos.x;
    y = pos.y;
  }
  
  public abstract void setMov();
  
    
  
  void setRotation(){
    body.setAngularVelocity(random(-PI, PI)/50);
  }
  
  void slow(){
    body.setLinearVelocity(speed);
    body.setAngularVelocity(random(-PI, PI)/50);
  }
  
  void applyForce(Vec2 force){//forces in meter
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
  public void applyHumidity(){
    //Movement
    //setMov();
  };
  public abstract void applyOxygen();
  abstract boolean isReady();
}
