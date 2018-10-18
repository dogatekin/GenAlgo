class Population {
  Dot[] dots;
  int size;
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  int minStep;
  
  Population(int aSize, int dotDiameter, int brainSize) {
    size = aSize;
    dots = new Dot[size];
    minStep = brainSize;
    
    for(int i = 0; i < dots.length; i++) {
      dots[i] = new Dot(dotDiameter, brainSize);
    }
  }
  
  void show() {
    for(Dot dot : dots) {
      dot.show();
    }
  }
  
  void update(Goal goal, Obstacle[] obstacles) {
    for(Dot dot : dots) {
      if(dot.brain.step > minStep) {
        dot.alive = false;
      }
      else {
        dot.update(goal, obstacles);
      }
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
  
  void naturalSelection() {
    Dot[] newGeneration = new Dot[dots.length];
    setBestDot();
    
    fitnessSum = 0;
    for(int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
    
    newGeneration[0] = dots[bestDot].giveBirth();
    newGeneration[0].isBest = true;
    
    for(int i = 1; i < dots.length; i++) {
      Dot parent = selectParent();
      newGeneration[i] = parent.giveBirth();
    }
    
    dots = newGeneration.clone();
    gen++;
  }
  
  Dot selectParent() {
    float rand = random(fitnessSum);
    
    float runningSum = 0;
    int index = 0;
    for(; index < dots.length && runningSum < rand; index++) {
      runningSum += dots[index].fitness; 
    }
    
    return dots[index-1];
  }
  
  void mutate(float mutationRate) {
    for(int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate(mutationRate);
    }
  }
  
  void setBestDot() {
    float max = 0;
    for (int i = 0; i< dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        bestDot = i;
      }
    }

    //if this dot reached the goal then reset the minimum number of steps it takes to get to the goal
    if (dots[bestDot].reachedGoal(goal)) {
      minStep = dots[bestDot].brain.step;
      println("Generation:", gen, "Step:", minStep);
    }
  }
}
