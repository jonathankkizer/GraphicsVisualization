class Bee extends ParticleWithMass {
  
  //note that beesFacingRight is a global in the main code
  
  //PSHAPE STUFF
  //right-facing bee
  PShape rightFacingBeePShape;
  PShape headRightBee; 
  PShape leftAntenaeRightBee;
  PShape rightAntenaeRightBee;
  PShape stingerRightBee;
  
  //left-facing bee
  PShape leftFacingBeePShape;
  PShape headLeftBee; 
  PShape leftAntenaeLeftBee;
  PShape rightAntenaeLeftBee;
  PShape stingerLeftBee;
  
  //PShapes shared by both bees
  PShape body;
  PShape stripe1;
  PShape stripe2;
  PShape stripe3;
  PShape topWing;
  PShape bottomWing;

  
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
    setUpRightFacingBee();
    setUpLeftFacingBee();
    
  }
  
  void displayBeeAndChildren() {
    //before you display a bee, update its location based on the spring physics
    updateLocation();
    
    //super.display();
    if (beesFacingRight) {
      rightFacingBeePShape.getChild(0).setFill(color(255,255,0));
      rightFacingBeePShape.getChild(1).setFill(color(0));
      rightFacingBeePShape.getChild(2).setFill(color(0));
      rightFacingBeePShape.getChild(3).setFill(color(0));
      displayRightFacingBee();
    } else {
      leftFacingBeePShape.getChild(0).setFill(color(255,255,0));
      leftFacingBeePShape.getChild(1).setFill(color(0));
      leftFacingBeePShape.getChild(2).setFill(color(0));
      leftFacingBeePShape.getChild(3).setFill(color(0));
      displayLeftFacingBee();
    }
    
    //if the bee has children then display its children
    if (this.childBee != null) {
      
      this.childBee.displayChildren(this.x,this.y); //passing in the current bees x and y position as rx and ry
    }
  }
  
  void displayBeeAndChildrenAsInvincible() {
    //before you display a bee, update its location based on the spring physics
    updateLocation();

    //ellipse(x,y,r,r);
    if (beesFacingRight) {
      rightFacingBeePShape.getChild(0).setFill(color(random(255),random(255),random(255)));
      rightFacingBeePShape.getChild(1).setFill(color(random(255),random(255),random(255)));
      rightFacingBeePShape.getChild(2).setFill(color(random(255),random(255),random(255)));
      rightFacingBeePShape.getChild(3).setFill(color(random(255),random(255),random(255)));
      displayRightFacingBee();
    } else {
      leftFacingBeePShape.getChild(0).setFill(color(random(255),random(255),random(255)));
      leftFacingBeePShape.getChild(1).setFill(color(random(255),random(255),random(255)));
      leftFacingBeePShape.getChild(2).setFill(color(random(255),random(255),random(255)));
      leftFacingBeePShape.getChild(3).setFill(color(random(255),random(255),random(255)));
      displayLeftFacingBee();
    }
    
    println("in invincicle mode right now");
    
    //if the bee has children then display its children
    if (this.childBee != null) {
      
      this.childBee.displayInvincibleChildren(this.x,this.y); //passing in the current bees x and y position as rx and ry
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
    //super.display();
    if (beesFacingRight) {
      rightFacingBeePShape.getChild(0).setFill(color(255,255,0));
      rightFacingBeePShape.getChild(1).setFill(color(0));
      rightFacingBeePShape.getChild(2).setFill(color(0));
      rightFacingBeePShape.getChild(3).setFill(color(0));
      displayRightFacingBee();
    } else {
      leftFacingBeePShape.getChild(0).setFill(color(255,255,0));
      leftFacingBeePShape.getChild(1).setFill(color(0));
      leftFacingBeePShape.getChild(2).setFill(color(0));
      leftFacingBeePShape.getChild(3).setFill(color(0));
      displayLeftFacingBee();
    }
    
    
    if (this.childBee != null) {
      
      this.childBee.displayChildren(this.x,this.y); //keep displaying all the children until you reach the end of the linked list
    }
  }
  
  void displayInvincibleChildren(float rx,float ry) {
    //childrens location is updated with a different updateLocation method, one which requires two arguments
    updateLocation(rx,ry); //pased on the passed in rx and ry which were assigned as the this.x and this.y, aka the position of the parent
    colorMode(HSB);
    fill(random(255),random(255),200);
    colorMode(RGB);
    //ellipse(x,y,r,r);
    if (beesFacingRight) {
      rightFacingBeePShape.getChild(0).setFill(color(random(255),random(255),random(255)));
      rightFacingBeePShape.getChild(1).setFill(color(random(255),random(255),random(255)));
      rightFacingBeePShape.getChild(2).setFill(color(random(255),random(255),random(255)));
      rightFacingBeePShape.getChild(3).setFill(color(random(255),random(255),random(255)));
      displayRightFacingBee();
    } else {
      leftFacingBeePShape.getChild(0).setFill(color(random(255),random(255),random(255)));
      leftFacingBeePShape.getChild(1).setFill(color(random(255),random(255),random(255)));
      leftFacingBeePShape.getChild(2).setFill(color(random(255),random(255),random(255)));
      leftFacingBeePShape.getChild(3).setFill(color(random(255),random(255),random(255)));
      displayLeftFacingBee();
    }
    
    println("in invincible mode rn");
    
    if (this.childBee != null) {
      
      this.childBee.displayInvincibleChildren(this.x,this.y); //keep displaying all the children until you reach the end of the linked list
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
  
  
    void setUpLeftFacingBee() {
    
    leftFacingBeePShape = createShape(GROUP);
    
    beginShape();
    body = createShape(ELLIPSE,200,300,250,250);
    body.setFill(color(255,255,0));
    leftFacingBeePShape.addChild(body);
    endShape();
    
    beginShape();
    stripe1 = createShape(RECT,175,175,50,250);
    stripe1.setFill(color(0,0,0));
    leftFacingBeePShape.addChild(stripe1);
    endShape();
    
    beginShape();
    stripe2 = createShape(RECT,100,225,50,150);
    stripe2.setFill(color(0,0,0));
    leftFacingBeePShape.addChild(stripe2);
    endShape();
    
    beginShape();
    stripe3 = createShape(RECT,250,225,50,150);
    stripe3.setFill(color(0,0,0));
    leftFacingBeePShape.addChild(stripe3);
    endShape();
    
    beginShape();
    headLeftBee = createShape(ELLIPSE,45,300,100,100);
    headLeftBee.setFill(color(150,80,20));
    leftFacingBeePShape.addChild(headLeftBee);
    endShape();
    
    beginShape();
    leftAntenaeLeftBee = createShape(ELLIPSE,25,230,20,100);
    leftAntenaeLeftBee.setFill(color(192,192,192));
    leftFacingBeePShape.addChild(leftAntenaeLeftBee);
    endShape();
    
    beginShape();
    rightAntenaeLeftBee = createShape(ELLIPSE,65,230,20,100);
    rightAntenaeLeftBee.setFill(color(192,192,192));
    leftFacingBeePShape.addChild(rightAntenaeLeftBee);
    endShape();
    
    beginShape();
    stingerLeftBee = createShape(TRIANGLE,325,275,325,325,365,300);
    stingerLeftBee.setFill(color(0,0,0));
    leftFacingBeePShape.addChild(stingerLeftBee);
    endShape();
    
    beginShape();
    topWing = createShape(ELLIPSE,0,0,200,50);
    topWing.setFill(color(255));
    endShape();
    
    beginShape();
    bottomWing = createShape(ELLIPSE,0,0,200,50);
    bottomWing.setFill(color(255));
    endShape();
    
    
    leftFacingBeePShape.scale(0.1 *(r/25.0));
    topWing.scale(0.1*(r/25.0));
    bottomWing.scale(0.1*(r/25.0));
  }
  
  
  
  
  void displayLeftFacingBee() {
    
    pushMatrix();
    translate(-20*(r/25.0),-30*(r/25.0)); pushMatrix();
    leftFacingBeePShape.getChild(5).translate(0,10.0*sin(frameCount));
    leftFacingBeePShape.getChild(6).translate(0,10.0*sin(frameCount));
    shape(leftFacingBeePShape,x,y);
  
    
    translate(x+20*(r/25.0),y+19*(r/25.0)); pushMatrix();
    topWing.rotate(5);
    shape(topWing,0,0);
    translate(-(x+20*(r/25.0)),-(y+19*(r/25.0))); pushMatrix();
    
    translate(x+20*(r/25.0),y+40*(r/25.0)); pushMatrix();
    shape(bottomWing,0,0);
    bottomWing.rotate(5);
    
    popMatrix();
    popMatrix();
    popMatrix();
    popMatrix();
    popMatrix();
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
  void setUpRightFacingBee() {
    
    rightFacingBeePShape = createShape(GROUP);
    
    beginShape();
    body = createShape(ELLIPSE,200,300,250,250);
    body.setFill(color(255,255,0));
    rightFacingBeePShape.addChild(body);
    endShape();
    
    beginShape();
    stripe1 = createShape(RECT,175,175,50,250);
    stripe1.setFill(color(0,0,0));
    rightFacingBeePShape.addChild(stripe1);
    endShape();
    
    beginShape();
    stripe2 = createShape(RECT,100,225,50,150);
    stripe2.setFill(color(0,0,0));
    rightFacingBeePShape.addChild(stripe2);
    endShape();
    
    beginShape();
    stripe3 = createShape(RECT,250,225,50,150);
    stripe3.setFill(color(0,0,0));
    rightFacingBeePShape.addChild(stripe3);
    endShape();
    
    beginShape();
    headRightBee = createShape(ELLIPSE,355,300,100,100);
    headRightBee.setFill(color(150,80,20));
    rightFacingBeePShape.addChild(headRightBee);
    endShape();
    
    beginShape();
    leftAntenaeRightBee = createShape(ELLIPSE,335,230,20,100);
    leftAntenaeRightBee.setFill(color(192,192,192));
    rightFacingBeePShape.addChild(leftAntenaeRightBee);
    endShape();
    
    beginShape();
    rightAntenaeRightBee = createShape(ELLIPSE,375,230,20,100);
    rightAntenaeRightBee.setFill(color(192,192,192));
    rightFacingBeePShape.addChild(rightAntenaeRightBee);
    endShape();
    
    beginShape();
    stingerRightBee = createShape(TRIANGLE,75,275,75,325,45,300);
    stingerRightBee.setFill(color(0,0,0));
    rightFacingBeePShape.addChild(stingerRightBee);
    endShape();
    
    beginShape();
    topWing = createShape(ELLIPSE,0,0,200,50);
    topWing.setFill(color(255));
    endShape();
    
    beginShape();
    bottomWing = createShape(ELLIPSE,0,0,200,50);
    bottomWing.setFill(color(255));
    endShape();
    
    rightFacingBeePShape.scale(0.1*(r/25.0));
    topWing.scale(0.1*(r/25.0));
    bottomWing.scale(0.1*(r/25.0));
    
  }
  
  
  
  
  void displayRightFacingBee() {
    
    
    pushMatrix();
    translate(-20*(r/25.0),-30*(r/25.0)); pushMatrix();
    rightFacingBeePShape.getChild(5).translate(0,10.0*sin(frameCount));
    rightFacingBeePShape.getChild(6).translate(0,10.0*sin(frameCount));
    shape(rightFacingBeePShape,x,y);
  
    
    translate(x+20*(r/25.0),y+19*(r/25.0)); pushMatrix();
    topWing.rotate(5);
    shape(topWing,0,0);
    translate(-(x+20*(r/25.0)),-(y+19*(r/25.0))); pushMatrix();
    
    translate(x+20*(r/25.0),y+40*(r/25.0)); pushMatrix();
    shape(bottomWing,0,0);
    bottomWing.rotate(5);
    
    popMatrix();
    popMatrix();
    popMatrix();
    popMatrix();
    popMatrix();
    
    
  }
  
}