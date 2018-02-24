Person myPerson; 
float theta = 0.0000;
float thetaSpeed = 0.1000;


void setup() {
  size(500,500);
  myPerson = new Person(color(0,255,0));
  
}

void draw() {
  
  background(0);
  
  //moving the arms
  myPerson.leftShoulderGroup.translate(0.3000*cos(theta),0.3000*sin(theta));
  myPerson.rightShoulderGroup.translate(0.3000*cos(theta),0.3000*sin(theta));
  
  //moving the legs
  myPerson.hipsGroup.translate(0.1000*cos(theta),0.1000*sin(theta));
  
  //moving the person
  myPerson.entireBody.translate(0.5000*cos(theta),0.5000*sin(theta));

  //translating
  myPerson.entireBody.translate(0.1000,0);
  
  //drawing the entire person
  shape(myPerson.entireBody,0,0);
  
  
  //changing theta
  if (theta > 2.000*PI) {
    theta = 0.000;
  }
  else {
    theta += thetaSpeed;
  }
  
 
}