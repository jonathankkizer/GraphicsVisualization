class Planet {
  
  //
  //Source for the free ironman 3d object: user "deadcode3" at www.free3d.com
  //https://free3d.com/3d-model/ironman-rigged-original-model--98611.html
  //
  
  float planetRadius;
  float planetXcenter;
  float planetYcenter;
  float planetRotationMultiplier;
  float moonRadius;
  float moonRotationMultiplier;
  float moonRevolutionMultiplier;
  float ringThickness;
  float ringRotationMultiplier;
  
  PShape ironman;
  float ringWidth;
  
  //The main code can specify parameters to make an instance of this class if the user desires
  Planet(float planetRadius, float planetXcenter, float planetYcenter, float planetRotationMultiplier,
  float moonRadius, float moonRotationMultiplier, float moonRevolutionMultiplier, float ringThickness,
  float ringRotationMultiplier) {
    
    this.planetRadius = planetRadius;
    this.planetXcenter = planetXcenter;
    this.planetYcenter = planetYcenter;
    this.planetRotationMultiplier = planetRotationMultiplier;
    this.moonRadius = moonRadius;
    this.moonRotationMultiplier = moonRotationMultiplier;
    this.moonRevolutionMultiplier = moonRevolutionMultiplier;
    this.ringThickness = ringThickness;
    this.ringRotationMultiplier = ringRotationMultiplier;
    
    this.ringWidth = (3+(ringThickness-20)/100)*planetRadius;
    
    //no ironman is shown if the user specifies arguments
    //ironman = loadShape("IronMan.obj");
    //ironman.scale(0.05,0.05,0.05);
    sphereDetail(10);
    
  }
  
  //if the user passes in no argumnts to make an instance of a class, I will select them
  Planet() {
    
    this.planetRadius = 50;
    this.planetXcenter = 250;
    this.planetYcenter = 250;
    this.planetRotationMultiplier = 5;
    
    this.moonRadius = 30;
    this.moonRotationMultiplier = 20;
    this.moonRevolutionMultiplier = 7;
    
    this.ringThickness = 10;
    this.ringRotationMultiplier = 10;
    this.ringWidth = (3+(ringThickness-20)/100)*planetRadius;
    
    ironman = loadShape("IronMan.obj");
    ironman.scale(0.05,0.05,0.05);
    sphereDetail(10);
    
  }
  
  void displayWithIronman() {
  
  //
  //The planet, moon, and ring
  //
  
  //planet
  pushMatrix();
  translate(planetXcenter,planetYcenter); pushMatrix();
  rotateZ(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  fill(0,200 + 55*sin(frameCount/30),128 + 50 * cos(frameCount/30));
  sphere(planetRadius);
  
  //moon
  popMatrix();
  popMatrix();
  rotateZ(moonRevolutionMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(moonRevolutionMultiplier*frameCount/(PI*60));  pushMatrix();
  translate(-75 - (moonRadius - 25) - (planetRadius - 50) , -75 - (moonRadius - 25) - (planetRadius - 50)); pushMatrix();
  rotateZ(moonRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(moonRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(moonRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  fill(   123*sin(frameCount/30) + 123,123*sin(frameCount/30) + 123,0     );
  sphere(moonRadius);
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
  
  //ring
  popMatrix();
  noFill();
  stroke(random(255),random(255),random(255));
  strokeWeight(ringThickness);
  rotateX(ringRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  ellipse(0,0,ringWidth,ringWidth);
  strokeWeight(1); //back to the default
  stroke(0); //back to black outlines
  
  popMatrix();
  popMatrix(); 
  popMatrix();
  popMatrix();

  //
  //Ironman
  //
  
  pushMatrix();
  scale(-1, -1, -1); pushMatrix();
  translate(-planetXcenter,-planetYcenter); pushMatrix();
  rotateZ(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  ironman.rotate(-PI/4);
  shape(ironman,0.75*planetRadius,0.75*planetRadius);
  ironman.rotate(PI/4);
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
  
    
  }
  
  void displayWithoutIronman() {
    
  //
  //The planet, moon, and ring
  //
  
  //planet
  pushMatrix();
  translate(planetXcenter,planetYcenter); pushMatrix();
  rotateZ(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  fill(123 + 122*cos(frameCount/30), 50 + 55*sin(frameCount/30), 200 + 50 * cos(frameCount/30));
  sphere(planetRadius);
  
  //moon
  popMatrix();
  popMatrix();
  rotateZ(moonRevolutionMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(moonRevolutionMultiplier*frameCount/(PI*60));  pushMatrix();
  translate(-75 - (moonRadius - 25) - (planetRadius - 50) , -75 - (moonRadius - 25) - (planetRadius - 50)); pushMatrix();
  rotateZ(moonRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(moonRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(moonRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  fill(   123*sin(frameCount/30) + 123,123*sin(frameCount/30) + 123,123*sin(frameCount/30) + 123     );
  sphere(moonRadius);
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
 
  //ring
  popMatrix();
  noFill();
  stroke(random(255),random(255),random(255));
  strokeWeight(ringThickness);
  rotateX(ringRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  ellipse(0,0,ringWidth,ringWidth);
  strokeWeight(1); //back to the default
  stroke(0); //back to black outlines
  
  popMatrix();
  popMatrix(); 
  popMatrix();
  popMatrix();

  //
  //Ironman
  //
  /*
  pushMatrix();
  scale(-1, -1, -1); pushMatrix();
  translate(-planetXcenter,-planetYcenter); pushMatrix();
  rotateZ(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  rotateX(planetRotationMultiplier*frameCount/(PI*60));  pushMatrix();
  ironman.rotate(-PI/4);
  shape(ironman,0.75*planetRadius,0.75*planetRadius);
  ironman.rotate(PI/4);
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
  */
    
  }
  
}