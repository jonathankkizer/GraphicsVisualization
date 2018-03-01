class boxTest {
  PShape box;
  
  boxTest(int x, int y) {
    box = createShape(RECT, x, y, 20, 10);
  }
  
  void display() {
    shape(box);
  }
  
}