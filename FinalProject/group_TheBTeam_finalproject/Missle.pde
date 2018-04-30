class Missle {
  
  //myMissle = new Missle(missleImage,missleAlertImage,missleWidth,missleHeight,howManySecondsTheMissleLasts);
  PImage missleImage;
  PImage missleAlertImage;
  int missleWidth;
  int missleHeight;
  float howManySecondsTheMissleLasts;
  
  boolean missleCurrentlyUnderway = false;
  float timeTheMissleStartsMoving = 0.0;
  boolean animationIsDone = false;
  
  //positions of missle upepr left corner
  int x;
  int y;
  
  int whichWallTheMissleAppearsfrom; //1 is up, 2 is right, 3 is down, 4 is left...clockwise
  
  Missle(PImage missleImage, PImage missleAlertImage, int missleWidth, int missleHeight, float howManySecondsTheMissleLasts) {
    this.missleImage = missleImage;
    this.missleAlertImage = missleAlertImage;
    this.missleWidth = missleWidth;
    this.missleHeight = missleHeight;
    this.howManySecondsTheMissleLasts = howManySecondsTheMissleLasts;
    
    missleImage.resize(missleWidth,missleHeight);
    missleAlertImage.resize(width/10,height/10);
    
  }
  
  void shoot() {
   
   missleCurrentlyUnderway = true;
   assignRandomEntryPointOfMissle();
   doTheshootingAnimation();
   animationIsDone = true;
   timeTheMissleStartsMoving = elapsedTime; //elapsedTime is a global in the main program
  }
  
  void assignRandomEntryPointOfMissle() {
    
    whichWallTheMissleAppearsfrom = int(random(1,5)); //int 1-4 inclusive
    //whichWallTheMissleAppearsfrom = 3;
    
    if (whichWallTheMissleAppearsfrom == 1) {
      x = int(queenBee.x) + missleHeight/2;
      y = -50;
    }
    
    if (whichWallTheMissleAppearsfrom == 2) {
      x = width+50;
      y = int(queenBee.y) - missleHeight/2;
    }
    
    if (whichWallTheMissleAppearsfrom == 3) {
      x = int(queenBee.x) - missleHeight/2 ;
      y = height + 50;
    }
    
    if (whichWallTheMissleAppearsfrom == 4) {
      x = -50;
      y = int(queenBee.y) - missleHeight/2;
    }
    
  }
  
  void doTheshootingAnimation() {
    
  }
  
  
  
  void display() {
    
  
    
    if (whichWallTheMissleAppearsfrom == 1) {
      pushMatrix();
      translate(this.x,this.y);
      rotate(HALF_PI);
      image(missleImage,0,0);
      popMatrix();
      
    }
    
    if (whichWallTheMissleAppearsfrom == 2) {
      pushMatrix();
      translate(this.x,0);
      scale(-1,1);
      image(missleImage,0,this.y);
      popMatrix();
    }
    
    if (whichWallTheMissleAppearsfrom == 3) {
      pushMatrix();
      translate(this.x,this.y);
      rotate(3*HALF_PI);
      image(missleImage,0,0);
      popMatrix();
    }
    
    if (whichWallTheMissleAppearsfrom == 4) {
      image(missleImage,this.x,this.y);
    }
    
    
  }
  
  
  
  
  void move() {
    
    if (animationIsDone) {
      actuallyMove();
      
    }
    
    if((elapsedTime - timeTheMissleStartsMoving) >= howManySecondsTheMissleLasts) {
      animationIsDone = true;
      missleCurrentlyUnderway = false;
    }
    
  }
  
  
  void actuallyMove() {
    
    //println(whichWallTheMissleAppearsfrom);
    
    if (whichWallTheMissleAppearsfrom == 1) {
      
      this.y += height/(howManySecondsTheMissleLasts*frameRate);
    }
    
    if (whichWallTheMissleAppearsfrom == 2) {
    
      this.x -= width/(howManySecondsTheMissleLasts*frameRate);
    }
    
    if (whichWallTheMissleAppearsfrom == 3) {
     
      this.y -= height/(howManySecondsTheMissleLasts*frameRate);
    }
    
    if (whichWallTheMissleAppearsfrom == 4) {
     
      this.x += width/(howManySecondsTheMissleLasts*frameRate);
    }
    
  }
  
  
}