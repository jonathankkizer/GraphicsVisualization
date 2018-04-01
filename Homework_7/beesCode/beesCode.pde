//The smooth motion of particles is caused by modeling the bees as particles which are attached to a spring

Bee queenBee; //the bee in the front, she is special and distinct from the "child" bees 
float ks = 0.1; //spring stiffness value
float kd = 0.3; //spring damping coefficient
int beeRadius = 50; //changes radius of bees and beeSpawns

BeeSpawns beeSpawnNest; //used to call the beeSpawns since processing doesnt seem to let me have statics
int framesBeforeABeeSpawnAppears = int(random(60,300)); //a bee will randomly spawn on screen every x-y frames seconds
int framesPassedSinceBeeSpawn = 0; //a counter used in determining when to spawn a new bee on screen
BeeSpawns beeSpawn; //a bee to spawn
ArrayList<BeeSpawns> beeSpawnList = new ArrayList<BeeSpawns>(); //list of spawnes bees

void setup() {
  size(500,500); //feel free to change this, code is modular to these arguments
  frameRate(60); 
  
  //Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, 
  //float _rx, float _ry, float _ks, float _kd)
  queenBee = new Bee(250,250,0,0,0,0,beeRadius,1,250,250,ks,kd);
  beeSpawnNest = new BeeSpawns(beeRadius,250,250);
}

void draw() {
   background(0,255,255);

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
}

void checkIfItIstimeToSpawnABee() {
  if (framesPassedSinceBeeSpawn == framesBeforeABeeSpawnAppears) {
     beeSpawn = beeSpawnNest.generateRandomBee(beeRadius);
     beeSpawnList.add(beeSpawn);
     framesPassedSinceBeeSpawn = 0;
     framesBeforeABeeSpawnAppears = int(random(60,300));
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

//cheat code - press up to instantly get another bee
void keyPressed() {
  if (keyCode == UP) {
    Bee theLastChild = queenBee.getLastChild();
    theLastChild.attachChildParticle(new Bee(theLastChild.x,theLastChild.y,0,0,0,0,beeRadius,1,250,250,ks,kd));
  }
}