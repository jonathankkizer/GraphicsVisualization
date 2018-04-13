class dataVis {
  float r, x, y;
  color c;
  String n;
  
  dataVis(float _x, float _y, float _r, color _c, String _n) {
    x = _x;
    y = _y;
    r = _r;
    c = _c;
    n = _n;
  }
  
  void display() {
    fill(c);
    
    ellipse(x, y, r, r);
  }
}
