class Line {
  float xpos;
  float ypos;
  float gap_pos;
  float gapLength;
  float speedX;
  Line(float _xpos, float _gap_pos) {
    xpos = _xpos;
    gap_pos = _gap_pos;
    gapLength = 70;
    speedX = 2;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    line(xpos,0,xpos,gap_pos);
    line(xpos,gap_pos + gapLength,xpos,height);
  }
  
  void move(){
    xpos -= speedX;
    display();
  }
  float getXpos(){
    return xpos; 
  }
}