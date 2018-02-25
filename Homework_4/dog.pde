class Dog{
  PShape head;
  PShape ear;
  PShape nose;
  PShape body;
  PShape frontleg;
  PShape backleg;
  PShape tail;
  
  
  float x;
  float y;
  float speed;
  color c;
  float bodylength;
  float angle1 = -0;
  float angle2 = 0;
  int angleChange =5;
  final int ANGLE_LIMIT =10; 
  //dog constructor
  Dog(float x, float y, float size, float speed, color c){
    this.x = x;
    this.y = y;
    bodylength = size; 
    this.speed = speed;
    this.c = c;
    }
  //dog movements
  void display(){
    if (angle1 > ANGLE_LIMIT || angle1 < 0) // to make tail wag (loop)
  {
    angleChange = -angleChange; // move tail one way
    angle1 += angleChange; // move tail other way
  }
    translate(x,y);
    //dog body
    rect(0,0,bodylength,bodylength/2);
    //dog head
    ellipse(0+bodylength,0,bodylength*2/3,bodylength/3);
    //dog ear and nose 
    ellipse(0+bodylength*3/4,0+bodylength/10, bodylength/7.5, bodylength/3);
    ellipse(0+bodylength*4/3,0,bodylength/15,bodylength/15);
    //tail wagging,bodylength=100
    
    tail=createShape(ELLIPSE,bodylength/20,bodylength/15,bodylength/10,bodylength/2);
    tail.rotate(radians(-50));
    shape(tail);
    //frontleg and backleg
    translate(-x,-y);
    translate(x+bodylength/4,y+bodylength*1/2);
    frontleg=createShape(ELLIPSE,0,0,bodylength/10,bodylength/2);
    frontleg.rotate(radians(angle2));
    shape(frontleg);
    translate(-x-bodylength/4,-y-bodylength*1/2);
    translate(x+bodylength*3/4,y+bodylength*1/2);
    backleg=createShape(ELLIPSE,0,0,bodylength/10,bodylength/2);
    backleg.rotate(radians(angle2));
    
    
    
      
    
    fill(c);
    x = x+speed;
    y=y+random(-2,2);
     
    angle2=angle2-10;
   
    shape(backleg);
    
      
    
    
    
  }
}