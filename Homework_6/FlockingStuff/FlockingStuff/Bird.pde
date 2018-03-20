class Bird {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float r;
  float maxForce;
  float maxSpeed;
  color c;
  
  Bird(float _x, float _y, color _c, float _m) {
    position = new PVector(_x, _y);
    c = _c;
    mass = random(_m-10, _m+10);
    
    acceleration = new PVector(0, 0);
    
    velocity = PVector.random2D();
    r = 5.0;
    maxSpeed = 2;
    maxForce = 0.03;
  }
  
  void runSimulation(ArrayList<Bird> birds) {
    flock(birds);
    update();
    borders();
    render();
  }
  
  void render() {
    float theta = velocity.heading() + radians(90);
    
    fill(c);
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height/2+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height/2+r) position.y = -r;
  }
  
  void applyForce(PVector force) {
    //acceleration.add(force.div(mass));
    acceleration.add(force);
  }
  
  void flock(ArrayList<Bird> birds) {
    PVector sep = separate(birds);
    PVector ali = align(birds);
    PVector coh = cohesion(birds);
    
    // Arbitrarily weighted forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // ADDS FORCE TO ACCELERATION
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }
  
  // Method checks for nearby boids and steers away
  PVector separate(ArrayList<Bird> birds) {
    float desiredSep = 50.0f;
    PVector steer = new PVector (0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Bird other : birds) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredSep)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
        count++;
      }
    }
    // Average == divide by how many
    if (count > 0) {
      steer.div((float)count);
    }
    
    // As long as the vector is greter than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: steering = desired - velocity
      steer.setMag(maxSpeed);
      steer.sub(velocity);
      steer.limit(maxForce);
    }
    return steer;
  }
  
  PVector align(ArrayList<Bird> birds) {
    float neighborDist = 100;
    PVector sum = new PVector(0, 0);
    
    int count = 0;
    for (Bird other : birds) {
      float d  = PVector.dist(position, other.position);
      if((d > 0) && (d < neighborDist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(maxSpeed);
      
      // Implement Reynolds: Steering = Desired - Velocity
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxForce);
      return steer;
    }
    else {
      return new PVector(0, 0);
    }
  }
  
  //For the average position (i.e. center) of all nearby birds, calculate steering vector towards that position
  PVector cohesion(ArrayList<Bird> birds) {
    float neighborDist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Bird other: birds) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighborDist)) {
        sum.add(other.position);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    }
    else {
      return new PVector(0, 0);
    }
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position); // Vector pointing from the position to the target
    desired.setMag(maxSpeed);
    
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
  
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxSpeed);
    position.add(velocity);
    // Reset acceleration to 0 each iteration
    acceleration.mult(0);
  }
}
