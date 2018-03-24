// Code inspired by: https://processing.org/examples/flocking.html


Flock flock1;
Flock flock2;
color c;
color d;

void setup() {
  size(500, 500);
  flock1 = new Flock();
  flock2 = new Flock();
  color d = color(#CC6666);
  color c = color(#66CCCC);
  // initial birds
  for (int i = 0; i < 50; i++) {
    float positionX, positionY;
    positionX = random(0, width);
    positionY = random(0, height);
    flock1.addBird(new Bird(mouseX, mouseY, c, 40, flock2));
  }
  for (int i = 0; i < 50; i++) {
    float positionX, positionY;
    positionX = random(0, width);
    positionY = random(0, height);
    flock2.addBird(new Bird(mouseX, mouseY, d, 40, flock1));
  }
}

void draw() {
  background(255);
  flock1.runSimulation();
  flock2.runSimulation();
}

void mousePressed() {
  setup();
}
