class Ecoli extends Bacteria {
  Ecoli(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.img = loadImage("images/ecoli.png");
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
    body.setUserData(this);
  }

  /* void display() {
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
   */

  public void applyAcidity() {
    if (acidity > 9 || acidity < 5) {
      energy -= 1;
    }
    else if(acidity > 10 || acidity < 3){
      energy -= 5;
    }
  }
  public void applyHumidity() {
  }
  public void applyOxygen() {
  }
  public void applyNutrients() {
    if (nutrients.size() > 0) {
      for (Nutrient nutrient : this.nutrients) {
        w += 0.01;
        h += 0.01;
        changeColor();
        nutrient.capacity -= 0.1;
      }
      Vec2 pos = box2d.getBodyPixelCoord(body);
      x = pos.x;
      y = pos.y;
      box2d.destroyBody(body);
      createBody();
    }
  }
}
