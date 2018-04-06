class Bee extends ParticleWithMass {
 
  float rx; //the x value of the center of restiution/resting for the spring/bee
  float ry;
  float ks; 
  float kd;
  
  //fields to help make the swarm of bees a doubly-linked list
  Bee childBee; //each bee may have a child bee
  Bee parentBee; //each bee may have a parent bee
  
  Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, 
  float _rx, float _ry, float _ks, float _kd) {
    
    super(_x,_y,_vx,_vy,_ax,_ay,_r,_m);
    rx = _rx;
    ry = _ry;
    ks = _ks;
    kd = _kd;
    
  }
  
  void displayBeeAndChildren() {
    //before you display a bee, update its location based on the spring physics
    updateLocation();
    super.display();
    
    //if the bee has children then display its children
    if (this.childBee != null) {
      
      this.childBee.displayChildren(this.x,this.y); //passing in the current bees x and y position as rx and ry
    }
  }
  
  void updateLocation() {
   //code borrows form dr abarams lectures: it models a spring with dampening
   //y
   float fy = -((ks * (y - ry)) + kd*vy); //dampening
   float ay = fy/m;
   vy = vy + ay;
   y += vy;
   
   //x
   //code borrows form dr abarams lectures: it models a spring with dampening
   float fx = -((ks * (x - rx)) + kd*vx); //dampening
   float ax = fx/m;
   vx = vx + ax;
   x += vx;
   
   //setting the center of restitution of each bee/spring to be the mouse position, but these values
   //are overwritten for bees which are children (See the next method)
   rx = mouseX;
   ry = mouseY;
    
  }
  
  void displayChildren(float rx,float ry) {
    
    //childrens location is updated with a different updateLocation method, one which requires two arguments
    updateLocation(rx,ry); //pased on the passed in rx and ry which were assigned as the this.x and this.y, aka the position of the parent
    super.display();
    
    if (this.childBee != null) {
      
      this.childBee.displayChildren(this.x,this.y); //keep displaying all the children until you reach the end of the linked list
    }
  }
  
  void updateLocation(float rx, float ry) {
   //code borrows form dr abarams lectures: it models a spring with dampening
   //y
   float fy = -((ks * (y - ry)) + kd*vy); //dampening
   float ay = fy/m;
   vy = vy + ay;
   y += vy;
   
   //x
   //code borrows form dr abarams lectures: it models a spring with dampening
   float fx = -((ks * (x - rx)) + kd*vx); //dampening
   float ax = fx/m;
   vx = vx + ax;
   x += vx;
   
   //note that for the children bees we do not have their center restitution of mouseX and mouseY, but rather
   //based on the position of the parent bee
    
  }
  
  //attaching a child bee to a parent bee
  
  void attachChildParticle(Bee childParticle) {
    //center of restitution (rx,ry) of the child particle is the position of the parent particle
    childParticle.rx = this.x;
    childParticle.ry = this.y;
    
    //keeping track of the relationships
    this.childBee = childParticle;
    childParticle.parentBee = this;
  }
  
  //deleting all of a bees childeren? only need to delete the child and then the childrens children (if any) will be deleted because
  //the child's first child was an attribute of the parent
  void deleteBeesChildren() {
    this.childBee = null;
  }
  
  //get the last child by going through the linked list
  Bee getLastChild() {
    if(this.childBee == null) {
      return this;
    } else {
      return this.childBee.getLastChild();
    }
    
  }
  
  int getNumberOfChildren() {
    if (this.childBee == null) {
      return 1;
  } else {
    return 1 + this.childBee.getNumberOfChildren();
    }
  }
  
}