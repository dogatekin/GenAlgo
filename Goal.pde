class Goal {
  PVector pos;
  int d; // diameter
  int r; // radius
  
  Goal(PVector aPos, int aDiameter) {
    pos = aPos;
    d = aDiameter;
    r = d/2;
  }
  
  void show() {
    fill(255,128,0);
    ellipse(pos.x,pos.y,d,d);
  }
}
