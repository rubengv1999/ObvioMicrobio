class Ecoli extends Bacteria {
  Ecoli(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.img = loadImage("images/ecoli.png");
    this.incrementSize = 1.0005;
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

  void display() {
    noFill();
    noStroke();
    rectMode(CENTER);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float ang = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-ang);
    rect(0, 0, w, h);
    image(img, -(w/2), -(h/2), w, h);
    popMatrix();
  }


 
  //void slowDown() {    
  //  println("------------------------------");
  //  println("Body Before: " + body.getLinearVelocity().x + " " + body.getLinearVelocity().y);
  //  println("Vel: " + body.getLinearVelocity().length());
  //  //float brkPower = 0.7;
  //  float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
  //  float brkPower = map(humidity, 0, 0.9, maxSpeed, 0);
  //  println("Initial Speed Mag: " + maxSpeed);
  //  println("IS X: " + initialSpeed.x);
  //  println("IS Y: " + initialSpeed.y);
  //  println("Humidity: " + humidity);
  //  println("Break Power: " + brkPower);
  //  float curSpeed = body.getLinearVelocity().length();
  //  println("Current Speed: " + curSpeed);
  //  float newSpeed = curSpeed - brkPower;
  //  println("New Speed: " + newSpeed);
  //  if(newSpeed < 0){
  //    newSpeed = 0;
  //  }
  //  Vec2 bodyVel = body.getLinearVelocity();
  //  bodyVel.normalize();
  //  println("BodyVel Normalized: " + bodyVel.x + " " + bodyVel.y);
  //  bodyVel = bodyVel.mul(newSpeed);
  //  println("BodyVel * Speed: " + bodyVel.x + " " + bodyVel.y);
  //  body.setLinearVelocity(bodyVel);
  //  println("Body After: " + body.getLinearVelocity().x + " " + body.getLinearVelocity().y);
  //  println("Vel: " + body.getLinearVelocity().length());
  //  println("------------------------------");    
  //}
  
  //void startMoving(){    
  //  float maxSpeed = sqrt(initialSpeed.x*initialSpeed.x + initialSpeed.y*initialSpeed.y);
  //  //println("MaxSpeed: " + maxSpeed + "------------");
  //  float movPower = 0.005;
  //  float curSpeed = body.getLinearVelocity().length();
  //  float newSpeed = curSpeed + movPower;
  //  if(newSpeed > maxSpeed){
  //    newSpeed = maxSpeed;
  //  }
  //  Vec2 bodyVel = body.getLinearVelocity();    
  //  if(bodyVel.length() == 0){
  //    body.setLinearVelocity(new Vec2(random(-0.01, 0.01),random(-0.01,0.01)));
  //  }
  //  bodyVel.normalize();
  //  bodyVel = bodyVel.mul(newSpeed);
  //  body.setLinearVelocity(bodyVel);                  
  //}

  void isDead() {//Especializar
    super.isDead();
    if (dead)
      this.img.filter(GRAY);

  }


  public void applyAcidity() {
    if (acidity > 9 || acidity < 5) {
      energy -= 1;
    } else if (acidity > 10 || acidity < 3) {
      energy -= 5;
    }
  }
  public void applyHumidity() {
    if(humidity < 0.9){
      slowDown();
    }
    else{
      startMoving();
      //setRotation();
    }
  }
  public void applyOxygen() {
  }
  boolean isReady() {
    return ((100 * w) / initW) >= 150;
  }
}
