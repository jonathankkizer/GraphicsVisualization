// setup for sound library
// HAVE TO IMPORT SOUND LIBRARY AS WELL
import processing.sound.*;
SoundFile file;
String audioName = "wind_1234-mike-koenig.mp3";
String path;

// Person declarations


// Dog declarations
Dog dog1;
Dog dog2;
float origx1;
float origy1;
float origx2;
float origy2;

// Tree declarations
Tree tree1, tree2, tree3;
//Tree-related globals
PVector v1, v2, v3, v4, treecreep1, treecreep2, treetopDrop;

//Person-related globals
Person myPerson1;
Person myPerson2;
float theta = 0.0000000;
float thetaSpeed = 0.1000000;

void setup() {
  size(500, 500);
  
  myPerson1 = new Person();
  myPerson2 = new Person();
  
  // Dog-related variables/setup
  size(500,500);
  dog1 = new Dog(10,350,100,10,color(100));
  dog2 = new Dog(0,0,150,1,color(0));
  origx1=dog1.x;
  origy1=dog1.y;
  origx2=dog2.x;
  origy2=dog2.y;
  
  // Tree-related variables/setup
  v1 = new PVector(.1, .1);
  v2 = new PVector(.5, .5);
  v3 = new PVector(.05, .05);
  v4 = new PVector(.08, .08);
  treecreep1 = new PVector(.05, .05);
  treecreep2 = new PVector(1, 1);
  treetopDrop = new PVector(15, 15);
  tree1 = new Tree(450, 400, 80, 20, 80, 70, v1);
  tree2 = new Tree(25, 400, 110, 25, 110, 105, v2);
  tree3 = new Tree(110, 400, 50, 5, 70, 55, v3);
  
  // Sound setup
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
}

void draw() {
  // scene setup
  clear();
  background(152, 235, 235);
  fill(83, 53, 10);
  rect(0, 400, width, height);
  
  //
  // Person draw calls
  //
  
  //Person 1
  
  //moving the arms
  myPerson1.leftShoulderGroup.translate(0.1000000*cos(theta),0.1000000*sin(theta));
  myPerson1.rightShoulderGroup.translate(0.1000000*cos(theta),0.1000000*sin(theta));
  //moving the legs
  myPerson1.hipsGroup.translate(0.1000000*cos(theta),0.1000000*sin(theta));
  //moving the person
  myPerson1.entireBody.translate(0.5000000*cos(theta),0.5000000*sin(theta));
  //translating
  myPerson1.entireBody.translate(0.250000,0);
  //drawing the entire person
  myPerson1.torso.setFill(color(255,0,255));
  shape(myPerson1.entireBody,0,-100);
  
  //Person 2
  
  //moving the arms
  myPerson2.leftShoulderGroup.translate(0.3000000*cos(theta),0.3000000*sin(theta));
  myPerson2.rightShoulderGroup.translate(0.3000000*cos(theta),0.3000000*sin(theta));
  //moving the legs
  myPerson2.hipsGroup.translate(0.1000000*cos(theta),0.1000000*sin(theta));
  //moving the person
  myPerson2.entireBody.translate(0.5000000*cos(theta),0.5000000*sin(theta));
  //translating
  myPerson2.entireBody.translate(0.50000,0);
  //drawing the entire person
  myPerson2.torso.setFill(color(255,255,0));
  shape(myPerson2.entireBody,-200,-100);
  
  
  
  //changing theta1
  if (theta >= 2.000000*PI - 0.10000) {
    theta = 0.000000;
  }
  else {
    theta += thetaSpeed;
  }
  
    
  // tree draw calls
  tree1.display();
  tree2.display();
  tree3.display();
  tree1.treeTimeLapse();
  tree2.treeTimeLapse();
  tree3.treeTimeLapse();
  tree1.dropLeaves(treetopDrop);
  tree3.dropLeaves(treetopDrop);
  tree2.treeCreep(treecreep1, "right");
  
  // Dog draw calls
  
   dog1.display();
   dog2.display();
   if (dog1.x> width){
     dog1.x = origx1;
   dog1.y=origy1;}
   if (dog2.x> width-500){
     dog2.x = origx2;
   dog2.y=origy2;}
  
}