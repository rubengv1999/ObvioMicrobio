//Librerías Box2d
import shiffman.box2d.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
//Librerías Java
import java.util.Iterator;
//Librería ControlP5
import controlP5.*;

//Variables Globales
Petri petri;
Box2DProcessing box2d;
ArrayList<Bacteria> bacterias;
ArrayList<Nutrient> nutrients;
ArrayList<Trash> waste;
ControlP5 cp5;
float acidity, humidity, nutrientsProb;
boolean oxygen;

//Setup
void setup() {
  //fullScreen(P2D);
  size(900,600);
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(0, 0));
  box2d.listenForCollisions();
  petri = new Petri();
  bacterias = new ArrayList();
  nutrients = new ArrayList();
  waste = new ArrayList();
  oxygen = true;
  acidity = 7;
  humidity = 0.9;
  nutrientsProb = 0.1;
  initControls();

  float randomX, randomY;
  double distance;
  for (int i = 0; i < 5; i++) {
    do {
      randomX = random(width);
      randomY = random(height);
      distance = Math.hypot(Math.abs(height/2 - randomY), Math.abs(width/2 - randomX));
    } while (distance >  height / 2 - 20);

    bacterias.add(new Ecoli(randomX, randomY, 15, 30));
  }
}

//Draw
void draw() {
  background(255);
  fill(0);
  initText();
  petri.display(humidity);
  //petri.displayHumidity(humidity);
  box2d.step();    

  ArrayList<Bacteria> nuevasBac = new ArrayList();

  //Proceso Bacterias
  //Iterator<Bacteria> it = bacterias.iterator();
  //while (it.hasNext()){
  for (Bacteria bacteria : bacterias){
    bacteria.display();
    if (! bacteria.dead) {
      bacteria.applyAll();//---------
      bacteria.isDead();
      if (! bacteria.dead){
        if (bacteria.isReady()){
          bacteria.restart();
          Bacteria newBac = new Ecoli(bacteria.x, bacteria.y, 15, 30);
          newBac.energy = bacteria.energy;
          nuevasBac.add(newBac);
        }
        if (bacteria.generateTrash()) {
          Trash basura = new Trash(bacteria.x, bacteria.y);
          waste.add(basura);
        }
      }
    }
  }

  for (Bacteria bac : nuevasBac) {
    bacterias.add(bac);
  }

  if (mousePressed){
    for(Bacteria b : bacterias){
      b.setMov();
    }
  }
  
  //Agregar bacterias
  //if (mousePressed) bacterias.add(new Ecoli(mouseX, mouseY, 15, 30));
  //if (mousePressed) bacterias.add(new Lactobacilo(mouseX, mouseY, 20, 20));
  //if (mousePressed) bacterias.add(new Clostridium(mouseX, mouseY, 20, 20));
  //if (mousePressed) bacterias.add(new Estafilococo(mouseX, mouseY, 30, 26));
  //if (mousePressed) bacterias.add(new Tuberculosis(mouseX, mouseY, 20, 20));

  if (random(1) < nutrientsProb && frameCount % 10 == 0) {
    Nutrient nutrient = new Nutrient();
    nutrients.add(nutrient);
  }

  //Proceso Bacterias
  Iterator<Nutrient> itN = nutrients.iterator();
  while (itN.hasNext()){
    Nutrient nutrient = itN.next();
    nutrient.display();
    if (nutrient.isDead()) { 
      for (Bacteria bacteria : bacterias)
        if (bacteria.nutrients.contains(nutrient))
          bacteria.removeNutrient(nutrient);
      itN.remove();
    }
  }

  for (Trash trash : waste) {
    trash.display();
  }
}

void initControls() {
  pushMatrix();
  cp5 = new ControlP5(this);
  cp5.addSlider("acidity")
    .setPosition(10, 60)
    .setSize(200, 20)
    .setRange(0, 14)
    .setColorLabel(0x00000000);
  cp5.addSlider("humidity")
    .setPosition(10, 90)
    .setSize(200, 20)
    .setRange(0, 1)
    .setColorLabel(0x00000000);
  cp5.addSlider("nutrientsProb")
    .setPosition(10, 120)
    .setSize(200, 20)
    .setRange(0, 1)
    .setColorLabel(0x00000000);
  cp5.addToggle("oxygen")
    .setPosition(10, 150)
    .setSize(200, 20)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setColorLabel(0x00000000);




  /*  cp5.addDropdownList("Bacteria")
   .setPosition(10, 60)
   .setBackgroundColor(color(0, 45, 90))
   .setItemHeight(20)
   .setBarHeight(20)
   .setWidth(200)
   .setHeight(120)
   .setColorBackground(color(0, 45, 90))
   .setColorActive(color(255, 128))
   .addItem("Escherichia coli", 1)
   .addItem("Lactobacilos", 2)
   .addItem("Clostridium perfringens", 3)
   .addItem("Estafilococo dorado", 4)
   .addItem("Mycobacterium tuberculosis", 5);
   */
  popMatrix();
}
void initText() {
  textSize(35);
  text("Parámetros", 15, 40); 
  text("Obvio Microbio", width - 265, 40); 
  textSize(10);
  text("Rubén González Villanueva", width  - 150, height- 100); 
  text("José Daniel Gómez Casasola", width  - 150, height- 80); 
  text("José Fabio Hidalgo", width  - 150, height- 60); 
  text("Gerardo Villalobos Villalobos", width  - 150, height- 40); 
  text("Gabriel Vindas Brenes", width  - 150, height- 20);
}

void beginContact(Contact c) {
  applyContact(c, true);
}

void endContact(Contact c) {

  applyContact(c, false);
}

public void applyContact(Contact c, boolean contact) {
  Object o1 = c.getFixtureA().getBody().getUserData();
  Object o2 = c.getFixtureB().getBody().getUserData();
  Bacteria bacteria = null;
  Nutrient nutrient = null;
  boolean colision = false;
  if (o1 instanceof Bacteria && o2 instanceof Nutrient) {
    bacteria = (Bacteria) o1;
    nutrient = (Nutrient) o2;
    colision = true;
  }
  if (o2 instanceof Bacteria && o1 instanceof Nutrient) {
    bacteria = (Bacteria) o2;
    nutrient = (Nutrient) o1;
    colision = true;
  }
  if (colision) {
    if (contact) 
      bacteria.addNutrient(nutrient);
    else
      bacteria.removeNutrient(nutrient);
  }
}
