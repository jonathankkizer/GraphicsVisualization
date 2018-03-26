Flock flock1;
Flock flock2;
color c;
color d;

//array of bouncy particles
BouncyParticle[] arrayOfBouncyParticles = new BouncyParticle[20];
PImage img;

//pendulum 
Pendulum pen1;

void setup() {
  size(500, 500);
  // Flocking/ Bird Setup
  birdSetup();
  
  // Bouncy Particles Setup
  img = loadImage("fountain.png");
  img.resize(width/5,2*height/5);
  
  //populating the bouncy particle array
  for (int i=0; i < arrayOfBouncyParticles.length; i++) {
    arrayOfBouncyParticles[i] = new BouncyParticle(width/2 + random(-50,50), height/2 - 10, random(-1.5,1.5), -random(1,20), 25, width, height, 0.85);
  }
  
  // Pendulum Setup
  pen1 = new Pendulum(0.002,0.005,2);
  
  
}

void draw() {
  background(255);
  // Particle Draw Call
  //apply forces to all particles then display them all
  fill(0);
  for (int i=0; i < arrayOfBouncyParticles.length; i++) {
    arrayOfBouncyParticles[i].applyForces(0,0.25); //x force of 0, y force (gravity) of 0.25
    arrayOfBouncyParticles[i].display();
  }
  
  image(img,width/2-width/10,height/2-height/5);
  
  // Flocking Draw Calls
  flock1.runSimulation();
  flock2.runSimulation();
  
  //pendulum simulation
   pen1.display();
}

void mousePressed() {
  birdSetup();
}

void birdSetup() {
  flock1 = new Flock();
  flock2 = new Flock();
  color d = color(#CC6666);
  color c = color(#66CCCC);
  // initial birds
  for (int i = 0; i < 50; i++) {
    float positionX, positionY;
    positionX = random(0, width);
    positionY = random(0, height);
    flock1.addBird(new Bird(mouseX, mouseY, c, 40, flock2));
  }
  for (int i = 0; i < 50; i++) {
    float positionX, positionY;
    positionX = random(0, width);
    positionY = random(0, height);
    flock2.addBird(new Bird(mouseX, mouseY, d, 40, flock1));
  }
}