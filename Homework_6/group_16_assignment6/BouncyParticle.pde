class BouncyParticle extends Particle {

  int screenWidth;
  int screenHeight;
  float elasticCoefficient; //betweem 0.5 and 1
  
  BouncyParticle (float _x, float _y,
  float _vx, float _vy, float _r, int screenWidth, int screenHeight, float elasticCoefficient) {
    
    super(_x,_y,_vx,_vy,_r);
    
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    this.elasticCoefficient = elasticCoefficient;
  }
  
  
  boolean hitHorizontalWall;
  boolean hitVerticalWall;
 
  boolean hitUpperRight;
  boolean hitUpperLeft;
  boolean hitLowerRight;
  boolean hitLowerLeft;
  boolean hitACorner;
  
  
  void applyForces(float _fx, float _fy) {
    
    //check if you hit a corner
    hitUpperRight = getX() >= screenWidth && getY() <= 0;
    hitUpperLeft = getX() <= 0 && getY() <= 0;
    hitLowerRight = getX() >= screenWidth && getY() >= screenHeight;
    hitLowerLeft = getX() <= 0 && getY() >= screenHeight;
    hitACorner = hitUpperRight || hitUpperLeft || hitLowerRight || hitLowerLeft;
    
    //if the ball didnt get a corner then maybe it just hit a wall
    //what you are calling the vertical wall is the top and bottom walls, aka
    //the roof and ceiling
    
    if (hitACorner == false) {
     hitHorizontalWall = getX() >= screenWidth || getX() <= 0; 
     hitVerticalWall = getY() >= screenHeight || getY() <= 0;
    } else {
      hitHorizontalWall=false;
      hitVerticalWall=false;
    }
    
    
    //npw that you know if the balls hit a corner of a wall you can determine
    //if the call to applyForces needs to reverse the x and/or y directions
    //you need to reverse the velocity by sending the ball
    //in the opposite direction at the same velocity (or a lower
    //velocity if the elastic coeffieitn is greater than 1)
    //you have a 2 there because of what a force does to the velocity:
    //it increments it. so if you didnt have the 2 then you would go from 
    //some velocity to 0, which would make the ball stop moving in that direction
    //when it hits a wall
    if (hitACorner) {
      super.applyForces(-2*getVx(),  -(2*elasticCoefficient)*getVy());
    } 
    
    if (hitHorizontalWall) {
      super.applyForces(-2*elasticCoefficient*getVx(),  _fy);
    }
    
    if (hitVerticalWall) {
      super.applyForces(_fx, -2*elasticCoefficient*getVy());
    } else {
    
       super.applyForces(_fx,  _fy);
    }
    
    
    //correcting out of bounds particles so that the lost energy due to bouncing doesnt cause the particle to stop nearly instantly before it should
    
    if (getX() > screenWidth) {
      setX(screenWidth);
    }
    
    if (getX() < 0) {
      setX(0);
    }
    
    if (getY() > screenHeight) {
      setY(screenHeight);
    }
    
    if (getY() < 0) {
      setY(0);
    }
    
  }
  
}
