class Tree {
  PShape treetrunk;
  PShape treetop;
  PVector speed;
  float x, y, h, w, treetopDrop;
  float treetopX, treetopY, treetopLocX, treetopLocY;
  float originalX, originalY, originalH, originalW, originalTreetopX, originalTreetopY;
  boolean positiveGrowth, dropLeaves;
  
  // tree constructor
  Tree(float x, float y, float h, float w, float treetopX, float treetopY, PVector speed) {
    this.x = x;
    this.y = y;
    originalX = x;
    originalY = y;
    this.h = h;
    this.w = w;
    originalH = h;
    originalW = w;
    this.treetopX = treetopX;
    this.treetopY = treetopY;
    originalTreetopX = treetopX;
    originalTreetopY = treetopY;
    this.speed = speed;
    positiveGrowth = true;
    treetopDrop = 0;
  }
  
  // "grows" tree over time, with tree shrinking back to original size after reaching 1.5* original width
  void treeTimeLapse() {
    if (this.h > 1.5*originalH && this.w > 1.5*originalW) {
      positiveGrowth = false;
    } else if (this.h < originalH && this.w < originalW){
      positiveGrowth = true;
    }
    
    if (positiveGrowth == true) {
      //this.x += speed.x;
      //this.y += speed.y;
      this.h += speed.y;
      this.w += speed.x;
      this.treetopX += speed.x;
      this.treetopY += speed.y;
      //createTreeTrunk(this.x, this.y);
      //createTreeTop(this.x, this.y, this.h, this.w);
    }
    if (positiveGrowth == false) {
      this.h -= speed.y;
      this.w -= speed.x;
      this.treetopX -= speed.x;
      this.treetopY -= speed.y;
    }
  }
  
  // allows tree to "creep" in either direction (left or right) based on specified parameter
  void treeCreep(PVector treeCreepSpeed, String direction) {
    if (direction == "RIGHT" || direction == "right") {
      this.x += treeCreepSpeed.x;
    } else {
      this.x -= treeCreepSpeed.x;
    }
  }
  
  // flips dropLeaves boolean, which affects how the treetop is drawn in the display() call
  void dropLeaves(PVector treeCreepSpeed) {
    dropLeaves = true;
  }
  
  void display() {
    // creates brown tree trunk, from bottom left corner up and around before closing
    treetrunk = createShape();
    treetrunk.beginShape();
    treetrunk.fill(83, 53, 10);
    treetrunk.vertex(x, y);
    treetrunk.vertex(x, y-h);
    treetrunk.vertex(x+w, y-h);
    treetrunk.vertex(x+w, y);
    treetrunk.endShape(CLOSE);
    
    fill(4, 116, 13);
    treetopLocX = x+(w/2);
    
    // "drops" leaves towards the bottom of the frame, turns leaf color to fall yellow, ultimately returns treetop to original position
    if (dropLeaves == false) {
      treetopLocY = y-h;
    } else {
      if (treetopDrop < h + 2*treetopY) {
        treetopDrop += 2*speed.y;
        treetopLocY = (y-h) + treetopDrop;
        fill(#DBA72E);
      }
      if (treetopDrop >= h + 2*treetopY) {
        fill(4, 116, 13);
        treetopLocY = y-h;
        treetopDrop = 0;
      }

    }
    // creates treetop based on X,Y, H, W parameters)
    treetop = createShape(ELLIPSE, treetopLocX, treetopLocY, treetopX, treetopY);
    
    // shows shapes
    shape(treetrunk);
    shape(treetop);
  }
}