// Bird & Flock Initialization
Flock flock1;
//Flock flock2;
Boolean paused;
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



void setup() {
  frameRate(60);
  size(500, 500);
  background(0);
  flock1 = new Flock();
  paused = false;
  birdNestX = width/2;
  birdNestY = height/4;
  
  // NOTE: at 5 birds, performance issues don't show up until greater than 15 bees; at 15 Birds, 9 bees makes game unplayable
  numBirds = 10;
  
  d = color(#CC6666);
  c = color(#66CCCC);
  
  // Bees setup
  courier = createFont("Trebuchet MS", 20);
  textFont(courier);
  
  //Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, 
  //float _rx, float _ry, float _ks, float _kd)
  queenBee = new Bee(250,250,0,0,0,0,beeRadius,1,250,250,ks,kd);
  beeSpawnNest = new BeeSpawns(beeRadius,250,250);
  
  myTimer = new Timer(true);
  delay(1500);
  
}

void draw() {
  background(255);
  if (paused == false) {
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
   fill(255,60,60);
   text("Time: " + str(int(myTimer.getElapsedTime()/1000)), 20, 40);
   text("Number of Bees: " + str(queenBee.getNumberOfChildren()),300,40);
   text("Frame Rate: " + str(frameRate), 20, 480);
    
  }
  //flock2.runSimulation();
  //saveFrame();
  //print(flock1.getSize(), "\n");
  
  
}

void checkIfItIstimeToSpawnABee() {
  if (framesPassedSinceBeeSpawn == framesBeforeABeeSpawnAppears) {
     beeSpawn = beeSpawnNest.generateRandomBee(beeRadius);
     beeSpawnList.add(beeSpawn);
     framesPassedSinceBeeSpawn = 0;
     framesBeforeABeeSpawnAppears = int(random(lowerBoundForHowManyFramesABeeTakesToAppear,upperBoundForHowManyFramesABeeTakesToAppear));
   }
}

void checkCollisionsWithWall() {
  
  //if the queen bee hit a wall then game over
  if (queenBee.x > width-10 || queenBee.x < 10 || queenBee.y > height-10 || queenBee.y < 10) {
    background(0);
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


void keyPressed() {
  if (key == 'j') {
    paused ^= true;
  }
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
    
    
  }
}
