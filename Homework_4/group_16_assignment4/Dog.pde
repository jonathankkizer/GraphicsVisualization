class Dog{

  PShape frontleg;
  PShape backleg;
  PShape tail;
  float xpos;
  float ypos;
  float origx;
  float origy;
  float speed=0;
  color c;
  float bodylength;
  float angle1;
  float angle2 = 0;
  float yadd;
  
  //dog constructor
  Dog(float x, float y, float size, float s, color c){
    xpos = x;
    ypos = y;
    bodylength = size; 
    speed = s;
    this.c = c;
    origx=x;
    origy=y;
    }
  //dog movements
  void display(){  
    fill(c);
    translate(xpos,ypos);
    //dog body
    rect(0,0,bodylength,bodylength/2);
    //dog head
    ellipse(0+bodylength,0,bodylength*2/3,bodylength/3);
    //dog ear and nose 
    ellipse(0+bodylength*3/4,0+bodylength/10, bodylength/7.5, bodylength/3);
    ellipse(0+bodylength*4/3,0,bodylength/15,bodylength/15);
    //tail
    tail=createShape(ELLIPSE,bodylength/20,bodylength/15,bodylength/10,bodylength/2);
    tail.rotate(radians(-50));
    shape(tail);
    //frontleg and backleg
    translate(-xpos,-ypos);
    translate(xpos+bodylength/4,ypos+bodylength*1/2);
    frontleg=createShape(ELLIPSE,0,0,bodylength/10,bodylength/2);
    frontleg.rotate(radians(angle2));
    shape(frontleg);
    translate(-xpos-bodylength/4,-ypos-bodylength*1/2);
    translate(xpos+bodylength*3/4,ypos+bodylength*1/2);
    backleg=createShape(ELLIPSE,0,0,bodylength/10,bodylength/2);
    backleg.rotate(radians(angle2));
    
    
    xpos+=speed;
    if (xpos>width){
      xpos=origx;
      ypos=origy;
    }
    angle2=angle2-2;
    if (ypos<320) {yadd=2; 
  }else if (ypos>350){ yadd=-2;
  }
   ypos += yadd; 
    
    
   
    shape(backleg);
    //translate(x+bodylength*3/4,y+bodylength*1/2);
    
    
  }
}