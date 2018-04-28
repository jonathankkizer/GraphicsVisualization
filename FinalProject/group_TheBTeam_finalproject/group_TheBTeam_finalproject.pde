// Sound Import
import processing.sound.*;
SoundFile intro, birdStrike, win, musicTrack, gameOver, collectBee, underEffectOfPowerUp, collectPowerUp, electricShock;

//background pictue
PImage backgroundPicture;


// Bird & Flock Initialization
Flock flock1;
FloatList birdPos;
color c, d;
int birdNestX, birdNestY, numBirds;
float val = 0;

//Bee Initialization
//The smooth motion of particles is caused by modeling the bees as particles which are attached to a spring

Bee queenBee; //the bee in the front, she is special and distinct from the "child" bees 

//Controls for Customizing Feel of the Game
float ks = 0.1; //spring stiffness value
float kd = 0.3; //spring damping coefficient
int beeRadius = 20; //changes radius of bees and beeSpawns
//a bee will randomly spawn on screen every x-y frames, where x and y are the lower and upper bound
int lowerBoundForHowManyFramesABeeTakesToAppear = 60;
int upperBoundForHowManyFramesABeeTakesToAppear = 250;
int numberOfBeesToWin = 10;
int numberOfSecondsInAFullDay = 30; //the background changes to day and night
int numberOfFramesBeforeBirdsStartDoingDamage = 100;

//a bee will randomly spawn on screen every x-y frames
int framesBeforeABeeSpawnAppears = int(random(lowerBoundForHowManyFramesABeeTakesToAppear,upperBoundForHowManyFramesABeeTakesToAppear)); 
BeeSpawns beeSpawnNest; //used to call the beeSpawns since processing doesnt seem to let me have statics
int framesPassedSinceBeeSpawn = 0; //a counter used in determining when to spawn a new bee on screen
BeeSpawns beeSpawn; //a bee to spawn
ArrayList<BeeSpawns> beeSpawnList = new ArrayList<BeeSpawns>(); //list of spawnes bees

//Timer stuff
Timer myTimer;
boolean gameIsPaused = false;
float elapsedTime;
//give the time user to move the mouse to the canvas
int howLongGameIsDelayedBeforeStarting = 1500; //wait 1500ms before starting the game
//used to assign the ammount of time that setup took
int timeSetUpCompleted;

//
//Bee sprite animation stuff - this is just the random animated sprite in the upper right corner
float animationTimerBee = 0.0; //value you pick based on how much time has ellapsed
float animationTimerValueBee = 0.25; //take 0.25 seconds to change to bees next image frame
int currentFrameBee = 0; //start out on the 1's frame
int numFramesBee = 3; //number of frames your animation has, three for bee

PImage arrayOfBeeFrameImages [] = new PImage[numFramesBee];
String fileNameToLoadBee;

//End bee sprite animation stuff
//


//power-up stuff
//
//controls for powerups
//
int onAverageAPowerUpAppearsAfterThisManySecondsHasPassed = 1;
float howManySecondsAPowerUpLasts = 10;
int powerUpimageWidth = 50;
int powerUpimageHeight = 50;
//TO CONTROL WHAT AREA OF THE CANVAS THE POWERUP MOVES IN - AND HOW QUICKLY IT MOVES - SEE THE CONTROLS IN THE POWERUP CLASS
//
//

PowerUp myPowerUp;
PImage beeThemedPictureFrame;
PImage powerUpImage;
boolean powerupOnScreenAlready = false;
boolean powerupInStorageBox = false;
boolean beeIsCurrentlyUnderEffectOfPowerUp = false;
float timePowerUpWasActivated;

//these are used in a linear model which allows me to scale the volume of the power-up music to be based on how much
//longer the effect of the power-up will last. these variables are assigned in the void keyPressed() when the key == ' ' (aka spacebar)
float b,m,x;


//the electric fence border pic
PImage electricFenceBorder;

//font
PFont courier;
int defaultTextSize;

//make it so the user has some time for immuninity so that they dont die instantly
int powerUpXPositionWhenInBox;
int powerUpYPositionWhenInBox;

void setup() {
  
  //size is modular , 800x800 is reccomended but if you change it then everything else will (mostly) change accordingly
  size(800, 800);
  frameRate(60);
  
  stroke(255);
  strokeWeight(2);
 
  defaultTextSize = int( 20 + (((width+height)/2.0)-500)/30.0  );
  
  
  //for trying to make the game more modular when size() parameters changed
  textSize(defaultTextSize);
  
  // Sound setup code
  intro = new SoundFile(this, "achievement.wav");
  intro.amp(.8);
  birdStrike = new SoundFile(this, "hit.wav");
  birdStrike.amp(.8);
  win = new SoundFile(this, "win.wav");
  win.amp(.8);
  musicTrack = new SoundFile(this, "musicTrack.wav");
  musicTrack.amp(.6);
  gameOver = new SoundFile(this, "gameOver.wav");
  gameOver.amp(.8);
  collectBee = new SoundFile(this, "pickUp.wav");
  collectBee.amp(.7);
  //brandons music
  // source of powerup music, free online: https://www.dl-sounds.com/royalty-free/8-bit-arcade4/
  underEffectOfPowerUp = new SoundFile(this, "underEffectOfPowerUp.mp3");
  underEffectOfPowerUp.amp(1);
  collectPowerUp = new SoundFile(this, "collect.wav");
  collectPowerUp.amp(1);
  //electric fence collosion - source: https://www.freesoundeffects.com/free-sounds/electric-sounds-10032/
  electricShock = new SoundFile(this, "electricShock.wav");
  
  intro.play();
  
  //background and border
  backgroundPicture = loadImage("backgroundPicture.png"); //source: https://4vector.com/free-vector/cloud-trees-scene-93393
  backgroundPicture.resize(width,height);
  electricFenceBorder = loadImage("electricFenceBorder.png");
  electricFenceBorder.resize(width,height);
  
  
  flock1 = new Flock();
  birdNestX = width/2;
  birdNestY = height/2;
  
  // NOTE: at 5 birds, performance issues don't show up until greater than 15 bees; at 15 Birds, 9 bees makes game unplayable
  numBirds = 5;
  
  d = color(#CC6666);
  c = color(#66CCCC);
  
  // Bees setup
  courier = createFont("Trebuchet MS", defaultTextSize);
  textFont(courier);
  
  //Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, 
  //float _rx, float _ry, float _ks, float _kd)
  queenBee = new Bee(width/2,height/2,0,0,0,0,beeRadius,1,mouseX,mouseY,ks,kd);
  beeSpawnNest = new BeeSpawns(beeRadius,250,250, "yellow");
  
  myTimer = new Timer(true);
  
  
  //populates the array of bee image frames
   for(int i=0;i<numFramesBee;i++) {
     fileNameToLoadBee= "bee" + str(i+1) + ".jpg";
     arrayOfBeeFrameImages[i] = loadImage(fileNameToLoadBee);
   }
   
  //powerup stuff
  powerUpImage = loadImage("starImage.png");
  beeThemedPictureFrame = loadImage("beeThemedPictureFrame.jpg");
  beeThemedPictureFrame.resize(powerUpimageWidth + 20,powerUpimageHeight + 20);
  myPowerUp = new PowerUp(powerUpImage, powerUpimageWidth, powerUpimageHeight);
  //another attempt at modular code based on setup() size
  powerUpXPositionWhenInBox = myPowerUp.xPosition = int(180*(width/500.0) + (width-500)/4.0 + powerUpimageWidth/2.72   - (powerUpimageWidth - 30)*1.85    );
  powerUpYPositionWhenInBox = myPowerUp.yPosition = int(10*(height/500.0)+(height-500)/10.0 + powerUpimageHeight/3.0   - (powerUpimageHeight - 30)*0.35   );
   
  
   
  
  delay(howLongGameIsDelayedBeforeStarting); //the game doesnt start immediately, but rater waits this many milliseconds
  
  timeSetUpCompleted = millis();
  
}

void draw() {
   
  elapsedTime = (myTimer.getElapsedTime() - timeSetUpCompleted)/1000;
  
  
  //to cycle between day and night we use a sine functions. numbers selected to best show day and night modes
  //tint(50,50,139); //night mode
  //tint(255,255,255); //day mode
  int redTintValue = int(102.5*sin(elapsedTime*(2*PI)/numberOfSecondsInAFullDay) + 152.5) ;
  int greenTintValue = int(102.5*sin(elapsedTime*(2*PI)/numberOfSecondsInAFullDay) + 152.5) ;
  int blueTintValue = int(58*sin(elapsedTime*(2*PI)/numberOfSecondsInAFullDay) + 197) ;
  tint(redTintValue,greenTintValue,blueTintValue);
  image(backgroundPicture,0,0);
  noTint();
  image(electricFenceBorder,0,0);
  
  if (frameCount == 1) {
    musicTrack.loop();
  }
 
 
  
  if (frameCount >= numberOfFramesBeforeBirdsStartDoingDamage) {
  flock1.runSimulation();
  }
    
  // updates the FloatList showing current X,Y coordinates
  birdPos = flock1.updatePosition();
    
  // prints current position from FloatList
  //flock1.printPosition();
    
  // removes birds that have flown beyond the screen
  flock1.cullFlock();
    
  // adds birds if the total number falls below numBirds
  // if in boss mode, circular spawn is used; if not, regular fixed spawn is used
  if (flock1.getSize() < numBirds) {
    birdCircleSpawn();
  }
    
  // Bees Draw
  checkIfItIstimeToSpawnABee();
   
  //show all the beespawns
  
  for(BeeSpawns myBeeSpawn: beeSpawnList) {
    myBeeSpawn.display();
  }
  
   
  //See if the queen hit a beespawn, thus adding the bee to the chain
  checkCollisionsWithBeeSpawns();
  
   
  //see if any bees hit a wall, thus killing them. if the queen hits a wall then game over
  //the powerup makes you invincible
  if(beeIsCurrentlyUnderEffectOfPowerUp == false) {
    checkCollisionsWithWall();
  }
   
  //the bee class is more or less a linked list, displaying the queenbee displays the children too
  //invincible bees are displayed differently
  if(beeIsCurrentlyUnderEffectOfPowerUp) {
    queenBee.displayBeeAndChildrenAsInvincible();
  } else {
    queenBee.displayBeeAndChildren();
  }
   
  //counter
  framesPassedSinceBeeSpawn += 1;
   
  // Checks collisions with birds and bees
  if(beeIsCurrentlyUnderEffectOfPowerUp == false && frameCount > numberOfFramesBeforeBirdsStartDoingDamage) {
    checkBeeBirdCollision();
  }
   
  //showing how much in game time has ellapsed,
  //this is paused when the game is paused with "p"
  //also showing number of bees and objective
  
  //fill(255,60,60);
  fill(255,0,0);
  text("Time: " + str(elapsedTime), 30*(width/500.0), 50*(height/500.0));
  text("Collect " +str(numberOfBeesToWin) + " Bees to win. Avoid birds.", 90*(width/500.0) + (width-500.0)/13.5, 475*(width/500.0));
  text("Number of Bees: " + str(queenBee.getNumberOfChildren()),280*(width/500.0) + (width-500.0)/5.0 , 50*(height/500.0));
  //text("Frame Rate: " + str(frameRate), 10, 60);
  //flock2.runSimulation();
  //saveFrame();
  //print(flock1.getSize(), "\n");
  
  //show the bee sprite
  determineNextImageToShowAndShowIt(arrayOfBeeFrameImages);
  
  //show the bee-themed picture frame for the powerup to be in
  image(beeThemedPictureFrame,180*(width/500.0) + (width-500)/4.0 - ( (powerUpimageWidth+powerUpimageHeight)/2.0 - 30)*1.5 ,10*(height/500.0)+(height-500)/10.0);
  
  //check win condition
  checkNumberOfBees();
  
  //check if its time for a powerup to spawn
  //as long as one is neither on the screen nor in the storage box
  if (powerupOnScreenAlready==false && powerupInStorageBox == false) {
    spawnPowerUpBasedOnRNG();
  }
  
  //move and show the powerup if its on the screen moving
  if (powerupOnScreenAlready) {
    //move it somehow...based on the ingame time
    myPowerUp.moveIt();
    myPowerUp.display();
  }
  
  if(powerupInStorageBox) {
    //display the star in there
    myPowerUp.xPosition = powerUpXPositionWhenInBox;
    myPowerUp.yPosition = powerUpYPositionWhenInBox;
    myPowerUp.displayWithoutShaking();
  }
  

  
  //see if the queen bee hit a powerup
  checkCollisionWitPowerUpAndActAccordingly();
  
  
  //check if it is time for the effects of the activiated powerup to go away
  checkToSeeIfItIstimeForThePowerEffectToDissapear();
  
  
  //saveFrame();
}

// spawn new birds from fixed point (center of display)
void birdFixedSpawn() {
  flock1.addBird(new Bird(birdNestX, birdNestY, c, 40));
}

// spawn new birds from a circle around the center of the display
void birdCircleSpawn() {
  float speed = 10;
  float x = sin(val);
  float y = cos(val);
  
  x *= width/4;
  y *= height/4;
  x += width/2;
  y += height/2;
  println(x);
  println(y);
  
  flock1.addBird(new Bird(x, y, c, 40));
  
  val += speed;
}



void checkIfItIstimeToSpawnABee() {
  if (framesPassedSinceBeeSpawn == framesBeforeABeeSpawnAppears) {
    if (frameCount % 2 == 0) {
      beeSpawn = beeSpawnNest.generateRandomBee(beeRadius, "black");
    } else {
      beeSpawn = beeSpawnNest.generateRandomBee(beeRadius, "yellow");
    }
     beeSpawnList.add(beeSpawn);
     framesPassedSinceBeeSpawn = 0;
     framesBeforeABeeSpawnAppears = int(random(lowerBoundForHowManyFramesABeeTakesToAppear,upperBoundForHowManyFramesABeeTakesToAppear));
   }
}

void checkCollisionsWithWall() {
  
    //if the queen bee hit a wall then game over
    if (queenBee.x > width-10 || queenBee.x < 10 || queenBee.y > height-10 || queenBee.y < 10) {
      background(0);
      //text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
      textSize(defaultTextSize);
      text("The queen has died", width/2 - 130, height/2 - 80);
      textSize(50);
      text("GAME OVER", width/2 - 130, height/2 - 20);
      textSize(defaultTextSize);
      musicTrack.stop();
      //this just sounds good tbh
      for(int i = 0; i<10; i++) {
        electricShock.play();
      }
      
      gameOver.play();
      
      noLoop();
      
    } else {
    //otherwiise, if the queen had children then check of those hit a wall 
        if (queenBee.childBee != null) {
     
          checkChildrensCollisionsWithWall(queenBee.childBee);
        }
      }
    
}

void checkChildrensCollisionsWithWall(Bee childBeeToCheck) {
  
  //if a child bee hit a wall then get the pees parent and delete that parents children, thus deleting the
  //bee that hit a wall and all its children
  if (childBeeToCheck.x > width-10 || childBeeToCheck.x < 10 || childBeeToCheck.y > height-10 || childBeeToCheck.y < 10) {
    (childBeeToCheck).parentBee.deleteBeesChildren();
    electricShock.play(); 
    electricShock.play();
    
  } else {
  //otherwise if the child bee didnt hit a wall, keep checking all the children (remember it's a linked list of bees)
    if (childBeeToCheck.childBee != null) {
      checkChildrensCollisionsWithWall(childBeeToCheck.childBee);
    }
  }
}

void checkCollisionsWithBeeSpawns() {
  
  //for each bee spaw, check if the queen hit it
  for(int i = 0; i < beeSpawnList.size(); i++) {
    if ( dist(queenBee.x, queenBee.y, beeSpawnList.get(i).x, beeSpawnList.get(i).y ) <= beeRadius ) {
      //if the queen hit a spawn then remove it from the spawn list and add a child to the end of the bee line
      beeSpawnList.remove(i);
      Bee theLastChild = queenBee.getLastChild();
      //add the new bee to the end of the trail
      collectBee.play();
      theLastChild.attachChildParticle(new Bee(theLastChild.x,theLastChild.y,0,0,0,0,beeRadius,1,250,250,ks,kd));
     
    }
  }
}

// checks whether the queen bee has hit a bird; if yes, kills game; if not, checks children with helper function
void checkBeeBirdCollision() {
  for(int counter = 0; counter < birdPos.size(); counter+=2) {
    if ((birdPos.get(counter) <= (queenBee.x + 15)) && (birdPos.get(counter) >= (queenBee.x-15))) {
      if ((birdPos.get(counter+1) <= (queenBee.y + 15)) && (birdPos.get(counter+1) >= (queenBee.y-15))) {
        background(0);
        musicTrack.stop();
        birdStrike.play();
        gameOver.play();
        //text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
        textSize(defaultTextSize);
        text("The queen has died", width/2 - 130, height/2 - 80);
        textSize(50);
        text("GAME OVER", width/2 - 130, height/2 - 20);
        textSize(defaultTextSize);
        noLoop();
      }
    }
  }
  if (queenBee.childBee != null) {
    checkChildrenBeeBirdCollision(queenBee.childBee);
  }
}

// recursively checks to see if children have hit bird; if yes, child and its subsequent nodes are deleted
void checkChildrenBeeBirdCollision(Bee childBeeToCheck) {
  for(int counter = 0; counter < birdPos.size(); counter+=2) {
    if ((birdPos.get(counter) <= (childBeeToCheck.x + 25)) && (birdPos.get(counter) >= (childBeeToCheck.x-25))) {
      if ((birdPos.get(counter+1) <= (childBeeToCheck.y + 25)) && (birdPos.get(counter+1) >= (childBeeToCheck.y-25))) {
        birdStrike.play();
        (childBeeToCheck).parentBee.deleteBeesChildren();
        //print("Child bees deleted from bird strike!\n");
      }
    } else {
      if (childBeeToCheck.childBee != null) {
        checkChildrenBeeBirdCollision(childBeeToCheck.childBee);
      }
    }
  }
}

void checkNumberOfBees() {
  
  if (queenBee.getNumberOfChildren() >= numberOfBeesToWin) {
     textSize(35);
     text(str(numberOfBeesToWin)+ " bees collected: You win!", width/2 - 215, height/2 - 10);
     musicTrack.stop();
     underEffectOfPowerUp.stop();
     win.play();
    noLoop();
  }
  
}

//just a function which has the logic for animating a sprite, in this case mario, at an fps other than the framerate of 60
void determineNextImageToShowAndShowIt(PImage[] arrayOfImageFrames) {
  
  //>= because the framerate may not always be at 60 fps, may be
  //minor drop in speed. if this much time has ellapses or more,
  //thne because you're resetting animationTimer to get back on track
  
  if ((myTimer.getElapsedTime() - animationTimerBee) >= animationTimerValueBee*1000)  {
    //println(myTimer.getElapsedTime());
    currentFrameBee = (currentFrameBee + 1) % numFramesBee; //loops between all the frames
                                                   //by updating the current frame
    animationTimerBee = myTimer.getElapsedTime();
  }
  arrayOfImageFrames[currentFrameBee].resize(40,40);
  image(arrayOfImageFrames[currentFrameBee], width-40, 0);
}

void checkToSeeIfItIstimeForThePowerEffectToDissapear() {

   if (beeIsCurrentlyUnderEffectOfPowerUp) {
      if (    (elapsedTime - timePowerUpWasActivated)  > howManySecondsAPowerUpLasts  ) {
        //if the time has passed (using the timer to take into consideration pauses), then the powerup
        //goes away and the poweruo music stops
        beeIsCurrentlyUnderEffectOfPowerUp = false;
        underEffectOfPowerUp.stop(); //stop the powerup music that is looping
        musicTrack.amp(.6); //put the main music back up to the normal volume
      } else {
        //scale down the music to get softer as the powerup runs out, to give an indication when it will run out
        x = elapsedTime - timePowerUpWasActivated;
        float ampValue = m*x + b;
        underEffectOfPowerUp.amp(ampValue);
        }
      colorMode(HSB);
      fill(random(255),random(255),200);
      textSize(50);
      text(str( int(howManySecondsAPowerUpLasts - (elapsedTime - timePowerUpWasActivated))),(2.0/5.0)*width + (width-500)/5.4545 - (powerUpimageWidth-30)/1.053 ,height/5.0  + (powerUpimageWidth-30)/2.0);
      textSize(defaultTextSize);
      fill(255,0,0);
      colorMode(RGB);
    } 
}

void spawnPowerUpBasedOnRNG() {
  
  //just RNG to generate a powerup based on what the user specified in the globals
  int randInt = int(random(onAverageAPowerUpAppearsAfterThisManySecondsHasPassed*60));
  
  if (randInt == onAverageAPowerUpAppearsAfterThisManySecondsHasPassed*60 -1) {
    //spawn a powerup ont the screen
    myPowerUp.displayAtRandomPoint();
    powerupOnScreenAlready = true;
  }

}

void checkCollisionWitPowerUpAndActAccordingly() {
  //if you hit a powerup then change the booleans which indicate this, and play a sound to indicate it has been collected
  
  boolean powerUpIsNotWithinBox = !(myPowerUp.xPosition == powerUpXPositionWhenInBox && myPowerUp.yPosition == powerUpYPositionWhenInBox);
  boolean queenBeeCollidedWithPowerUp = queenBee.x >= myPowerUp.xPosition && queenBee.x <= (myPowerUp.xPosition + myPowerUp.imageWidth) &&
  queenBee.y >= myPowerUp.yPosition && queenBee.y <= (myPowerUp.yPosition + myPowerUp.imageHeight);
  

    if (queenBeeCollidedWithPowerUp && powerUpIsNotWithinBox){ 
      //put powerup in storage box
      powerupInStorageBox = true;
      powerupOnScreenAlready = false;
      collectPowerUp.play();
    } 
    //else do nothing
    
}

void keyPressed() {
  //cheat code - press up to instantly get another bee
  if (keyCode == UP) {
    Bee theLastChild = queenBee.getLastChild();
    theLastChild.attachChildParticle(new Bee(theLastChild.x,theLastChild.y,0,0,0,0,beeRadius,1,250,250,ks,kd));
  } 
  
  //if spacebar then acticate the powerup if you have one in the box
  if (key == ' ') {
      if (powerupInStorageBox && beeIsCurrentlyUnderEffectOfPowerUp==false) {
        beeIsCurrentlyUnderEffectOfPowerUp = true;
        powerupInStorageBox = false;
        timePowerUpWasActivated = elapsedTime;
        musicTrack.amp(0); //still playing in the background just at a volume of 0
        underEffectOfPowerUp.loop(); //play the powerup music
        //the variables in the linear model which allows the power-up music to be lessened in volume as the powerup runs out
        m = (0-1) / ( howManySecondsAPowerUpLasts - 0 ) ;
        x = elapsedTime - timePowerUpWasActivated;
        b = 0 - m*howManySecondsAPowerUpLasts;
      }
  } 
  
  //cheat code: instantly get the effect of a powerup even if you dont have one in storage
  if (keyCode == DOWN) {
    if (beeIsCurrentlyUnderEffectOfPowerUp==false) {
        beeIsCurrentlyUnderEffectOfPowerUp = true;
        powerupInStorageBox = false;
        timePowerUpWasActivated = elapsedTime;
        musicTrack.amp(0); //still playing in the background just at a volume of 0
        underEffectOfPowerUp.loop(); //play the powerup music
        //the variables in the linear model which allows the power-up music to be lessened in volume as the powerup runs out
        m = (0-1) / ( howManySecondsAPowerUpLasts - 0 ) ;
        x = elapsedTime - timePowerUpWasActivated;
        b = 0 - m*howManySecondsAPowerUpLasts;
      }
    
  } 
    
  //pausing the game
  if (key == 'p') {
    //when user presses p, flip state of this boolean
    gameIsPaused = !gameIsPaused;
    
    if (gameIsPaused) {
      myTimer.pause();
      textSize(50);
      text("PAUSED", width/2 - 85, height/2 - 20);
      textSize(defaultTextSize);
    } else {
      myTimer.resume();
    }
  }
    
}
