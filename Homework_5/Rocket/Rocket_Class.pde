class Rocket_Class {
  PShape topCylinder, bottomCylinder, body, nose;
  
  Rocket_Class(int sides, float r, float h) {
    float angle = 360/sides;
    float halfHeight = h/2;
    
    // draw Top Shape
    topCylinder = createShape();
    topCylinder.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians(i*angle)) * r;
      float y = sin(radians(i*angle)) * r;
      vertex(x, y, -halfHeight);
    }
    topCylinder.endShape(CLOSE);
    
    // draw Bottom Shape
    bottomCylinder = createShape();
    bottomCylinder.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos(radians(i*angle))*r;
      float y = sin(radians(i*angle))*r;
      vertex(x, y, halfHeight);
    }
    bottomCylinder.endShape(CLOSE);
  }
  
  void display() {
    shape(topCylinder);
    shape(bottomCylinder);
    //shape(body);
  }
}