class Flock {
  ArrayList<Bird> birds; // ArrayList for all birds
  
  Flock() {
    birds = new ArrayList<Bird>(); // Initalize the ArrayList
  }
  
  void runSimulation() {
    for (Bird b : birds) {
      b.runSimulation(birds);
    }
  }
  
  void addBird(Bird b) {
    birds.add(b);
  }
}
/*
Code here and in Bird inspired by: 
http://www.kfish.org/boids/pseudocode.html
https://www.openprocessing.org/sketch/126516
http://harry.me/blog/2011/02/17/neat-algorithms-flocking/
https://processing.org/examples/flocking.html
*/ 
