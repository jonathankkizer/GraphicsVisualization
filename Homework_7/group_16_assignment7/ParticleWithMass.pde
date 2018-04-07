//Code borrowed from Dr. Abahrams lecture slide. This is only a superclass for Bee, since Bees are represented as a ball which exhibits
//spring-like behavior and such a ball must have mass

class ParticleWithMass {
  
float x, y;
float vx, vy;
float ax, ay;
float r;
float m;
 
 ParticleWithMass(float _x, float _y,
 float _vx, float _vy, float _ax, float _ay, float _r,  float _m) {
 x = _x;
 y = _y;
 vx = _vx;
 vy = _vy;
 r = _r;
 ax = _ax;
 ay = _ay;
 m = _m;
 }
 
 void applyForces(float
_fx, float _fy) {
  
  ax = _fx/m;
  ay = _fy/m;
  vx += ax;
  vy += ay;
  x += vx;
  y += vy;
 
 }
 
 void display() {
   PShape ellipse = createShape(ELLIPSE,x,y,r,r);
    if (frameCount % 2 == 0) {
      ellipse.setFill(color(255,255,0));
    } else {
      ellipse.setFill(color(0,0,0));
    }
    
    shape(ellipse,0,0);
 }

}
