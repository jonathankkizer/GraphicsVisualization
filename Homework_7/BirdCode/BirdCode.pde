Flock flock1;
//Flock flock2;
Boolean paused;
FloatList birdPos;

void setup() {
  size(500, 500);
  background(0);
  birdSetup();
  paused = false;
}

void draw() {
  background(255);
  if (paused == false) {
    flock1.runSimulation();
    birdPos = flock1.updatePosition();
    //flock1.printPosition();
    flock1.cullFlock();
  }
  //flock2.runSimulation();
  //saveFrame();
}

void keyPressed() {
  if (key == 'j') {
    paused ^= true;
  }
}

void birdSetup() {
  flock1 = new Flock();
  //flock2 = new Flock();
  color d = color(#CC6666);
  color c = color(#66CCCC);
  // initial birds
  for (int i = 0; i < 5; i++) {
    float positionX, positionY;
    positionX = random(0, width);
    positionY = random(0, height);
    flock1.addBird(new Bird(mouseX, mouseY, c, 40/*, flock2*/));
  }
  /*for (int i = 0; i < 50; i++) {
    float positionX, positionY;
    positionX = random(0, width);
    positionY = random(0, height);
    flock2.addBird(new Bird(mouseX, mouseY, d, 40, flock1));
  }*/
}
