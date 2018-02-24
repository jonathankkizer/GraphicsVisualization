class Person {
  
  color fillColor;
  
  Person(color fillColor) {
    fill(fillColor);
    makePerson();
    
  }
  
  //new variables im making
  PShape entireBody;
  PShape torso;
  PShape torsoGroup;
  PShape head;
  PShape leftShoulder;
  PShape leftShoulderGroup;
  PShape leftUpperArm;
  PShape leftUpperArmGroup;
  PShape leftLowerArm;
  PShape rightShoulder;
  PShape rightShoulderGroup;
  PShape rightUpperArm;
  PShape rightUpperArmGroup;
  PShape rightLowerArm;
  PShape hips;
  PShape hipsGroup;
  PShape leftUpperLeg;
  PShape leftUpperLegGroup;
  PShape leftLowerLeg;
  PShape rightUpperLeg;
  PShape rightUpperLegGroup;
  PShape rightLowerLeg;
  
  
  void makePerson() {
      
    entireBody = createShape(GROUP);
    
    //1. giving the torso to the entire body
    torso = createShape(RECT, 235,250,30,150);
    entireBody.addChild(torso);
    
    //2. making the torso group to give the entire body
    torsoGroup = createShape(GROUP);
    
    //2.1 giving the head to the torso group
    head = createShape(ELLIPSE, 250, 225, 50, 50);
    torsoGroup.addChild(head);
    
    //
    //LEFT SHOULDER GROUP
    //
    
    //2.2 giving the left shoulder to the torso group
    leftShoulder = createShape(ELLIPSE, 230, 260, 20, 20);
    torsoGroup.addChild(leftShoulder);
    
    //2.3 giving the left shoulder group to the torso group
    leftShoulderGroup = createShape(GROUP);
    torsoGroup.addChild(leftShoulderGroup);
    
    //2.3.1 giving the left upper arm to the left shoulder group
    leftUpperArm = createShape(RECT,225,250,10,60);
    leftShoulderGroup.addChild(leftUpperArm);

    
    //2.3.2 giving the left upper arm group to the left shoulder group
    leftUpperArmGroup = createShape(GROUP);
    leftShoulderGroup.addChild(leftUpperArmGroup);
    
    //2.3.2.1 giving the left lower arm to the left upper arm group
    leftLowerArm = createShape(RECT,223,310,60,10);
    leftUpperArmGroup.addChild(leftLowerArm); 
    
    //
    //RIGHT SHOULDER GROUP
    //
    
    //2.4 giving the right shoulder to the torso group
    rightShoulder = createShape(ELLIPSE, 265, 260, 20, 20);
    torsoGroup.addChild(rightShoulder);
    
    //2.5 giving the right shoulder group to the torso group
    rightShoulderGroup = createShape(GROUP);
    torsoGroup.addChild(rightShoulderGroup);
    
    //2.5.1 giving the right upper arm to the right shoulder group
    rightUpperArm = createShape(RECT,255,250,60,10);
    rightShoulderGroup.addChild(rightUpperArm);

    
    //2.5.2 giving the right upper arm group to the right shoulder group
    rightUpperArmGroup = createShape(GROUP);
    rightShoulderGroup.addChild(rightUpperArmGroup);
    
    //2.5.2.1 giving the right lower arm to the right upper arm group
    rightLowerArm = createShape(RECT,305,190,10,60);
    rightUpperArmGroup.addChild(rightLowerArm);
    
    //
    //HIP GROUP
    //
    
    //2.6 giving the hips to the torso group
    hips = createShape(ELLIPSE, 252, 400, 40, 20);
    torsoGroup.addChild(hips);
    
    //2.7 adding the hips group to the torso group
    hipsGroup = createShape(GROUP);
    torsoGroup.addChild(hipsGroup);
    
    //2.7.1 adding the left upper leg to the hips group
    leftUpperLeg = createShape(RECT,234,405,15,50); 
    hipsGroup.addChild(leftUpperLeg);
    
    //2.7.2 adding the left upper legs group to the hips group
    leftUpperLegGroup = createShape(GROUP);
    hipsGroup.addChild(leftUpperLegGroup);
    
    //2.7.2.1 adding the left lower leg to the left upper legs group
    leftLowerLeg = createShape(RECT,236,455,10,40);
    leftUpperLegGroup.addChild(leftLowerLeg);
    
    //2.7.3 adding the right upper leg to the hips group
    rightUpperLeg = createShape(RECT,254,405,15,50); 
    hipsGroup.addChild(rightUpperLeg);
    
    //2.7.4 adding the right upper legs group to the hips group
    rightUpperLegGroup = createShape(GROUP);
    hipsGroup.addChild(rightUpperLegGroup);
    
    //2.7.4 adding the right lower legs to the right upper leg groups
    rightLowerLeg = createShape(RECT,257,455,10,40); 
    rightUpperLegGroup.addChild(rightLowerLeg);
    
    //giving the entire body the torso group
    entireBody.addChild(torsoGroup);
 
  
  }
  
  
}