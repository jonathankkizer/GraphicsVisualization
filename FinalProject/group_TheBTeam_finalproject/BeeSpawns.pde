class BeeSpawns {
  
  int radius;
  int x;
  int y;
  String beeColor;
  
  BeeSpawns(int beeRadius, int beeSpawnX, int beeSpawnY, String _c) {
    this.radius = beeRadius;
    this.x = beeSpawnX;
    this.y = beeSpawnY;
    _c = beeColor;
  }
  
  BeeSpawns generateRandomBee(int radius, String beeColor) {
    return new BeeSpawns(radius,int(random(50,width-50)),int(random(50,height-50)), beeColor);
  }
  
  void display() {
    fill(#FFCC00);
    
    ellipse(x, y, beeRadius, beeRadius);
  }
  
  
  
}
