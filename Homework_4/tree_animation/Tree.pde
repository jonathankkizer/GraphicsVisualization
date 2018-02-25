class Tree {
  PShape treetrunk;
  PShape treetop;
  PVector speed;
  float x, y, h, w, treetopDrop;
  float treetopX, treetopY, treetopLocX, treetopLocY;
  float originalX, originalY, originalH, originalW, originalTreetopX, originalTreetopY;
  boolean positiveGrowth, dropLeaves;
  
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
  
  void treeCreep(PVector treeCreepSpeed, String direction) {
    if (direction == "RIGHT" || direction == "right") {
      this.x += treeCreepSpeed.x;
    } else {
      this.x -= treeCreepSpeed.x;
    }
  }
  
  void dropLeaves(PVector treeCreepSpeed) {
    dropLeaves = true;
  }
  
  void display() {
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
    
    if (dropLeaves == false) {
      treetopLocY = y-h;
    } else {
      if (treetopDrop < h + treetopY) {
        treetopDrop += speed.y;
        treetopLocY = (y-h) + treetopDrop;
        fill(#DBA72E);
      }
      if (treetopDrop >= h + treetopY) {
        fill(4, 116, 13);
        treetopLocY = y-h;
        treetopDrop = 0;
      }

    }
    treetop = createShape(ELLIPSE, treetopLocX, treetopLocY, treetopX, treetopY);
    
    shape(treetrunk);
    shape(treetop);
  }
}