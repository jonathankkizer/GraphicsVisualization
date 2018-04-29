class BeeSpawns {
  
  int r;
  int x;
  int y;
  String beeColor;
  
  //PSHAPE STUFF
  //right-facing bee
  PShape rightFacingBeePShape;
  PShape headRightBee; 
  PShape leftAntenaeRightBee;
  PShape rightAntenaeRightBee;
  PShape stingerRightBee;
  //PShapes shared by both bees
  PShape body;
  PShape stripe1;
  PShape stripe2;
  PShape stripe3;
  PShape topWing;
  PShape bottomWing;
  
  BeeSpawns(int beeRadius, int beeSpawnX, int beeSpawnY, String _c) {
    this.r = beeRadius;
    this.x = beeSpawnX;
    this.y = beeSpawnY;
    _c = beeColor;
    setUpRightFacingBee();
  }
  
  BeeSpawns generateRandomBee(int radius, String beeColor) {
    return new BeeSpawns(radius,int(random(50,width-50)),int(random(50,height-50)), beeColor);
  }
  
  void display() {
    
    displayRightFacingBee();
    //fill(#FFCC00);
    //ellipse(x, y, beeRadius, beeRadius);
    
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