class dataVis {
  float r, x, y;
  color c;
  
  dataVis(float _x, float _r, color _c) {
    x = _x;
    r = _r;
    c = _c;
    y = 250;
  }
  
  void display() {
    fill(c);
    
    ellipse(x, y, r, r);
  }
}
