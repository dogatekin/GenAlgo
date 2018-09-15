class Population {
  Dot[] dots;
  int size;
  
  Population(int aSize, int dotDiameter) {
    size = aSize;
    dots = new Dot[size];
    
    for(int i = 0; i < dots.length; i++) {
      dots[i] = new Dot(dotDiameter);
    }
  }
  
  void show() {
    for(Dot dot : dots) {
      dot.show();
    }
  }
  
  void update(Goal goal) {
    for(Dot dot : dots) {
      dot.update(goal);
    }
  }
  
  void calculateFitness(Goal goal) {
    for(Dot dot : dots) {
      dot.calculateFitness(goal);
    }
  }
  
  boolean allDead() {
    for(Dot dot : dots) {
      if(dot.isAlive() && !dot.reachedGoal()) {
        return false;
      }
    }
    return true;
  }
}
