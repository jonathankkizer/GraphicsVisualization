// setup for sound library
// have to import through Processing as well
import processing.sound.*;
SoundFile file;
String audioName = "wind_1234-mike-koenig.mp3";
String path;

Tree tree1, tree2, tree3, tree4;
PVector v1, v2, v3, v4, treecreep1, treecreep2, treetopDrop;

void setup() {
  size(500,500);
  
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
  tree4 = new Tree(250, 400, 120, 15, 125, 110, v4);
  
  // sound components
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
}

void draw() {
  clear();
  background(152, 235, 235);
  fill(83, 53, 10);
  rect(0, 400, width, height);
  
  tree1.display();
  tree2.display();
  tree3.display();
  tree4.display();
  
  tree2.treeTimeLapse();
  tree1.treeTimeLapse();
  tree3.treeTimeLapse();
  tree4.treeTimeLapse();
  tree4.treeCreep(treecreep2, "LEFT");
  tree1.dropLeaves(treetopDrop);
  tree2.treeCreep(treecreep1, "right");
  //translate(300, 250);
}