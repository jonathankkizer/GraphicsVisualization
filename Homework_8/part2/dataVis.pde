class dataVis {
  String cancerName;
  float r, x, y;
  color c;
  String n;
  boolean isMouseOver;
  int cost, initYearCost;
  
  dataVis(String _cancerName, int _cost, int _initYearCost, float _x, float _y, float _r, color _c, String _n) {
    cancerName = _cancerName;
    cost = _cost;
    initYearCost = _initYearCost;
    x = _x;
    y = _y;
    r = _r;
    c = _c;
    n = _n;
  }
  
  void update(int mx, int my) {
    if (dist(mx, my, x, y) <= r) {
      isMouseOver = true;
    } else {
      isMouseOver = false;
    }
  }
  
  void display() {
    smooth();
    fill(c);
    
    ellipse(x, y, r, r);
  }
}
