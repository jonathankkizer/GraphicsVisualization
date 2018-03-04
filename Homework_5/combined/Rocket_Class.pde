class Rocket_Class {
  PShape rocketCylinder, rocketTop, rocketBottom, coneCylinder, coneTop, coneBottom;
  float bottom, top, h, thrustIntensity;
  int sides;
  color rocketColor;
  
  Rocket_Class(float bottom, float top, float h, float thrustIntensity, int sides, color c) {
    this.bottom = bottom;
    this.top = top;
    this.h = h;
    this.sides = sides;
    this.rocketColor = c;
    this.thrustIntensity = thrustIntensity;
    // creates cylindrical rocket body
    createRocket(this.bottom, this.top, this.h, this.sides, this.rocketColor);
    // creates rocket cone
    createRocketCone(this.bottom, 0, this.h*2, this.sides, this.rocketColor);
  }
  
  
  // code adapted from cylinder turorial here: http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
  void createRocket(float bottom, float top, float h, int sides, color rocketColor) {
    pushMatrix();
    fill(rocketColor);
    rocketBottom = createShape();
    rocketTop = createShape();
    rocketCylinder = createShape();
    
    translate(0, h/2, 0);
    
    float angle;
    float[] x = new float[sides+1];
    float[] z = new float[sides+1];
    
    float[] x2 = new float[sides+1];
    float[] z2 = new float[sides+1];
    
    // calculate x and z positions on a circle for all sides
    for(int i = 0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * bottom;
      z[i] = cos(angle) * bottom; 
    }
    
    for (int i = 0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x2[i] = sin(angle) * top;
      z2[i] = cos(angle) * top;
    }
    
    // bottom of the cylinder
    rocketBottom.beginShape(TRIANGLE_FAN);
    
    rocketBottom.vertex(0, -h/2, 0);
    for(int i = 0; i < x.length; i++) {
      rocketBottom.vertex(x[i], -h/2, z[i]);
    }
    rocketBottom.endShape();
  
    // center of the cylinder
    rocketCylinder.beginShape(QUAD_STRIP);
  
    for (int i = 0; i < x.length; i++) {
      rocketCylinder.vertex(x[i], -h/2, z[i]);
      rocketCylinder.vertex(x2[i], h/2, z2[i]);
    }
    rocketCylinder.endShape();
  
    // top of the cylinder
    rocketTop.beginShape(TRIANGLE_FAN);
    rocketTop.vertex(0, h/2, 0);
    for (int i = 0; i < x.length; i++) {
      rocketTop.vertex(x2[i], h/2, z2[i]);
    }
    rocketTop.endShape();
  
    popMatrix();
    //print(rocketBottom);
  }
  // code adapted from cylinder turorial here: http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
  void createRocketCone(float bottom, float top, float h, int sides, color c) {
    pushMatrix();
    fill(#FF4E2E);
    coneBottom = createShape();
    coneTop = createShape();
    coneCylinder = createShape();
    
    translate(0, h/2, 0);
    
    float angle;
    float[] x = new float[sides+1];
    float[] z = new float[sides+1];
    
    float[] x2 = new float[sides+1];
    float[] z2 = new float[sides+1];
    
    // calculate x and z positions on a circle for all sides
    for(int i = 0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * bottom;
      z[i] = cos(angle) * bottom; 
    }
    
    for (int i = 0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x2[i] = sin(angle) * top;
      z2[i] = cos(angle) * top;
    }
    
    // bottom of the cylinder
    coneBottom.beginShape(TRIANGLE_FAN);
    
    coneBottom.vertex(0, -h/2, 0);
    for(int i = 0; i < x.length; i++) {
      coneBottom.vertex(x[i], -h/2, z[i]);
    }
    coneBottom.endShape();
  
    // center of the cylinder
    coneCylinder.beginShape(QUAD_STRIP);
  
    for (int i = 0; i < x.length; i++) {
      coneCylinder.vertex(x[i], -h/2, z[i]);
      coneCylinder.vertex(x2[i], h/2, z2[i]);
    }
    coneCylinder.endShape();
  
    // top of the cylinder
    coneTop.beginShape(TRIANGLE_FAN);
    coneTop.vertex(0, h/2, 0);
    for (int i = 0; i < x.length; i++) {
      coneTop.vertex(x2[i], h/2, z2[i]);
    }
    coneTop.endShape();
  
    popMatrix();
    //print(rocketBottom);
  }
  
  
  void display(float x, float y, float z) {
    pushMatrix();
    translate(x, y, z);
    // displays cylindrical body of rocket
    shape(rocketTop);
    shape(rocketCylinder);
    shape(rocketBottom);
    
    // displays actual cone
    shape(coneTop);
    shape(coneCylinder);
    shape(coneBottom);
    popMatrix();
    
    // subanimation of "thrust" at the end of the rocket's cone
    pushMatrix();
    translate(random(x-thrustIntensity, x+thrustIntensity), random(y-h-thrustIntensity, y-h+thrustIntensity), random(z-thrustIntensity, z+thrustIntensity));
    fill(#FBFF2E);
    sphere(this.bottom+5);
    popMatrix();
    
  }
}