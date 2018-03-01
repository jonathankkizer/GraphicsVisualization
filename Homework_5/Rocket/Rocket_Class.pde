class Rocket_Class {
  PShape rocketCylinder, rocketTop, rocketBottom;
  float bottom, top, h;
  int sides;
  color rocketColor;
  
  Rocket_Class(float bottom, float top, float h, int sides, color c) {
    this.bottom = bottom;
    this.top = top;
    this.h = h;
    this.sides = sides;
    this.rocketColor = c;
    
    createRocket(this.bottom, this.top, this.h, this.sides, this.rocketColor);
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
  
  void display(float x, float y, float z) {
    pushMatrix();
    translate(x, y, z);
    shape(rocketTop);
    shape(rocketCylinder);
    shape(rocketBottom);
    popMatrix();
  }
}