class BeeSpawns {
  
  int radius;
  int x;
  int y;
  
  BeeSpawns(int beeRadius, int beeSpawnX, int beeSpawnY) {
    this.radius = beeRadius;
    this.x = beeSpawnX;
    this.y = beeSpawnY;
  }
  
  BeeSpawns generateRandomBee(int radius) {
    return new BeeSpawns(radius,int(random(50,width-50)),int(random(50,height-50)));
  }
  
  void display() {
    
    PShape ellipse = createShape(ELLIPSE,x,y,radius,radius);
    if (frameCount % 2 == 0) {
      ellipse.setFill(color(255,255,0));
    } else {
      ellipse.setFill(color(0,0,0));
    }
    
    shape(ellipse,0,0);
  }
  
  
  
}