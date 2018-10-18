final int VEL_LIMIT = 6;

class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  
  int d; // diameter
  int r; // radius
  
  Brain brain;
  boolean alive;
  boolean reachedGoal;
  boolean isBest;
  float fitness;
  
  Dot(int aDiameter, int aBrainSize) {
    pos = new PVector(width/2, height-100);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    
    d = aDiameter;
    r = d/2;
    
    brain = new Brain(aBrainSize);
    
    alive = true;
    reachedGoal = false;
    isBest = false;
  }
  
  boolean isAlive() {
    return alive;
  }
  
  boolean reachedGoal() {
    return reachedGoal;
  }
  
  void show() {
    if(isBest) {
      fill(0,255,0);
      ellipse(pos.x,pos.y,3*d,3*d);
    }
    else {
      fill(0);
      ellipse(pos.x,pos.y,d,d);
    }
  }
  
  void move() {
    acc = brain.nextDirection(); 
        
    vel.add(acc);
    vel.limit(VEL_LIMIT);
    pos.add(vel);
  }
  
  void update(Goal goal, Obstacle[] obstacles) {
    if(alive && !reachedGoal) {
      if(brain.hasDirections()) {
        move();
        
        if(hitWall() || hitObstacle(obstacles)) {
          alive = false;
        }
        else if(reachedGoal(goal)) {
          reachedGoal = true;
        }
      }
      else {
        alive = false;
      }
    }
  }
  
  boolean hitWall() {
    return pos.x < r || pos.x > width-r || pos.y < r || pos.y > height-r;
  }
  
  boolean reachedGoal(Goal goal) {
    return pos.dist(goal.pos) < goal.r;
  }
  
  boolean hitObstacle(Obstacle[] obstacles) {
    for(int i = 0; i < obstacles.length; i++) {
      Obstacle obs = obstacles[i];
      if(pos.x > obs.x && pos.x < obs.x + obs.width && 
           pos.y > obs.y && pos.y < obs.y + obs.height) {
         return true;
       }  
    }
    
    return false;
  }
  
  void calculateFitness(Goal goal) {
    if(reachedGoal) {
      fitness = 1.0/16.0 + 10000.0/(float)pow(brain.step,2);
    }
    else {
      float distToGoal = pos.dist(goal.pos); 
      fitness = 1 / pow(distToGoal,2);
    }
  }
  
  Dot giveBirth() {
    Dot baby = new Dot(d, brain.directions.length);
    baby.brain = brain.clone();
    return baby;
  }
}
