Rocket_Class rocket1;

float x, y, z, zRot, xRot;

void setup() {
  size(500, 500, P3D);
  rocket1 = new Rocket_Class(6, 100, 60);
  x = width/2;
  y = height/2;
  z = 0;
  zRot = PI/4;
  xRot = PI/3;
}

void draw() {
  background(#66CCCC);
  //translate(height/2, width/2);
  //rocket1.display();
  
  translate(x, y, z);
  rectMode(CENTER);
  rotateZ(zRot);
  rotateX(xRot);
  box(100);
  
  z++;
  //zRot += PI/16;
  //xRot += PI/5;
}