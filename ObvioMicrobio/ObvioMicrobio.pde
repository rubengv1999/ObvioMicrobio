//Librerías Box2d
import shiffman.box2d.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
//Librerías Java
import java.util.Iterator;

//Variables Globales
Petri petri;
Box2DProcessing box2d;
ArrayList<Bacteria> bacterias;

//Setup
void setup() {
  fullScreen(P2D);
  box2d = new Box2DProcessing(this);
  box2d.createWorld(new Vec2(0, 0));
  petri = new Petri();
  bacterias = new ArrayList();
}

//Draw
void draw() {
  background(0);
  petri.display();
  box2d.step();  
  
  //Proceso Bacterias
  Iterator<Bacteria> it = bacterias.iterator();
  while (it.hasNext()) {
    Bacteria bacteria = it.next();
    bacteria.display();
    if (bacteria.isDead()) it.remove();
  }
  if (mousePressed) {
    bacterias.add(new Bacteria(mouseX, mouseY, random(10, 20)));
  }
}
