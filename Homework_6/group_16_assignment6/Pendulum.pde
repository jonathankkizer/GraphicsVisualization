class Pendulum{
  float x=250;
float y=0.0;
float r=30.0;
float vel=PI/60;
float accel=PI/5000;
PShape ball;
PShape rope;
float ang=0.0;
float ky,kd,m;


Pendulum(float ky,float kd, float m){
  this.ky=ky;
  this.kd=kd;
  this.m=m;
}

void display(){
  fill(250,246,111);
  stroke(0);
  strokeWeight(1);
  rope=createShape(RECT, 0,0,0.1,200);
  ball=createShape(ELLIPSE,0,185,r,r);
  rope.translate(250,160);
  ball.translate(250,160);
  rope.rotate(ang);
  ball.rotate(ang);
  shape(rope);
  shape(ball);
  accel=-(ky*(ang-0)+kd*vel)/m;
  vel+=accel;
  ang+=vel;
}
}