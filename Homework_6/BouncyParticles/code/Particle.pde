class Particle {
  

  float x, y;
  float vx, vy;
  float r;
 
 Particle(float _x, float _y,
 float _vx, float _vy, float _r) {
 x = _x;
 y = _y;
 vx = _vx;
 vy = _vy;
 r = _r;
 }
 
 void applyForces(float
_fx, float _fy) {
 vy += _fy;
 vx += _fx;
 y += vy;
 x += vx;
 }
 
 void display() {
 ellipse(x, y, r, r);
 }
 
 
 
 float getX() {
   return x;
 }
 
 void setX(float newX) {
   x = newX;
 }
 
 
 float getY() {
   return y;
 }
 
 void setY(float newY) {
   y = newY;
 }
 
 
 
 
 float getVx() {
   return vx;
 }
 
 void setVx(float newVx) {
   vx = newVx;
 }
 
 
 float getVy() {
   return vy;
 }
 
 void setVy(float newVy) {
   vy = newVy;
 }
 
 
 float getR() {
   return r;
 }
 
 void setR(float newR) {
   r = newR;
 }
 

}