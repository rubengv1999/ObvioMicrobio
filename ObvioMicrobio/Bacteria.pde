abstract class Bacteria {
  float x, y, w, h, energy, initW, initH, incrementSize, trashPercent;
  Body body;
  Vec2 speed;
  color c;
  PImage img;
  boolean dead;
  ArrayList<Nutrient> nutrients;
  float speedRange;
  Vec2 initialSpeed;
  float iniVelX;
  float iniVelY;

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
    this.speedRange = 2.5;    
    iniVelX = random(-speedRange, speedRange);
    iniVelY = random(-speedRange, speedRange);
    initialSpeed = new Vec2(iniVelX, iniVelY);
    this.speed = new Vec2(iniVelX, iniVelY);
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


  //public abstract void slowDown();

  void slowDown() {    
    println("------------------------------");
    println("Body Before: " + body.getLinearVelocity().x + " " + body.getLinearVelocity().y);
    println("Vel: " + body.getLinearVelocity().length());
    //float brkPower = 0.7;
    float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
    float brkPower = map(humidity, 0, 0.9, maxSpeed, 0)/150;
    println("Initial Speed Mag: " + maxSpeed);
    println("IS X: " + initialSpeed.x);
    println("IS Y: " + initialSpeed.y);
    println("Humidity: " + humidity);
    println("Break Power: " + brkPower);
    float curSpeed = body.getLinearVelocity().length();
    println("Current Speed: " + curSpeed);
    float newSpeed = curSpeed - brkPower;
    println("New Speed: " + newSpeed);
    if (newSpeed < 0) {
      newSpeed = 0;
      body.setAngularVelocity(0);
    }
    Vec2 bodyVel = body.getLinearVelocity();
    bodyVel.normalize();
    println("BodyVel Normalized: " + bodyVel.x + " " + bodyVel.y);
    bodyVel = bodyVel.mul(newSpeed);
    println("BodyVel * Speed: " + bodyVel.x + " " + bodyVel.y);
    body.setLinearVelocity(bodyVel);
    println("Body After: " + body.getLinearVelocity().x + " " + body.getLinearVelocity().y);
    println("Vel: " + body.getLinearVelocity().length());
    println("------------------------------");
  }

  void startMoving() {    
    float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
    //println("MaxSpeed: " + maxSpeed + "------------");
    float movPower = 0.005;
    float curSpeed = body.getLinearVelocity().length();
    float newSpeed = curSpeed + movPower;
    if (newSpeed > maxSpeed) {
      newSpeed = maxSpeed;      
    }
    Vec2 bodyVel = body.getLinearVelocity();    
    if (bodyVel.length() == 0) {
      body.setLinearVelocity(new Vec2(random(-0.01, 0.01), random(-0.01, 0.01)));
    }
    bodyVel.normalize();
    bodyVel = bodyVel.mul(newSpeed);
    body.setLinearVelocity(bodyVel);
  }

  void setRotation(){
    body.setAngularVelocity(random(-PI, PI)/50);
  }  

  void applyForce(Vec2 force) {//forces in meters
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


  public boolean generateTrash() {
    if (trashPercent >= 40) {
      trashPercent = 0;
      return true;
    } else
      return false;
  }

  public abstract void applyAcidity(); 
  public abstract void applyHumidity();
  public abstract void applyOxygen();
  abstract boolean isReady();
}
