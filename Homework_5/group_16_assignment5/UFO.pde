class UFO{
  
  PShape ufo;
  PShape trooper;
  float x =0.0;
  float y =0.0;
  float z=0.0;
  float s = 1.0;
  float posx=500;
  float posy=0.0;
  float posz=0.0;
  float origx=500;
  float origy=0.0;

  UFO(){
    ufo=loadShape("UFO2.obj");
    
  }
  
  void display(){

    pushMatrix();
    translate(posx,posy);
    ufo.rotateY(y);
    ufo.scale(s);
    shape(ufo);
    ufo.scale(1/s);
    rotateZ(z);
    noStroke();
    fill(237,237,110);
    translate(5*s,5*s);
    lights();
    sphere(s);
    rotateZ(-z);
    translate(-posx-5*s,-posy-5*s);
    z+=PI/60;
    y=y+PI/30;
    s=s+0.05;
    posx=posx-1;
    posy=posy+1+sin(posx/20);
    
    if (posy>height){
      posx=origx;
      posy=origy;
      s=1;
    }
  popMatrix();
   }
    
}

    