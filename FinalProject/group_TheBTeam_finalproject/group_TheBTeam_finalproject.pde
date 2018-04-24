// Sound Import
import processing.sound.*;
SoundFile intro, birdStrike, win, musicTrack, gameOver, collectBee;

// Bird & Flock Initialization
Flock flock1;
//Flock flock2;
FloatList birdPos;
color c, d;
int birdNestX, birdNestY, numBirds;

//Bee Initialization
//The smooth motion of particles is caused by modeling the bees as particles which are attached to a spring

Bee queenBee; //the bee in the front, she is special and distinct from the "child" bees 

//Controls for Customizing Feel of the Game
float ks = 0.1; //spring stiffness value
float kd = 0.3; //spring damping coefficient
int beeRadius = 20; //changes radius of bees and beeSpawns
//a bee will randomly spawn on screen every x-y frames, where x and y are the lower and upper bound
int lowerBoundForHowManyFramesABeeTakesToAppear = 30;
int upperBoundForHowManyFramesABeeTakesToAppear = 150;


//a bee will randomly spawn on screen every x-y frames
int framesBeforeABeeSpawnAppears = int(random(lowerBoundForHowManyFramesABeeTakesToAppear,upperBoundForHowManyFramesABeeTakesToAppear)); 
BeeSpawns beeSpawnNest; //used to call the beeSpawns since processing doesnt seem to let me have statics
int framesPassedSinceBeeSpawn = 0; //a counter used in determining when to spawn a new bee on screen
BeeSpawns beeSpawn; //a bee to spawn
ArrayList<BeeSpawns> beeSpawnList = new ArrayList<BeeSpawns>(); //list of spawnes bees


Timer myTimer;
boolean gameIsPaused = false;
PFont courier;

//
//Bee sprite animation stuff - this is just the random animated sprite in the upper right corner
float animationTimerBee = 0.0; //value you pick based on how much time has ellapsed
float animationTimerValueBee = 0.25; //take 0.25 seconds to change to bees next image frame
int currentFrameBee = 0; //start out on the 1's frame
int numFramesBee = 3; //number of frames your animation has, three for bee

PImage arrayOfBeeFrameImages [] = new PImage[numFramesBee];
String fileNameToLoadBee;


//End bee sprite animation stuff

//the user can change the background color with 1-4 so this is just the initial color
int backgroundInt = 255;

void setup() {
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
  intro.play();
  

  //frameRate(60);
  size(500, 500);
  background(0);
  flock1 = new Flock();
  birdNestX = width/2;
  birdNestY = height/2;
  
  // NOTE: at 5 birds, performance issues don't show up until greater than 15 bees; at 15 Birds, 9 bees makes game unplayable
  numBirds = 5;
  
  d = color(#CC6666);
  c = color(#66CCCC);
  
  // Bees setup
  courier = createFont("Trebuchet MS", 20);
  textFont(courier);
  
  //Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, 
  //float _rx, float _ry, float _ks, float _kd)
  queenBee = new Bee(250,250,0,0,0,0,beeRadius,1,mouseX,mouseY,ks,kd);
  beeSpawnNest = new BeeSpawns(beeRadius,250,250, "yellow");
  queenBee = new Bee(width/2,height/2,0,0,0,0,beeRadius,1,mouseX,mouseY,ks,kd);
  beeSpawnNest = new BeeSpawns(beeRadius,250,250, "yellow");
  
  myTimer = new Timer(true);
  
  
  //populates the array of bee image frames
   for(int i=0;i<numFramesBee;i++) {
     fileNameToLoadBee= "bee" + str(i+1) + ".jpg";
     arrayOfBeeFrameImages[i] = loadImage(fileNameToLoadBee);
   }
  
  delay(1500); //the game doesnt start immediately, but rater waits this many milliseconds
  
}

void draw() {
  if (frameCount == 1) {
    musicTrack.loop();
  }
  background(backgroundInt);
  

  flock1.runSimulation();
    
  // updates the FloatList showing current X,Y coordinates
  birdPos = flock1.updatePosition();
    
  // prints current position from FloatList
  //flock1.printPosition();
    
  // removes birds that have flown beyond the screen
  flock1.cullFlock();
    
  // adds birds if the total number falls below numBirds
  if (flock1.getSize() < numBirds) {
    flock1.addBird(new Bird(birdNestX, birdNestY, c, 40/*, flock2*/));
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
  checkCollisionsWithWall();
   
  //the bee class is more or less a linked list, displaying the queenbee displays the children too
  queenBee.displayBeeAndChildren();
   
  //counter
  framesPassedSinceBeeSpawn += 1;
   
  // Checks collisions with birds and bees
  checkBeeBirdCollision();
   
  //showing how much in game time has ellapsed,
  //this is paused when the game is paused with "p"
  //also showing number of bees and objective
  fill(255,60,60);
  text("Time: " + str(int(myTimer.getElapsedTime()/1000)), 10, 30);
  text("Collect 8 Bees to win. Avoid birds.", 90, 480);
  text("Number of Bees: " + str(queenBee.getNumberOfChildren()),280,30);
  //text("Frame Rate: " + str(frameRate), 10, 60);
  //flock2.runSimulation();
  //saveFrame();
  //print(flock1.getSize(), "\n");
  
  //check win condition
  checkNumberOfBees();
  
  //show the bee sprite
  determineNextImageToShowAndShowIt(arrayOfBeeFrameImages);
  
  //saveFrame();
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
    text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
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
        text("Queen bee died. GAME OVER.\nHit play in Processing to try again.\nLosing instantly? Don't start your\nmouse in the center.", width/2 - 130, height/2 - 30);
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
  
  if (queenBee.getNumberOfChildren() > 7) {
     text("8 bees collected: You win!", width/2 - 130, height/2 - 30);
     musicTrack.stop();
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
  image(arrayOfImageFrames[currentFrameBee], 460, 0);
}


void keyPressed() {
  //cheat code - press up to instantly get another bee
  if (keyCode == UP) {
    Bee theLastChild = queenBee.getLastChild();
    theLastChild.attachChildParticle(new Bee(theLastChild.x,theLastChild.y,0,0,0,0,beeRadius,1,250,250,ks,kd));
  } else {
    
    //pausing the game
    if (key == 'p') {
      //when user presses p, flip state of this boolean
      gameIsPaused = !gameIsPaused;
      
      if (gameIsPaused) {
        myTimer.pause();
        text("PAUSED", width/2 - 30, height/2 - 30);
      } else {
        myTimer.resume();
      }
    }
    
    if (key == '1') {
      backgroundInt = 255;
    }
    
    if (key == '2') {
      backgroundInt = 225;
    }
    
    if (key == '3') {
      backgroundInt = 195;
    }
    
    if (key == '4') {
      backgroundInt = 165;
    }
    
    
  } 
    
}
