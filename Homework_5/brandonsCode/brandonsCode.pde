PlanetWithIronman myPlanetWithIronman; 

void setup() {
  
  size(500,500,P3D);
  
  //the user is free to pass in arguments into this constructor,
  //see the class code for what would be passed in
  myPlanetWithIronman = new PlanetWithIronman(); 

}

void draw() {
  
  myPlanetWithIronman.display();
  
}