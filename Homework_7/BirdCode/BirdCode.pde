Flock flock1;
//Flock flock2;
Boolean paused;
FloatList birdPos;
color c, d;
int birdNestX, birdNestY, numBirds;

void setup() {
  size(500, 500);
  background(0);
  flock1 = new Flock();
  paused = false;
  birdNestX = width/2;
  birdNestY = height/4;
  
  numBirds = 10;
  
  d = color(#CC6666);
  c = color(#66CCCC);
}

void draw() {
  background(255);
  if (paused == false) {
    flock1.runSimulation();
    
    // updates the FloatList showing current X,Y coordinates
    birdPos = flock1.updatePosition();
    
    // prints current position from FloatList
    flock1.printPosition();
    
    // removes birds that have flown beyond the screen
    flock1.cullFlock();
    
    // adds birds if the total number falls below numBirds
    if (flock1.getSize() <= numBirds) {
      flock1.addBird(new Bird(birdNestX, birdNestY, c, 40/*, flock2*/));
    }
  }
  //flock2.runSimulation();
  //saveFrame();
}


// PAUSES GAME IF YOU PRESS "J"; just for debugging purposes
void keyPressed() {
  if (key == 'j') {
    paused ^= true;
  }
}
