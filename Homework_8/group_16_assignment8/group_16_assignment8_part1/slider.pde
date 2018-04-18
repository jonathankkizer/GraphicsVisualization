class Slider {
  int x, y;
  float w, h;
  float currentPos;
  float minPos, maxPos;
  boolean isMouseOver;
  boolean isLocked;
  float minVal, maxVal;
  
  Slider(int _x, int _y, float _w, float _h, float _minVal, float _maxVal) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    minVal = _minVal;
    maxVal = _maxVal;
    currentPos = x;
    minPos = x;
    maxPos = x + w;
  }
  
  void update(int mx, int my) {
    isMouseOver = isOver(mx, my);
    if (isLocked) {
      currentPos = constrain(mx-(h/2), minPos, maxPos);
    }
  }
  
  void display() {
    pushMatrix();
    fill(255);
    rect(x, y, w-20, h);
    if (isMouseOver) {
      fill(119,240,208);
    } else {
      fill(102);
    }
    rect(currentPos, y, h, h);
    popMatrix();
  }
  
  float getVal() {
    return currentPos/10;

  }
  
  void pressed(int mx, int my) {
    if (isMouseOver) {
      isLocked = true;
    } else {
      isLocked = false;
    }
  }
  
  boolean isOver(int mx, int my) {
    return (mx > x && mx < x+w && my > y && my < y+h);
  }
  
  void released() { 
    isLocked = false;
  }
}