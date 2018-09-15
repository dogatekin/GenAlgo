final int VEL_LIMIT = 5;

class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  
  int d; // diameter
  int r; // radius
  
  Brain brain;
  boolean alive;
  boolean reachedGoal;
  float fitness;
  
  Dot(int aDiameter) {
    pos = new PVector(width/2, height-100);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    
    d = aDiameter;
    r = d/2;
    
    brain = new Brain(400);
    
    alive = true;
    reachedGoal = false;
  }
  
  boolean isAlive() {
    return alive;
  }
  
  boolean reachedGoal() {
    return reachedGoal;
  }
  
  void show() {
    fill(0);
    ellipse(pos.x,pos.y,d,d);
  }
  
  void move() {
    acc = brain.nextDirection(); 
        
    vel.add(acc);
    vel.limit(VEL_LIMIT);
    pos.add(vel);
  }
  
  void update(Goal goal) {
    if(alive && !reachedGoal) {
      if(brain.hasDirections()) {
        move();
        
        if(hitWall()) {
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
  
  void calculateFitness(Goal goal) {
     float distToGoal = pos.dist(goal.pos); 
     fitness = 1 / pow(distToGoal,2);
  }
}
