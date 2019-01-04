Population population;
Goal goal;
Obstacle[] obstacles;

int populationSize = 500;
int goalDiameter = 20;
int dotDiameter = 4;
int brainSize = 600;
float mutationRate = 0.2;

void setup() {
  size(800,800);
  background(240);
  
  population = new Population(populationSize, dotDiameter, brainSize);
  goal = new Goal(new PVector(width/2,50), goalDiameter);
  
  
  obstacles = new Obstacle[0];
  obstacles = (Obstacle[])append(obstacles, new Obstacle(150, 450, 500, 25));
  obstacles = (Obstacle[])append(obstacles, new Obstacle(100, 200, 50, 100));
  obstacles = (Obstacle[])append(obstacles, new Obstacle(650, 200, 50, 100));
  obstacles = (Obstacle[])append(obstacles, new Obstacle(375, 325, 50, 50));
  
  goal.show();
  for(Obstacle obs : obstacles) {
    obs.show();
  }
  population.show();
}

void draw() {
  background(240);
  text("Generation: " + population.gen, 10, 20);
  text("Steps: " + population.minStep, 730, 20);
  
  goal.show();
  for(Obstacle obs : obstacles) {
    obs.show();
  }
  
  if(population.allDead()) {
    population.calculateFitness(goal);
    population.naturalSelection();
    population.mutate(mutationRate);
  } 
  else {
    population.update(goal, obstacles);
    population.show();
  }
}
