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
