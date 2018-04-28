class Flock {
  ArrayList<Bird> birds; // ArrayList for all birds
  FloatList currentBirdPosition;
  
  Flock() {
    birds = new ArrayList<Bird>(); // Initalize the ArrayList
    currentBirdPosition = new FloatList();
  }
  
  FloatList updatePosition() {
    currentBirdPosition.clear();
    for (Bird b : birds) {
      float currentX = b.getX();
      float currentY = b.getY();
      currentBirdPosition.append(currentX);
      currentBirdPosition.append(currentY);
    }
    return currentBirdPosition;
  }
  
  void printPosition() {
    for (int i = 0; i < currentBirdPosition.size(); i+=2) {
      print("Bird Position: ", currentBirdPosition.get(i), ", ", currentBirdPosition.get(i+1), "\n");
    }
  }
  
  int getSize() {
    return(birds.size());
  }
  
  // updates LIMIT for max speed; must increase this (default is 3) if using updateBirdVelocity or else it will be capped at 3
  void updateMaxSpeed(int newMaxSpeed) {
    for (int i = 0; i < birds.size(); i++) {
      birds.get(i).maxSpeed = newMaxSpeed;
    }
  }
  
  // multiplies bird vector by an int, thus increasing max speed while maintaining headings; MUST UPDATE MAX SPEED or else max velocity limit is capped at 3 by default
  void updateBirdVelocity(int newVelocity) {
    for (int i = 0; i < birds.size(); i++) {
      birds.get(i).velocity = birds.get(i).velocity.mult(newVelocity);
    }
  }
  
  void cullFlock() {
    for (int i = 0; i < birds.size(); i++) {
      if (birds.get(i).isOnScreen() == false) {
        birds.remove(i);
      }
    }
    //print(birds);
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
