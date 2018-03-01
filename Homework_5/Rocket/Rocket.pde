Rocket_Class rocket1;
float x, y, z;

void setup() {
  size(500, 500, P3D);
  rocket1 = new Rocket_Class(25, 25, 150, 50, color(#66CCCC));
  x = 0;
  y = 0;
  z = 0;
}

void draw() {
  clear();
  lights();
  //camera(mouseX, mouseY, 450.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  translate(x, y, z);
  pushMatrix();
  //translate(width/2, height);
  rocket1.display(width/2, height, 0);
  popMatrix();
  
  
  if (y < -height-100) {
    y = 100;
  }
  y -= sin(PI/4);
  //x += cos(PI/16);
   
}