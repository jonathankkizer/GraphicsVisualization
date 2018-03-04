Planet myPlanetWithIronman; 
Planet myPlanetWithoutIronman; 

void setup() {
  
  size(500, 500, P3D);
  
  //Planet setup
  myPlanetWithIronman = new Planet(); 
  myPlanetWithoutIronman = new Planet(20, 100, 100, 4, 15, 10, 10, 5, 15); 
  frameRate(30);
  
}


void draw() {
  
  background(0);
  
  myPlanetWithIronman.displayWithIronman();
  myPlanetWithoutIronman.displayWithoutIronman();
  
 
}