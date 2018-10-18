class Obstacle {
  int x;
  int y;
  int width;
  int height;
  
  Obstacle(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  Obstacle() {
    this.x = (int)random(200) + 100;
    this.y= (int)random(200) + 100;
    this.width = (int)random(300);
    this.height = (int)random(300);
  }
  
  void show() {
    fill(0,200,200);
    rect(x, y, width, height);
  }
}
