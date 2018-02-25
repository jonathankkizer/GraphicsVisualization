Dog dog1;
float origx;
float origy;

void setup(){
  size(500,500);
  dog1 = new Dog(20,300,100,2,color(100));

  origx=dog1.x;
  origy=dog1.y;
  
}
 void draw(){
   clear();
   background(255);
  
   
   
   
   dog1.display();
   if (dog1.angle1 > dog1.ANGLE_LIMIT || dog1.angle1 < 0) // to make tail wag (loop)
  {
    dog1.angleChange = -dog1.angleChange; // move tail one way
    dog1.angle1 += dog1.angleChange; // move tail other way
  }
   if (dog1.x> width){
     dog1.x = origx;
   dog1.y=origy;}
     
   
 
 }