class Bee extends ParticleWithMass {
  
  //each bee is represented as ball which exhibits spring like behavior, i.e. it oscilattes about its "center of restitution"
  //which is the point rx, ry
  
  float rx; 
  float ry;
  float ks; //spring stifness constant. a spring which is more stiff will move towards its center of restituion more quickly
  float kd; //spring damping coefficient. each oscillation of the spring/bee around the center of restituion will lose some amplitude/length
            //based on this damping coefficient. a coefficient of 1 means no amplitude is lost per oscilaation cycle
  
  Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, 
  float _rx, float _ry, float _ks, float _kd) {
    
    //_x and _y: the initial x,y position of the bee. doesnt matter much since I am changing its x based on mouse position (in the case of the parent bee)
    //or the parent bees (in the case of the children bees)
    
    //_vx,_vy, _ax_, _ay: initial velocity and acceleration of the bees. once again these dont really matter because they are updated
    //as the bees are moved with the mouse. 
    
    //_r and _m: radius and mass of the bee. both matter, changing the mass will affect how the "spring" (the bee) oscillates
    
    
    super(_x,_y,_vx,_vy,_ax,_ay,_r,_m);
    rx = _rx;
    ry = _ry;
    ks = _ks;
    kd = _kd;
    
  }
  
  void display() {
    //before you display a bee, update its location based on the spring physics
    updateLocation();
    super.display();
  }
  
  void updateLocation() {
   //code borrows form dr abarams lectures: it models a spring with dampening
   //y
   float fy = -((ks * (y - ry)) + kd*vy); //dampening
   float ay = fy/m;
   vy = vy + ay;
   y += vy;
   
   //x
   //code borrows form dr abarams lectures: it models a spring with dampening
   float fx = -((ks * (x - rx)) + kd*vx); //dampening
   float ax = fx/m;
   vx = vx + ax;
   x += vx;
   
   //setting the center of restitution of each bee/spring to be the mouse position, but these values
   //are overwritten for bees which are children (See the next method)
   rx = mouseX;
   ry = mouseY;
    
  }
  
  void attachChildParticle(Bee childParticle) {
    //center of restitution (rx,ry) of the child particle is the position of the parent particle
    childParticle.rx = this.x;
    childParticle.ry = this.y;
  }
  
  
  
  
  
  
  
}