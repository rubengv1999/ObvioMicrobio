abstract class Bacteria {
  float x, y, w, h, energy, initW, initH, incrementSize, trashPercent;
  Body body;
  Vec2 speed;
  PImage img;
  boolean dead;
  int nutrients;
  float speedRange;
  Vec2 initialSpeed;
  float iniVelX;
  float iniVelY;
  float acidityPerfect;

  Bacteria(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.initW = w;
    this.initH = h;
    this.dead = false;
    this.energy = 100;
    this.trashPercent = 0;
    this.speedRange = 0.75;  
    this.acidityPerfect = 7;
    this.incrementSize = 1.0005;
    iniVelX = random(-speedRange, speedRange);
    iniVelY = random(-speedRange, speedRange);
    initialSpeed = new Vec2(iniVelX, iniVelY);
    this.speed = new Vec2(iniVelX, iniVelY);
    nutrients = 0;
    createBody();
  }

  public void applyAll() {
    applyAcidity();
    applyHumidity();
    applyOxygen();
    applyNutrients();
  }

  void isDead() {
    if (energy <= 0) {
      dead = true;
      this.img.filter(GRAY);
      deathBacterias++;
    }
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

  void slowDown() {    
    float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
    float brkPower = map(humidity, 0, 0.9, maxSpeed, 0)/150;
    float curSpeed = body.getLinearVelocity().length();
    float newSpeed = curSpeed - brkPower;
    if (newSpeed < 0) {
      newSpeed = 0;
      body.setAngularVelocity(0);
    }
    Vec2 bodyVel = body.getLinearVelocity();
    bodyVel.normalize();
    bodyVel = bodyVel.mul(newSpeed);
    body.setLinearVelocity(bodyVel);
  }

  void stopDownOx() {    
    float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
    float brkPower = map(-1, 0, 0.01, maxSpeed, 0)/150;
    float curSpeed = body.getLinearVelocity().length();
    float newSpeed = curSpeed - brkPower;
    if (newSpeed < 0) {
      newSpeed = 0;
      body.setAngularVelocity(0);
    }
    Vec2 bodyVel = body.getLinearVelocity();
    bodyVel.normalize();
    bodyVel = bodyVel.mul(newSpeed);
    body.setLinearVelocity(bodyVel);
  }

  void startMoving() {    
    float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
    float movPower = 0.005;
    float curSpeed = body.getLinearVelocity().length();
    float newSpeed = curSpeed + movPower;
    if (newSpeed > maxSpeed) 
      newSpeed = maxSpeed;
    Vec2 bodyVel = body.getLinearVelocity();    
    if (bodyVel.length() == 0) 
      body.setLinearVelocity(new Vec2(random(-0.01, 0.01), random(-0.01, 0.01)));
    bodyVel.normalize();
    bodyVel = bodyVel.mul(newSpeed);
    body.setLinearVelocity(bodyVel);
  }

  void setRotation() {
    body.setAngularVelocity(random(-PI, PI)/50);
  }  

  void applyForce(Vec2 force) {//forces in meters
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }

  public void applyNutrients() {
    if (nutrients > 0) {
      Vec2 pos = box2d.getBodyPixelCoord(body);
      x = pos.x;
      y = pos.y;
      box2d.destroyBody(body);
      createBody();
      energy -= 0.001;
    } else {
      energy -= 0.005;
    }
  }

  public void eat() {
    w = w * incrementSize;
    h = h * incrementSize;
    trashPercent += 0.05;
  }


  public boolean generateTrash() {
    if (trashPercent >= 40) {
      trashPercent = 0;
      return true;
    }
    return false;
  }

  public void applyAcidity() {
    if (acidity > acidityPerfect + 2 || acidity < acidityPerfect - 2) {
      energy -= 1;
    } else if (acidity > acidityPerfect + 3 || acidity < acidityPerfect - 4) {
      energy -= 5;
    }
  }

  public void applyHumidity() {
    if (humidity < 0.9) {
      slowDown();
    } else {
      startMoving();
    }
  }

  boolean isReady() {
    return ((100 * w) / initW) >= 150;
  }
  abstract void display();
  abstract void createBody();
  public abstract void applyOxygen();
}
