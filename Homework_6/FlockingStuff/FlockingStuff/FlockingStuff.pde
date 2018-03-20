// Code inspired by: https://processing.org/examples/flocking.html
// TO DO: Implement awareness of "predatory birds" 
// (i.e., avoid other birds of a different color)
// and ??? 

Flock flock1;
color c;

void setup() {
  size(500, 500);
  flock1 = new Flock();
  color c = color(#66CCCC);
  // initial birds
  for (int i = 0; i < 75; i++) {
    flock1.addBird(new Bird(width/2, height/4, c, 40));
  }
}

void draw() {
  background(255);
  flock1.runSimulation();
}
