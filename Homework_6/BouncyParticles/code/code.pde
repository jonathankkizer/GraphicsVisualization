//array of bouncy particles
BouncyParticle[] arrayOfBouncyParticles = new BouncyParticle[20];
PImage img;

void setup() {
  
  size(500,500);
  img = loadImage("fountain.png");
  img.resize(width/5,2*height/5);
  
  //populating the bouncy particle array
  for (int i=0; i < arrayOfBouncyParticles.length; i++) {
    arrayOfBouncyParticles[i] = new BouncyParticle(width/2 + random(-50,50), height/2 - 10, random(-1.5,1.5), -random(1,20), 25, width, height, 0.85);
  }
 
}

void draw() {
  background(0);

  //apply forces to all particles then display them all
  for (int i=0; i < arrayOfBouncyParticles.length; i++) {
    arrayOfBouncyParticles[i].applyForces(0,0.25); //x force of 0, y force (gravity) of 0.25
    arrayOfBouncyParticles[i].display();
  }
  
  image(img,width/2-width/10,height/2-height/5);

}