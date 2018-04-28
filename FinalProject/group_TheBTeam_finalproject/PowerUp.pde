//this class was implemented in the main code as a singleton - only up to 1 powerup is ever on the canvas, either floating around 
//or in its storage box at the top of the screen

class PowerUp {
  
  PImage powerUpImage;
  int imageWidth;
  int imageHeight;

  
  //
  //the following globals arent used in the constructor. these are assigned outside the constructor
  //
  
  //assigned in the display at random point, i.e. the initial positions are determined by the random spawn
  int xPosition; 
  int yPosition; 
  boolean powerupIsNotUndergoingAMovement = true;
  
  //assigned in the assignAmovementPattern() method
  int initialXPositionOfMovementPattern;
  int initialYPositionOfMovementPattern;
  int finalXPositionOfMovementPatern;
  int finalYPositionOfMovementPatern;
  float secondsToTakeForThisMovement;
  
  //controls
  
  int lowestAllowedXPositionOfPowerUp = -20; //if this is a negative number, the powerup can go off the screen
  int lowestAllowedYPositionOfPowerUp = -20;
  int highestAllowedXPositionOfPowerUp = width-imageWidth +20; //if youre adding a positive numbr to "width-imageWidth" then the powerup can go off the screen
  int highestAllowedYPositionOfPowerUp = height-imageHeight +20;
  
  //you can make it so the star only hovers around the middle
  //TODO: get rid of the case where the star just stops moving completely, happens a lot with these commented out parameters
  /*
  int lowestAllowedXPositionOfPowerUp = 200; //if this is a negative number, the powerup can go off the screen
  int lowestAllowedYPositionOfPowerUp = 200;
  int highestAllowedXPositionOfPowerUp = width-imageWidth - 200; //if youre adding a positive numbr to "width-imageWidth" then the powerup can go off the screen
  int highestAllowedYPositionOfPowerUp = height-imageHeight - 200;
  */
  
  //35 and 45 seem to be good values for the real game/finished product
  //make these numbers very high to make collecting the powerup easier
  float lowestAllowedNumberOfFramesToMoveInALine = 35.0; 
  float highestAllowedNumberOfFramesToMoveInALine = 40.0; 
  
  //the +1 at the end is just for rounding errors / contingency, shouldnt technically be needed
  //you want to know when a powerup is done moving on its linear path and this calculation helps later
  float largestPossibleXStepSize = ((highestAllowedXPositionOfPowerUp - lowestAllowedXPositionOfPowerUp) / lowestAllowedNumberOfFramesToMoveInALine) + 1;
  float largestPossibleYStepSize = ((highestAllowedYPositionOfPowerUp - lowestAllowedYPositionOfPowerUp) / lowestAllowedNumberOfFramesToMoveInALine) + 1;
  
  //constructor
  PowerUp(PImage _powerUpImage, int _imageWidth, int _imageHeight) {
    
    //resize the image
    _powerUpImage.resize(_imageWidth,_imageHeight);
    
    this.powerUpImage = _powerUpImage;
    this.imageWidth = _imageWidth;
    this.imageHeight = _imageHeight;
  
    
  }
  
  void displayAtRandomPoint() {
    //the star spawns at a random point when this method is called
    this.xPosition = int(random(lowestAllowedXPositionOfPowerUp,highestAllowedXPositionOfPowerUp));
    this.yPosition = int(random(lowestAllowedYPositionOfPowerUp,highestAllowedYPositionOfPowerUp));
    
    display();
  }
  
  
  void display() {
    
    //gives the star its shaking behavior, aka its 2nd level of animation
    this.xPosition += random(-15,15);
    this.yPosition += random(-15,15);
    tint(random(255),random(255),random(255));
    image(powerUpImage,xPosition,yPosition);
    noTint();
  
    
  }
  
  void displayWithoutShaking() {
    //we dont want the powerup to shake when it is withint he storage box
    image(powerUpImage,xPosition,yPosition);
  
  }
  
  void moveIt() {
    //the mvoement works as follows:
    //get the current point of the powerup, pick a random point, and mvoe to it in a straight line
    //then once this movement happens, assign a new movement and do that one
    //this way, the powerup is constamntly moving in lines between random points on the screen
    if (powerupIsNotUndergoingAMovement) {
      assignAmovementPattern();
      powerupIsNotUndergoingAMovement = false;
    } else {
      moveAccordingToCurrentMovementPattern();
    }
  
  }
  
  void assignAmovementPattern() {
    
    //give it a random point to move to
    this.initialXPositionOfMovementPattern = this.xPosition;
    this.initialYPositionOfMovementPattern = this.yPosition;
    this.finalXPositionOfMovementPatern = int(random(lowestAllowedXPositionOfPowerUp,highestAllowedXPositionOfPowerUp));
    this.finalYPositionOfMovementPatern = int(random(lowestAllowedXPositionOfPowerUp,highestAllowedYPositionOfPowerUp));
    
    //take between x and y frames to move from initial to final position for the movement of the powerup
    this.secondsToTakeForThisMovement = random(lowestAllowedNumberOfFramesToMoveInALine,highestAllowedNumberOfFramesToMoveInALine);
    
  }
  
  void moveAccordingToCurrentMovementPattern() {
     
    //you know a powerup is done moving when it is "close enough" to its final position, where close enough is quantified by the largest possible step size
    
    //&& should be ok instead of || but im just playing it safe - id rather the powerup stop moving a pixel too early than
    //never register as being done
    
    boolean powerUpIsDoneMoving = (   abs(this.xPosition - this.finalXPositionOfMovementPatern) <= largestPossibleXStepSize  || 
    abs(this.yPosition - this.finalYPositionOfMovementPatern) <= largestPossibleYStepSize  );
    
    if (powerUpIsDoneMoving == false) {
      //the star has a constant velocity moving between the two points
      float xVelocity = (this.finalXPositionOfMovementPatern - this.initialXPositionOfMovementPattern) / secondsToTakeForThisMovement;
      float yVelocity = (this.finalYPositionOfMovementPatern - this.initialYPositionOfMovementPattern) / secondsToTakeForThisMovement;
      this.xPosition += xVelocity;
      this.yPosition += yVelocity;
    } else {
      powerupIsNotUndergoingAMovement = true;
    }
    
  }
  
}