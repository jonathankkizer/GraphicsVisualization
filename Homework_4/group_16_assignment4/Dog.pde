class Dog{

  PShape frontleg;
  PShape backleg;
  PShape tail;
  
  
  float x;
  float y;
  float speed;
  color c;
  float bodylength;
  float angle1;
  float angle2 = 0;
  float angle3=0;
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
    fill(c);
    translate(x,y);
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
    x = x+2;
    y=y+random(-2,2);
     
    angle2=angle2-speed;
    
   
    shape(backleg);
    //translate(x+bodylength*3/4,y+bodylength*1/2);
    
    
  }
}