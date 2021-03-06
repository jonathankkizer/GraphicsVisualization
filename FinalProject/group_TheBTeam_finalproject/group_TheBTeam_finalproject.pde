//mainpage global
processing.data.Table table;
//Mainpage main;
PImage beeicon;
PImage sound;
boolean soundIsOn = true;
int frameCountThatALevelWasClicked;
int frameTheSoundWasTurnedOn;
ArrayList<Float> level1Score = new ArrayList<Float>();
ArrayList<Float> level2Score = new ArrayList<Float>();
ArrayList<Float> bossScore = new ArrayList<Float>();

int[] level1ScoreArray;
int[] level2ScoreArray;
int[] bossScoreArray;

float level1HighScore;
float level2HighScore;
float bossHighScore;


//ArrayList<BeeSpawns> beeSpawnList = new ArrayList<BeeSpawns>();

Mainpage main;
// Sound Import
import processing.sound.*;
SoundFile intro, birdStrike, win, musicTrack, gameOver, collectBee, underEffectOfPowerUp, collectPowerUp, electricShock, explosion;

//background pictue
PImage backgroundPicture;


// Bird & Flock Initialization
Flock flock1;
FloatList birdPos;
int birdNestX, birdNestY, numBirds;
float val = 0;

//Bee Initialization
//The smooth motion of particles is caused by modeling the bees as particles which are attached to a spring

Bee queenBee; //the bee in the front, she is special and distinct from the "child" bees 
boolean beesFacingRight = true;

//Controls for Customizing Feel of the Game
float ks = 0.1; //spring stiffness value
float kd = 0.3; //spring damping coefficient
int beeRadius = 35; //changes radius of bees and beeSpawns
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
int onAverageAPowerUpAppearsAfterThisManySecondsHasPassed = 5;
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

//level control
boolean onMainMenu = true;
boolean onLevel1 = false;
boolean onLevel2 = false;
boolean onBoss = false;
boolean level1WasJustCompleted = false;
boolean level2WasJustCompleted = false;
float timeLevel1WasCompleted;
float timeLevel2WasCompleted;

//leevl 2: missle stuff
Missle myMissle;
PImage missleImage;
PImage missleAlertImage;

int missleWidth = 200;
int missleHeight = 75;
float howManySecondsTheMissleLasts = 60;

float onAverageAMissleAppearsAfterThisManySecondsHasPassed = 0.1;
float highScore;
FloatList highScores = new FloatList(); 
Table highScoreTable;


void setup() {
  //mainpage setup 
  sound=loadImage("sound.png");
  sound.resize(50,50);
  beeicon=loadImage("bee.png");
  beeicon.resize(300,300);
  main = new Mainpage();
  table = loadTable("highscores.csv","header");
  //these are already set up as globals - no need to do anything with them here
  //ArrayList<float> level1Score;
  //ArrayList<float> level2Score;
  //ArrayList<float> BossScore;
  for (TableRow row: table.rows()){
    float level1 = row.getFloat("level1");
    level1Score.add(level1);
    float level2=row.getFloat("level2");
    level2Score.add(level2);
    float boss=row.getFloat("boss");
    bossScore.add(boss);
  }
  
  //make the arrayLists into arrays - creation
  level1ScoreArray = new int[level1Score.size()];
  level2ScoreArray = new int[level2Score.size()];
  bossScoreArray = new int[bossScore.size()];
  
  //make the arrayLists into arrays - filling in the values
  for(int i = 0; i<level1ScoreArray.length;i++) {
    level1ScoreArray[i] = int(level1Score.get(i)*10000);
  }
  for(int i = 0; i<level2ScoreArray.length;i++) {
    level2ScoreArray[i] = int(level2Score.get(i)*10000);
  }
  for(int i = 0; i<bossScoreArray.length;i++) {
    bossScoreArray[i] = int(bossScore.get(i)*10000);
  }
  level1HighScore= ( min(level1ScoreArray)/10000.0     );
  level2HighScore = (min(level2ScoreArray)/10000.0);
  bossHighScore = ( min(bossScoreArray)/10000.0  );
  println(level1HighScore,level2HighScore,bossHighScore);
 
  
  //alexis - get min of times here once u make the arrayLists arrays
  
  //float a=min(level1Score)
  //println(a);
    //println(min(level2Score));
    //println(min(bossScore));
  
  
 /* for (TableRow row: table.rows()){
    float level1 = row.getFloat("level1");
    float level2=row.getFloat("level2");
    float boss=row.getFloat("boss");
    println(level1,level2,boss);
  }*/
  //highScoreTable = loadTable("highscores.csv", "header");
  
  /*for (TableRow row : highScoreTable.rows()) {
    float highScore = row.getFloat("highscore");
    highScores.append(highScore);}*/
  
  
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
  electricShock.amp(1);
  //explosion for missle - source: https://freesound.org/people/tommccann/sounds/235968/
  explosion = new SoundFile(this, "explosion.wav");
  

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
   
  missleImage = loadImage("missle.png"); //source: http://canacopegdl.com/single.php?id=http://moziru.com/images/missile-clipart-12.png
  missleAlertImage = loadImage("missleWarning.png"); //source: https://www.iconsdb.com/red-icons/warning-3-icon.html
  //level 2 missle stuff
  myMissle = new Missle(missleImage, missleAlertImage, missleWidth, missleHeight, howManySecondsTheMissleLasts);
  
  delay(howLongGameIsDelayedBeforeStarting); //the game doesnt start immediately, but rater waits this many milliseconds
  
  timeSetUpCompleted = millis();
  
}

float currentScore;

void draw() {
  
  
  currentScore = (myTimer.getElapsedTime() - timeSetUpCompleted)/1000;
  //println(soundIsOn);
  if(onMainMenu) {
    main.display();
    main.update(mouseX,mouseY);
    if(soundIsOn) {
      if (frameCount == 1 || frameCount == frameTheSoundWasTurnedOn + 1) {
        musicTrack.loop();
      }
    } else {
      musicTrack.stop();
    }
    
  } else {
    if (onLevel1) {
      drawLoopForLevel1();
    } else {
    
      if (onLevel2) {
        drawLoopForLevel2();
      }
      else if (onBoss){
        drawLoopForBoss();
      }
      else {
        println("on neither level for some reason - you shouldnt ever see this");
      }
    }
  }
}



void mainmenu(){
 main.display();
 
}

void drawLoopForLevel1() {
  
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
  
  /*
  if (frameCount == 1 + frameCountThatALevelWasClicked ) {
    if(soundIsOn) {
    musicTrack.loop();
    }
  }
  */
 
  
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
  if(beeIsCurrentlyUnderEffectOfPowerUp == false && frameCount > numberOfFramesBeforeBirdsStartDoingDamage + 60) {
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
  //text("Best Time: " + str(highScores.min()), 280*(width/500.0) + (width-500.0)/5.0 , 67.5*(height/500.0));
  //text("Frame Rate: " + str(frameRate), 10, 60);
  //flock2.runSimulation();
  //saveFrame();
  //print(flock1.getSize(), "\n");
  
  //show the bee sprite
  determineNextImageToShowAndShowIt(arrayOfBeeFrameImages);
  
  //show the bee-themed picture frame for the powerup to be in
  image(beeThemedPictureFrame,180*(width/500.0) + (width-500)/4.0 - ( (powerUpimageWidth+powerUpimageHeight)/2.0 - 30)*1.5 ,10*(height/500.0)+(height-500)/10.0);
  
  
  
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
  
  //check to see if you should turn the bees around
  if(mouseX - 5 > pmouseX) {
     beesFacingRight = true;
  }
  
  if (mouseX + 5 < pmouseX) {
    beesFacingRight = false;
  }
  
  //check win condition
  checkNumberOfBees();
  
 
  
  //saveFrame();
}

color levelTwoColor = color(#B33A3A);

void drawLoopForLevel2() {
  
  
   elapsedTime = (myTimer.getElapsedTime() - timeSetUpCompleted - 1000*timeLevel1WasCompleted)/1000;
  

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
  
  /*
  if (frameCount == 1 + frameCountThatALevelWasClicked) {
    musicTrack.stop();
    musicTrack.loop();
    
  }
  */
  
  flock1.updateColor(levelTwoColor);
  if (frameCount >= numberOfFramesBeforeBirdsStartDoingDamage) {
    flock1.updateMaxSpeed(6);
    flock1.updateBirdVelocity(2);
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
  if(beeIsCurrentlyUnderEffectOfPowerUp == false && frameCount > numberOfFramesBeforeBirdsStartDoingDamage + 60) {
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
  //text("Best Time: " + str(highScores.min()), 280*(width/500.0) + (width-500.0)/5.0 , 67.5*(height/500.0));
  //text("Frame Rate: " + str(frameRate), 10, 60);
  //flock2.runSimulation();
  //saveFrame();
  //print(flock1.getSize(), "\n");
  
  //show the bee sprite
  determineNextImageToShowAndShowIt(arrayOfBeeFrameImages);
  
  //show the bee-themed picture frame for the powerup to be in
  image(beeThemedPictureFrame,180*(width/500.0) + (width-500)/4.0 - ( (powerUpimageWidth+powerUpimageHeight)/2.0 - 30)*1.5 ,10*(height/500.0)+(height-500)/10.0);
  
  
  
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
  
  //check to see if you should turn the bees around
  if(mouseX - 5 > pmouseX) {
     beesFacingRight = true;
  }
  
  if (mouseX + 5 < pmouseX) {
    beesFacingRight = false;
  }
  
 
  
  if( myMissle.missleCurrentlyUnderway) {
    
      myMissle.move();
      myMissle.display();
      
      if (beeIsCurrentlyUnderEffectOfPowerUp == false) {
        checkBeeAndMissleCollision();
      }
    
  } else {
    
    rngToDetermineIfAMissleWillBeLaunchedThisFrame();
  }
  

 
  //check win condition
  checkNumberOfBees();
  
 
  //saveFrame();
}



boolean bossHasStarted = false;
Bee bee1;

float randomGap = 100 + (int)(Math.random() * (height-200));
Line line1 = new Line(800,(height /2));
boolean startingLineDone = false;

float timeYouTookToClickTheCircle;


void drawLoopForBoss() {  
  //to cycle between day and night we use a sine functions. numbers selected to best show day and night modes
  //tint(50,50,139); //night mode
  //tint(255,255,255); //day mode
  //elapsedTime = (myTimer.getElapsedTime() - timeSetUpCompleted)/1000;
  elapsedTime = (myTimer.getElapsedTime() - timeSetUpCompleted - 1000*timeLevel1WasCompleted - 1000*timeLevel2WasCompleted -1000*timeYouTookToClickTheCircle)/1000.0;
  //println(1000*timeLevel1WasCompleted);
  //println(1000*timeLevel2WasCompleted);
  
  
  int redTintValue = int(102.5*sin(elapsedTime*(2*PI)/numberOfSecondsInAFullDay) + 152.5) ;
  int greenTintValue = int(102.5*sin(elapsedTime*(2*PI)/numberOfSecondsInAFullDay) + 152.5) ;
  int blueTintValue = int(58*sin(elapsedTime*(2*PI)/numberOfSecondsInAFullDay) + 197) ;
  tint(redTintValue,greenTintValue,blueTintValue);
  image(backgroundPicture,0,0);
  noTint();
  image(electricFenceBorder,0,0);
  /*
  if (frameCount == 1 + frameCountThatALevelWasClicked) {
    musicTrack.stop();
    musicTrack.loop();
  }
  */
  if (bossHasStarted == false){
    fill(0);
    text("Click the yellow circle \nto begin the final level \n then avoid the lines",width/2,height/2);
    fill(255,255,0);
    ellipse(100, height/2,30,30);
  } else{
   //elapsedTime = (myTimer.getElapsedTime() - timeSetUpCompleted)/1000;
  //checkCollisionWithLines();
  //line1.display();
  //line1.move();
  //lineList.add(line1);
  createNewLine();
  for (Line lineSpawn: lineList){
    lineSpawn.display();
    lineSpawn.move();
  }
  //  for(BeeSpawns myBeeSpawn: beeSpawnList) {
  //  myBeeSpawn.display();
  //}
  
  bee1 = new Bee(width - 80,height/2,0,0,0,0,beeRadius,1,0,0,0,0);
  //beeSpawnList.add(new Bee();
  if (gotFinalBee == false){
  bee1.displayBeeAndChildren();
  }
  if (startingLineDone == false){
    Line line1 = new Line(300,100 + (int)(Math.random() * (height-200)));
    Line line2 = new Line(450,100 + (int)(Math.random() * (height-200)));
    Line line3 = new Line(600,100 + (int)(Math.random() * (height-200)));
    Line line4 = new Line(750,100 + (int)(Math.random() * (height-200)));
    //Line line5 = new Line(950,100 + (int)(Math.random() * (height-200)));
    lineList.add(line1);
    lineList.add(line2);
    lineList.add(line3);
    lineList.add(line4);
    //lineList.add(line5);
    startingLineDone = true;
    
  }
  if(beeIsCurrentlyUnderEffectOfPowerUp) {
    queenBee.displayBeeAndChildrenAsInvincible();
  } else {
    queenBee.displayBeeAndChildren();
  }
   if(beeIsCurrentlyUnderEffectOfPowerUp == false) {
    checkCollisionsWithWall();
  }
  
  
   
  // Checks collisions with birds and bees

  fill(255,0,0);
  text("Time: " + str(elapsedTime), 30*(width/500.0), 50*(height/500.0));
  text("Collect " +str(numberOfBeesToWin) + " Bees to win. Avoid birds.", 90*(width/500.0) + (width-500.0)/13.5, 475*(width/500.0));
  text("Number of Bees: " + str(queenBee.getNumberOfChildren()),280*(width/500.0) + (width-500.0)/5.0 , 50*(height/500.0));
  //text("Best Time: " + str(highScores.min()), 280*(width/500.0) + (width-500.0)/5.0 , 67.5*(height/500.0));
  determineNextImageToShowAndShowIt(arrayOfBeeFrameImages);
  
  //show the bee-themed picture frame for the powerup to be in
  image(beeThemedPictureFrame,180*(width/500.0) + (width-500)/4.0 - ( (powerUpimageWidth+powerUpimageHeight)/2.0 - 30)*1.5 ,10*(height/500.0)+(height-500)/10.0);
  
  //See if the queen hit a beespawn, thus adding the bee to the chain
  
  
  //check if its time for a powerup to spawn
  //as long as one is neither on the screen nor in the storage box
  
  
  //move and show the powerup if its on the screen moving
  
 
  if(mouseX - 5 > pmouseX) {
     beesFacingRight = true;
  }
  
  if (mouseX + 5 < pmouseX) {
    beesFacingRight = false;
  }
  framesPassedSinceLineSpawn += 1;
  checkCollisionWitPowerUpAndActAccordingly();
  checkToSeeIfItIstimeForThePowerEffectToDissapear();
  if (beeIsCurrentlyUnderEffectOfPowerUp == false){
  checkCollisionWithLines();
  }
  checkGotFinalBee();
  checkNumberOfBees();
  }
} //closes the draw loop for boss
ArrayList<Line> lineList = new ArrayList<Line>();
int framesPassedSinceLineSpawn = 0;
int framesBeforeALineAppears = 75;
Line lineSpawn;

float lineX;
float gapUpper;
float gapLower;
boolean gotFinalBee = false;
void checkGotFinalBee(){
  if (mouseX <= width - 70 && mouseX >= width - 90){
   if (mouseY >= ((height/2) - 5) && mouseY <= ((height/2) + 5)){
      Bee theLastChild = queenBee.getLastChild();
      gotFinalBee = true;
      //add the new bee to the end of the trail
      if(soundIsOn) {
        collectBee.play();
      }
      theLastChild.attachChildParticle(new Bee(theLastChild.x,theLastChild.y,0,0,0,0,beeRadius,1,250,250,ks,kd));
      
   }
  }
}
void checkCollisionWithLines(){
  for (Line lineSpawn: lineList){
    lineX = lineSpawn.getXpos();
    gapUpper = lineSpawn.getGapUpper();
    gapLower = lineSpawn.getGapLower();
    if (mouseX <= (lineX + 2) && mouseX >= (lineX - 2)){
      if (mouseY >= (gapLower) || mouseY <= (gapUpper)){
      //copying the results from hitting a bird
      background(0);
      musicTrack.stop();
      if(soundIsOn) {
      birdStrike.play();
      gameOver.play();
      }
    
      textSize(defaultTextSize);
      text("The Queen was caught in a trap", width/2 - 130, height/2 - 80);
      textSize(50);
      text("GAME OVER", width/2 - 130, height/2 - 20);
      textSize(defaultTextSize);
      //writeHighScore();
      noLoop();
      if(soundIsOn) {
      birdStrike.play();
      gameOver.play();
      }
      musicTrack.stop();
      }
    }
  }
}
//creates a new line and appends it to the list with a random gap
void createNewLine(){
  randomGap = 200 + (int)(Math.random() * (height-300));
  if (framesPassedSinceLineSpawn == framesBeforeALineAppears) {
     lineSpawn = new Line(800,randomGap);
     lineList.add(lineSpawn);
     framesPassedSinceLineSpawn = 0;
   }

  }
  


color d = color(#B33A3A);
color c = color(#B33A3A);

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
  //println(x);
  //println(y);
  
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
    if (queenBee.x > width- beeRadius/2 || queenBee.x < beeRadius/2 || queenBee.y > height - beeRadius/2 || queenBee.y < beeRadius/2) {
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
        if(soundIsOn) {
        electricShock.play();
        }
      }
      if(soundIsOn) {
      gameOver.play();
      }
      //writeHighScore();
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
  if (childBeeToCheck.x > width - beeRadius/2 || childBeeToCheck.x < beeRadius/2 || childBeeToCheck.y > height - beeRadius/2 || childBeeToCheck.y < beeRadius/2) {
    (childBeeToCheck).parentBee.deleteBeesChildren();
    if(soundIsOn) {
    electricShock.play(); 
    electricShock.play();
    }
    
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
      if(soundIsOn) {
      collectBee.play();
      }
      theLastChild.attachChildParticle(new Bee(theLastChild.x,theLastChild.y,0,0,0,0,beeRadius,1,250,250,ks,kd));
     
    }
  }
}

/*
void writeHighScore() {
  TableRow newRow = highScoreTable.addRow();
  
  newRow.setFloat("highscore", (currentScore));
  saveTable(highScoreTable, "data/highscores.csv");
  println("New Score Saved");
  

*/

// checks whether the queen bee has hit a bird; if yes, kills game; if not, checks children with helper function
void checkBeeBirdCollision() {
  for(int counter = 0; counter < birdPos.size(); counter+=2) {
    if ((birdPos.get(counter) <= (queenBee.x + beeRadius/2 + 10)) && (birdPos.get(counter) >= (queenBee.x - beeRadius/2 - 10))) {
      if ((birdPos.get(counter+1) <= (queenBee.y + beeRadius/2 + 10)) && (birdPos.get(counter+1) >= (queenBee.y - beeRadius/2 - 10))) {
        background(0);
        musicTrack.stop();
        if(soundIsOn) {
        birdStrike.play();
        gameOver.play();
        }
        //text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
        textSize(defaultTextSize);
        text("The queen has died", width/2 - 130, height/2 - 80);
        textSize(50);
        text("GAME OVER", width/2 - 130, height/2 - 20);
        textSize(defaultTextSize);
        //writeHighScore();
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
    if ((birdPos.get(counter) <= (childBeeToCheck.x + beeRadius/2 + 10)) && (birdPos.get(counter) >= (childBeeToCheck.x - beeRadius/2 - 10))) {
      if ((birdPos.get(counter+1) <= (childBeeToCheck.y + beeRadius/2 + 10)) && (birdPos.get(counter+1) >= (childBeeToCheck.y - beeRadius/2 -5))) {
        if(soundIsOn) {
        birdStrike.play();
        }
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

float timeLevel3WasBeaten;

void checkNumberOfBees() {
  
  if (queenBee.getNumberOfChildren() >= numberOfBeesToWin) {
    if (onLevel1) {
       
       textSize(35);
       text(str(numberOfBeesToWin)+ " bees collected: Click to go \nto Level 2!", width/2 - 215, height/2 - 10);
       musicTrack.stop();
       underEffectOfPowerUp.stop();
       if(soundIsOn) {
       win.play();
       }
       queenBee.deleteBeesChildren();
       textSize(defaultTextSize);
       level1WasJustCompleted = true;
       onLevel1 = false;
       onBoss = false;
       onLevel2 = true;
       myTimer.pause();
       beeSpawnList.clear();
       powerupInStorageBox = false;
       powerupOnScreenAlready = false;
       numberOfFramesBeforeBirdsStartDoingDamage = frameCount + 60;
       if (beeIsCurrentlyUnderEffectOfPowerUp) {
         beeIsCurrentlyUnderEffectOfPowerUp = false;
         underEffectOfPowerUp.stop();
         if(soundIsOn) {
         musicTrack.loop();
         }//unknown bug: music doesnt restart on level 2 if the bee ends level 1 on a powerup
       }
       //writeHighScore();
       noLoop();

       
       
    } else{
    
      if (onLevel2) {
       textSize(35);
       text(str(numberOfBeesToWin)+ " bees collected: Click to go \nto Final Level!", width/2 - 215, height/2 - 10);
       musicTrack.stop();
       underEffectOfPowerUp.stop();
       if(soundIsOn) {
       win.play();
       }
       queenBee.deleteBeesChildren();
       textSize(defaultTextSize);
       level2WasJustCompleted = true;
       onLevel1 = false;
       onBoss = true;
       onLevel2 = false;
       myTimer.pause();
       beeSpawnList.clear();
       powerupInStorageBox = false;
       powerupOnScreenAlready = false;
       numberOfFramesBeforeBirdsStartDoingDamage = frameCount + 60;
       if (beeIsCurrentlyUnderEffectOfPowerUp) {
         beeIsCurrentlyUnderEffectOfPowerUp = false;
         underEffectOfPowerUp.stop();
         if(soundIsOn) {
         musicTrack.loop(); 
         }//unknown bug: music doesnt restart on level 2 if the bee ends level 1 on a powerup
       }
       //writeHighScore();
       noLoop();
      }

    }
    
  }
  else if (onBoss && (queenBee.getNumberOfChildren() >= numberOfBeesToWin - 8)) {
         musicTrack.stop();
         textSize(35);
         text("The Final bee has been collected: \nYou win!", width/2 - 215, height/2 - 10);
         musicTrack.stop();
         underEffectOfPowerUp.stop();
         if(soundIsOn) {
         win.play();
         }
         timeLevel3WasBeaten = elapsedTime;  //This is where you get the time that it took the user to beat the boss battle - Alexis
         musicTrack.stop();
         //add to this time to csv
         //load table, change the table values wit setDouble, then save the table
         
         println("time level 3 was beaten", timeLevel3WasBeaten);
         TableRow newRow=table.addRow();
    newRow.setFloat("level1",9999.999);
    newRow.setFloat("level2",9999.999);
    newRow.setFloat("boss",timeLevel3WasBeaten);
    saveTable(table,"highscores.csv");
         //writeHighScore();
         noLoop();
         musicTrack.stop();
        
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
  
  boolean queenBeeCollidedWithPowerUp = checkIfQueenCollidedWithPowerUp();
  

    if (queenBeeCollidedWithPowerUp && powerUpIsNotWithinBox){ 
      //put powerup in storage box
      powerupInStorageBox = true;
      powerupOnScreenAlready = false;
      if(soundIsOn) {
      collectPowerUp.play();
      }
    } 
    //else do nothing
    
}

boolean checkIfQueenCollidedWithPowerUp() {
  return queenBee.x + beeRadius/2 >= myPowerUp.xPosition && queenBee.x - beeRadius/2 <= (myPowerUp.xPosition + myPowerUp.imageWidth) &&
  queenBee.y + beeRadius/2 >= myPowerUp.yPosition && queenBee.y - beeRadius/2 <= (myPowerUp.yPosition + myPowerUp.imageHeight);
  
}

void checkBeeAndMissleCollision() {
  
  if (myMissle.whichWallTheMissleAppearsfrom == 1) {

    boolean queenBeeOverlappingWithMissle = 
    (queenBee.x + beeRadius/2) >= myMissle.x - myMissle.missleHeight && (queenBee.x - beeRadius/2) <= (myMissle.x  ) &&
    (queenBee.y + beeRadius/2) >= myMissle.y  && (queenBee.y - beeRadius/2) <= (myMissle.y + myMissle.missleWidth );
    if (queenBeeOverlappingWithMissle) {
        background(0);
        musicTrack.stop();
        explosion.amp(0.4);
        if(soundIsOn) {
        explosion.play();
        gameOver.play();
        }
        //text("Queen bee diped. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
        textSize(defaultTextSize);
        text("The queen has died", width/2 - 130, height/2 - 80);
        textSize(50);
        text("GAME OVER", width/2 - 130, height/2 - 20);
        textSize(defaultTextSize);
        //writeHighScore();
        noLoop();
    }
    
  }
  
  if (myMissle.whichWallTheMissleAppearsfrom == 2) {
    boolean queenBeeOverlappingWithMissle = 
    (queenBee.x + beeRadius/2) >= myMissle.x -myMissle.missleWidth && (queenBee.x - beeRadius/2) <= (myMissle.x) &&
    (queenBee.y + beeRadius/2) >= myMissle.y && (queenBee.y - beeRadius/2) <= (myMissle.y + myMissle.missleHeight );
    if (queenBeeOverlappingWithMissle) {
        background(0);
        musicTrack.stop();
        explosion.amp(0.4);
        if(soundIsOn) {
        explosion.play();
        gameOver.play();
        }
        //text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
        textSize(defaultTextSize);
        text("The queen has died", width/2 - 130, height/2 - 80);
        textSize(50);
        text("GAME OVER", width/2 - 130, height/2 - 20);
        textSize(defaultTextSize);
        //writeHighScore();
        noLoop();
    }
    
  }
  
  if (myMissle.whichWallTheMissleAppearsfrom == 3) {
    
    //println("bee",queenBee.x - beeRadius/2);
    //println("missle",myMissle.x + myMissle.missleHeight);
    
    boolean queenBeeOverlappingWithMissle = 
    (queenBee.x + beeRadius/2) >= myMissle.x  && (queenBee.x - beeRadius/2) <= (myMissle.x + myMissle.missleHeight  ) &&
    (queenBee.y + beeRadius/2) >= myMissle.y - myMissle.missleWidth  && (queenBee.y - beeRadius/2) <= (myMissle.y  );
    if (queenBeeOverlappingWithMissle) {
        background(0);
        musicTrack.stop();
        explosion.amp(0.4);
        if(soundIsOn) {
        explosion.play();
        gameOver.play();
        }
        //text("Queen bee diped. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
        textSize(defaultTextSize);
        text("The queen has died", width/2 - 130, height/2 - 80);
        textSize(50);
        text("GAME OVER", width/2 - 130, height/2 - 20);
        textSize(defaultTextSize);
        //writeHighScore();
        noLoop();
    }
    
  }
  
  if (myMissle.whichWallTheMissleAppearsfrom == 4) {
    boolean queenBeeOverlappingWithMissle = 
    (queenBee.x + beeRadius/2) >= myMissle.x && (queenBee.x - beeRadius/2) <= (myMissle.x +myMissle.missleWidth) &&
    (queenBee.y + beeRadius/2) >= myMissle.y && (queenBee.y - beeRadius/2) <= (myMissle.y +myMissle.missleHeight);
    if (queenBeeOverlappingWithMissle) {
        background(0);
        musicTrack.stop();
        explosion.amp(0.4);
        if(soundIsOn) {
        explosion.play();
        gameOver.play();
        }
        //text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
        textSize(defaultTextSize);
        text("The queen has died", width/2 - 130, height/2 - 80);
        textSize(50);
        text("GAME OVER", width/2 - 130, height/2 - 20);
        textSize(defaultTextSize);
        //writeHighScore();
        noLoop();
    }
  }
  
  
  //now check children missle collisons
  if(queenBee.childBee != null) {
    checkChildrenBeeMissleCollision(queenBee.childBee);
  }
  
  
  
}

void checkChildrenBeeMissleCollision(Bee childBeeToCheck) {
  
  if (myMissle.whichWallTheMissleAppearsfrom == 1) {

    boolean childBeeToCheckOverlappingWithMissle = 
    (childBeeToCheck.x + beeRadius/2) >= myMissle.x - myMissle.missleHeight && (childBeeToCheck.x - beeRadius/2) <= (myMissle.x  ) &&
    (childBeeToCheck.y + beeRadius/2) >= myMissle.y  && (childBeeToCheck.y - beeRadius/2) <= (myMissle.y + myMissle.missleWidth );
    if (childBeeToCheckOverlappingWithMissle) {
        
        explosion.amp(0.2);
        if(soundIsOn) {
        explosion.play();
        }
        (childBeeToCheck).parentBee.deleteBeesChildren();

    }
    
  }
  
  if (myMissle.whichWallTheMissleAppearsfrom == 2) {
    boolean childBeeToCheckOverlappingWithMissle = 
    (childBeeToCheck.x + beeRadius/2) >= myMissle.x -myMissle.missleWidth && (childBeeToCheck.x - beeRadius/2) <= (myMissle.x) &&
    (childBeeToCheck.y + beeRadius/2) >= myMissle.y && (childBeeToCheck.y - beeRadius/2) <= (myMissle.y + myMissle.missleHeight );
    if (childBeeToCheckOverlappingWithMissle) {
        
        explosion.amp(0.2);
        if(soundIsOn) {
        explosion.play();
        }
        (childBeeToCheck).parentBee.deleteBeesChildren();

    }
    
  }
  
  if (myMissle.whichWallTheMissleAppearsfrom == 3) {
    
    //println("bee",childBeeToCheck.x - beeRadius/2);
    //println("missle",myMissle.x + myMissle.missleHeight);
    
    boolean childBeeToCheckOverlappingWithMissle = 
    (childBeeToCheck.x + beeRadius/2) >= myMissle.x  && (childBeeToCheck.x - beeRadius/2) <= (myMissle.x + myMissle.missleHeight  ) &&
    (childBeeToCheck.y + beeRadius/2) >= myMissle.y - myMissle.missleWidth  && (childBeeToCheck.y - beeRadius/2) <= (myMissle.y  );
    if (childBeeToCheckOverlappingWithMissle) {
        
        explosion.amp(0.2);
        if(soundIsOn) {
        explosion.play();
        }
        (childBeeToCheck).parentBee.deleteBeesChildren();
  
    }
    
  }
  
  if (myMissle.whichWallTheMissleAppearsfrom == 4) {
    boolean childBeeToCheckOverlappingWithMissle = 
    (childBeeToCheck.x + beeRadius/2) >= myMissle.x && (childBeeToCheck.x - beeRadius/2) <= (myMissle.x +myMissle.missleWidth) &&
    (childBeeToCheck.y + beeRadius/2) >= myMissle.y && (childBeeToCheck.y - beeRadius/2) <= (myMissle.y +myMissle.missleHeight);
    if (childBeeToCheckOverlappingWithMissle) {
        
        explosion.amp(0.2);
        if(soundIsOn) {
        explosion.play();
        }
        (childBeeToCheck).parentBee.deleteBeesChildren();
  
    }
  }
  if (childBeeToCheck.childBee != null) {
      checkChildrenBeeMissleCollision(childBeeToCheck.childBee);
    }
  
}


void rngToDetermineIfAMissleWillBeLaunchedThisFrame() {
  
  int randomIntToDetermindIfMissleIsLaunched = int(random(1,onAverageAMissleAppearsAfterThisManySecondsHasPassed*frameRate)) + 5;

  if (randomIntToDetermindIfMissleIsLaunched == int(onAverageAMissleAppearsAfterThisManySecondsHasPassed*frameRate)) {
    
    myMissle.shoot();
    
  }
}

void mouseClicked() {
  
  //check if we are on main menu so we can go to levels

  if(onMainMenu) {
    /*
    if(main.isMouseOverSound){
      soundIsOn = !soundIsOn;
    }
    */
    
    if(main.isMouseOverSound){
     if(soundIsOn) {
       soundIsOn = false;
     } else {
       soundIsOn = true;
       frameTheSoundWasTurnedOn = frameCount;
     }
    }
    
    if(main.isMouseOverPhase1) {
      delay(500);
      onMainMenu = false;
      timeSetUpCompleted = int(myTimer.getElapsedTime());
      frameCountThatALevelWasClicked = frameCount;
      onLevel1 = true;
    }
    
    if(main.isMouseOverPhase2) {
      delay(500);
      onMainMenu = false;
      timeSetUpCompleted = int(myTimer.getElapsedTime());
      frameCountThatALevelWasClicked = frameCount;
      onLevel2 = true;
    }
    
    if(main.isMouseOverBoss) {
      delay(500);
      onMainMenu = false;
      timeSetUpCompleted = int(myTimer.getElapsedTime());
      frameCountThatALevelWasClicked = frameCount;
      onBoss = true;
    }
    
  }
  if(level1WasJustCompleted) {
    timeLevel1WasCompleted = elapsedTime; //this is the time it took user to beat level 1 - Alexis
    println("level 1 time",timeLevel1WasCompleted);
    TableRow newRow=table.addRow();
    newRow.setFloat("level1",timeLevel1WasCompleted);
    newRow.setFloat("level2",9999.999);
    newRow.setFloat("boss",9999.999);
    saveTable(table,"highscores.csv");
    
    
    
    myTimer.resume();
    //underEffectOfPowerUp.stop();
    level1WasJustCompleted = false;
    if(soundIsOn) {
    musicTrack.loop();
    }
    delay(10);
    if(soundIsOn) {
    musicTrack.loop();
    }
    loop();
    
  }
  if(level2WasJustCompleted) {
    
    timeLevel2WasCompleted = elapsedTime; //this is the time it took user to beat level 2 - Alexis
    println("level 2 time",timeLevel2WasCompleted);
    TableRow newRow=table.addRow();
    newRow.setFloat("level1",9999.999);
    newRow.setFloat("level2",timeLevel2WasCompleted);
    newRow.setFloat("boss",9999.999);
    saveTable(table,"highscores.csv");
    myTimer.resume();
    //underEffectOfPowerUp.stop();
    level2WasJustCompleted = false;
    if(soundIsOn) {
    musicTrack.loop();
    }
    delay(10);
    if(soundIsOn) {
    musicTrack.loop();
    }
    loop();
  }

}

void mousePressed(){
   if(onBoss==true && bossHasStarted ==false){
    if((mouseX >= 70) && (mouseX <= 130)) {
      if(mouseY >= ((height/2)-30) && (mouseY <= ((height/2)+30)))
        bossHasStarted = true;
        timeYouTookToClickTheCircle = elapsedTime;
        
        
        
    }
  } 
  
}


void keyPressed() {
  if(!onMainMenu) {
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
          if(soundIsOn) {
          
          underEffectOfPowerUp.loop();
          }//play the powerup music
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
          if(soundIsOn) {
          underEffectOfPowerUp.loop(); 
          }//play the powerup music
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
    
}
