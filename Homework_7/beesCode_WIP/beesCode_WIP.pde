//Brandon Kerbow
//last edited 3/30/2018 11:30am
//work in progress, this isnt quite done yet
//to do: add actual bee sprite, maybe other things as we see fit

//Creates a sequence of multiple bees connected to
//parent bees, where each bees’s position is based on the
//parent bees position. Included mouse controls, so
//the sequence can be moved around the screen. Bees which are
//not connected to a parent (i.e. only the first bee, bee1) have their
//position controlled by the mouse instead of by their parent bee

Bee bee1;
Bee bee2;
Bee bee3;
Bee bee4;

void setup() {
  size(500,500);
  frameRate(60);
  
  //adjust these two "bee" parameters (spring paremeters)
  //to change the flow of the bees movement
  float ks = 0.1; //spring constant aka spring stifness
  float kd = 0.3; //damping coefficient
  
  //Bee(float _x, float _y,float _vx, float _vy, float _ax, float _ay, float _r,  float _m, float _rx, float _ry, float _ks, float _kd)
  //see the comments in the Bee class for what exactly these parameters do
  bee1 = new Bee(250,250,0,0,0,0,20,1,250,250,ks,kd);
  bee2 = new Bee(250,250,0,0,0,0,20,1,250,250,ks,kd);
  bee3 = new Bee(250,250,0,0,0,0,20,1,250,250,ks,kd);
  bee4 = new Bee(250,250,0,0,0,0,20,1,250,250,ks,kd);
  
}

void draw() {
   background(0,255,255);
   //use my bee class method to "attach" bee2 to bee1, making bee2 a chid of b1...etc for the other bees
   bee1.attachChildParticle(bee2);
   bee2.attachChildParticle(bee3);
   bee3.attachChildParticle(bee4);
   
   //I just have each bee as a yellow or black circle right now, will find or make an actual sprite
   fill(255,255,0);
   bee1.display();
   
   fill(0);
   bee2.display();
   
   fill(255,255,0);
   bee3.display();
   
   fill(0);
   bee4.display();
  
  //everything is public in Processing so 
  //it is easy for me to get the x or y value of a bee
  println(bee1.x);
}