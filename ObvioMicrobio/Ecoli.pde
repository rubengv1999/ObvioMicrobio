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

  void display(){
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
  
  void setMov(){    
    /*Vec2 humidityForce = new Vec2();    
    Vec2 vel = body.getLinearVelocity();
    humidityForce.x = (vel.y)*-1; //map(humidity, 0, 0.9, initialSpeedX, 0)*-1;    
    humidityForce.y = (vel.y)*-1; //map(humidity, 0, 0.9, initialSpeedY, 0)*-1;
    println("Current Velocity x = " + vel.x + "y = " + vel.y);    
    applyForce(humidityForce);*/
    Vec2 cant = new Vec2();    
    if(speed.x < 0) speed.x += 0.1;
    else if(speed.x > 0) speed.x -= 0.1;
    else if(speed.y < 0) speed.y += 0.1;
    else if(speed.y > 0) speed.y -= 0.1;    
    body.setLinearVelocity(cant);
  }

  void isDead(){//Especializar 
    super.isDead();
    if(dead)
    this.img.filter(GRAY);
  }


  public void applyAcidity(){
    if (acidity > 9 || acidity < 5) {
      energy -= 1;
    }
    else if(acidity > 10 || acidity < 3){
      energy -= 5;
    }
  }
  public void applyHumidity() {
    //Movement
    //setMovement();
    
  }
  public void applyOxygen() {
  }
  
  boolean isReady() {
    return ((100 * w) / initW) >= 150;
  }
}
