// Planet globals

Planet myPlanetWithoutIronman; 
Planet myPlanetWithoutIronman2; 

// Rocket Globals
Rocket_Class rocket1;
Rocket_Class rocket2;
float x, y, z;

// UFO Globals
UFO ufo1;

void setup() {
  
  size(500, 500, P3D);
  frameRate(24);
  
  //Planet setup
  myPlanetWithoutIronman = new Planet(50,200,250,5,30,20,7,10,10); 
  myPlanetWithoutIronman2 = new Planet(20, 100, 100, 4, 15, 10, 10, 5, 15); 
  
  //Rocket Setup
  rocket1 = new Rocket_Class(25, 25, 150, 5, 25, color(#66CCCC));
  rocket2 = new Rocket_Class(5, 5, 60, 3, 6, color(#CC6666)); 
  x = 0;
  y = -650;
  z = 0;
  
  //UFO Setup
  ufo1=new UFO();
  
}

void draw() {
  
  background(0);
  clear();
  lights();
  
  //
  //Planet Code
  //
  myPlanetWithoutIronman.displayWithoutIronman();
  myPlanetWithoutIronman2.displayWithoutIronman();
  
  
  //
  //Rocket Code
  //
  //rotate(rotateFactor);
  pushMatrix();
  //translate(x, y, z);
  //translate(width/2, height);
  translate(x, y, z);
  rotate(-PI/16);
  rocket2.display(width/4, height, 0);
  popMatrix();
  pushMatrix();
  translate(0, y, z);
  rocket1.display(width/2, height, 0);
  popMatrix();
  
  
  if (y > height) {
    y = -650;
  }
  if (z > 300) {
    z = 0;
  }
  if (x > width) {
    x = 0;
  }
  
  y += sin(PI/4);
  z += sin(PI/16);
  x += cos(PI/4);
  
  //
  //UFO code
  //
  ufo1.display();  
  
}