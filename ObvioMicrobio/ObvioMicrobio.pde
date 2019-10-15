//Librerías Box2d
import shiffman.box2d.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
//Librerías Java
import java.util.Iterator;
//Librería ControlP5
import controlP5.*;

//Variables Globales
Petri petri;
Box2DProcessing box2d;
ArrayList<Bacteria> bacterias;
ControlP5 cp5;


//Setup
void setup() {
  fullScreen(P2D);
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(0, 0));
  petri = new Petri();
  bacterias = new ArrayList();
  initControls();
}

//Draw
void draw() {
  background(255);
  fill(0);
  initText();
  petri.display();
  box2d.step();  

  //Proceso Bacterias
  Iterator<Bacteria> it = bacterias.iterator();
  while (it.hasNext()) {
    Bacteria bacteria = it.next();
    bacteria.display();
    if (bacteria.isDead()) it.remove();
  }

  //Agregar bacterias
  if (mousePressed) bacterias.add(new Ecoli(mouseX, mouseY, 20, 40));
  //if (mousePressed) bacterias.add(new Lactobacilo(mouseX, mouseY, 40, 40));
  //if (mousePressed) bacterias.add(new Clostridium(mouseX, mouseY, 40, 40));
  //if (mousePressed) bacterias.add(new Estafilococo(mouseX, mouseY, 40, 36));
  //if (mousePressed) bacterias.add(new Tuberculosis(mouseX, mouseY, 40, 40));
  
}

void initControls() {
  pushMatrix();
  cp5 = new ControlP5(this);
  cp5.addSlider("acidez")
    .setPosition(10, 60)
    .setSize(200, 20)
    .setRange(0.01, 1)
    .setColorLabel(0x00000000);
  cp5.addSlider("humedad")
    .setPosition(10, 90)
    .setSize(200, 20)
    .setRange(0.01, 100)
    .setColorLabel(0x00000000);
  cp5.addSlider("oxigeno")
    .setPosition(10, 120)
    .setSize(200, 20)
    .setRange(0.01, 1)
    .setColorLabel(0x00000000);
  cp5.addSlider("nutrientes")
    .setPosition(10, 150)
    .setSize(200, 20)
    .setRange(0.01, 1)
    .setColorLabel(0x00000000);
  cp5.addDropdownList("Bacteria")
    .setPosition(10, 180)
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
