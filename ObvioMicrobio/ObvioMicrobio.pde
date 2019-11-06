//Librerías Box2d
import shiffman.box2d.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
//Librerías Java
import java.util.Iterator;
import java.lang.Object;
//Librería ControlP5
import controlP5.*;
//Libreria Minim
import ddf.minim.*;

enum State {
  Title, Animation, Simulation
};

//Variables Globales
Petri petri;
Box2DProcessing box2d;
ArrayList<Bacteria> bacterias;
ArrayList<Nutrient> nutrients;
ArrayList<Trash> waste;
ControlP5 cp5;
ControlP5 button;
float acidity, humidity, nutrientsProb;
boolean oxygen;
int deathBacterias;
int bacteriaType = 0;
float imageWidth, imageProf, imageHeight, inicioCont;
boolean inicio = true;
PImage logo;
State state;
Minim minim;
AudioSample pop;
AudioSample death;


//Setup
void setup() {
  fullScreen(P3D);
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(0, 0));
  box2d.listenForCollisions();
  petri = new Petri();
  reiniciar();
  initButton();
  imageWidth = width * 2.2;
  imageProf = 10;
  imageHeight = -500;
  inicioCont = 100;
  state = State.Title;
  logo = loadImage("images/LogoOM.png");
  camera(imageWidth, imageHeight, (height/2.0) / tan(PI*30.0 / 180.0) * imageProf, imageWidth, imageHeight, 0, 0, 1, 0);
  minim = new Minim(this);
  pop = minim.loadSample("sounds/pop.mp3", 512);
  death = minim.loadSample("sounds/auch.mp3", 512);
}

//Draw
void draw() {
  background(255);
  fill(0);
  initText();
  switch(state) {
  case Title:
    image(logo, width*-2.75, height * -5.7, width*10, height*10);
    break;
  case Animation:
    if (inicioCont > 0) {
      inicioCont--;
      image(logo, width*-2.75, height * -5.7, width*10, height*10);
      imageWidth = map(inicioCont, 0, 100, width/2.0, width * 2.2);
      imageHeight = map(inicioCont, 0, 100, height/2.0, -500);
      imageProf = map(inicioCont, 0, 100, 1, 10);
      camera(imageWidth, imageHeight, (height/2.0) / tan(PI*30.0 / 180.0) * imageProf, imageWidth, imageHeight, 0, 0, 1, 0);
    } else {
      logo = loadImage("images/logo.png");
      state = State.Simulation;
    }
    break;
  }
  petri.display(humidity);  
  box2d.step();    
  ArrayList<Bacteria> nuevasBac = new ArrayList();
  //Proceso Bacterias
  for (Bacteria bacteria : bacterias) {
    bacteria.display();
    if (!bacteria.dead) {
      bacteria.applyAll();
      bacteria.isDead();
      if (!bacteria.dead) {
        if (bacteria.isReady()) {
          bacteria.restart();
          Bacteria newBac = crearBacteria(bacteria.x, bacteria.y);
          bacteria.energy = map(bacteria.energy, 0, 100, bacteria.energy, 100);
          newBac.energy = bacteria.energy;
          nuevasBac.add(newBac);
          newSound();
        }
        if (bacteria.generateTrash()) 
          waste.add(new Trash(bacteria.x, bacteria.y));
      } else {
        deathSound();
      }
    }
  }

  for (Bacteria bac : nuevasBac) 
    bacterias.add(bac);

  if (random(1) < nutrientsProb && frameCount % 10 == 0) 
    nutrients.add( new Nutrient());

  //Proceso Nutrientes
  Iterator<Nutrient> itN = nutrients.iterator();
  while (itN.hasNext()) {
    Nutrient nutrient = itN.next();
    nutrient.display();
    nutrient.aliment();
    if (nutrient.isDead()) 
      itN.remove();
  }

  for (Trash trash : waste) 
    trash.display();
}

void keyPressed() {
  if (key == ' ' && state == State.Title) state = State.Animation;
}

void initButton() {
  pushMatrix();
  button = new ControlP5(this);
  cp5.addButton("reiniciar")
    .setValue(0)
    .setPosition(10, height - 35)
    .setSize(100, 25);
  popMatrix();
}

void initControls() {
  cargarValores();
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
  cp5.addDropdownList("Bacteria")
    .setPosition(10, 190)
    .setBackgroundColor(color(0, 45, 90))
    .setItemHeight(25)
    .setBarHeight(20)
    .setWidth(200)
    .setHeight(150)
    .setColorBackground(color(0, 45, 90))
    .setColorActive(color(255, 128))
    .addItem("Escherichia coli", 1)
    .addItem("Lactobacilos", 2)
    .addItem("Clostridium perfringens", 3)
    .addItem("Estafilococo dorado", 4)
    .addItem("Mycobacterium tuberculosis", 5);
  popMatrix();
}


void initText() {
  textSize(35);
  text("Parameters", 15, 40); 
  textSize(12);
  text("Alive Bacterias: " + (bacterias.size() - deathBacterias), 10, height - 125); 
  text("Death bacterias: " + deathBacterias, 10, height - 100); 
  text("Nutrients: " + nutrients.size(), 10, height - 75); 
  text("Waste: " + waste.size(), 10, height - 50); 
  text("Ruben Gonzalez Villanueva", width  - 180, height- 100); 
  text("Jose Daniel Gomez Casasola", width  - 180, height- 80); 
  text("Jose Fabio Hidalgo", width  - 180, height- 60); 
  text("Gerardo Villalobos Villalobos", width  - 180, height- 40); 
  text("Gabriel Vindas Brenes", width  - 180, height- 20);
  image(logo, width - 200, 20, 174.29, 136);
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
  if (o1 instanceof Bacteria && o2 instanceof Nutrient) {
    bacteria = (Bacteria) o1;
    nutrient = (Nutrient) o2;
  }
  if (o2 instanceof Bacteria && o1 instanceof Nutrient) {
    bacteria = (Bacteria) o2;
    nutrient = (Nutrient) o1;
  }
  if (nutrient != null) {
    if (contact) {
      if (humidity>=0.9)nutrient.addBacteria(bacteria);
    } else {
      nutrient.removeBacteria(bacteria);
    }
  }
}

public void reiniciar() {
  initControls();
  deathBacterias = 0;
  bacterias = new ArrayList();
  nutrients = new ArrayList();
  waste = new ArrayList();
  float randomX, randomY;
  double distance;
  for (int i = 0; i < 15; i++) {
    do {
      randomX = random(width);
      randomY = random(height);
      distance = Math.hypot(Math.abs(height/2 - randomY), Math.abs(width/2 - randomX));
    } while (distance >  height / 2 - 40);
    bacterias.add(crearBacteria(randomX, randomY));
  }
}

public void cargarValores() {
  humidity = 0.9;
  acidity = bacteriaType == 1? 6.6 :7;
  nutrientsProb = 0.5;
  oxygen = true;
}

Bacteria crearBacteria(float x, float y) {
  Bacteria bact = new Ecoli(0, 0); 
  switch (bacteriaType) {
  case 0:
    bact = new Ecoli(x, y);
    break;
  case 1:
    bact = new Lactobacilo(x, y);
    break;
  case 2:
    bact = new Clostridium(x, y);
    break;
  case 3:
    bact = new Estafilococo(x, y);
    break;
  case 4:
    bact = new Tuberculosis(x, y);
    break;
  }
  return bact;
}

void controlEvent(ControlEvent theEvent) {

  if (theEvent.isController()) 
    if (theEvent.getController().toString().equals("Bacteria [DropdownList]")) {
      bacteriaType = (int)theEvent.getController().getValue();
      reiniciar();
    }
}

void newSound() {
  pop.trigger();
}

void deathSound() {
  death.trigger();
}
