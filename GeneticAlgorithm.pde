Population test;
Goal goal;

int populationSize = 500;
int goalDiameter = 20;
int dotDiameter = 4;

void setup() {
  size(800,800);
  
  test = new Population(populationSize, dotDiameter);
  goal = new Goal(new PVector(width/2,50), goalDiameter);
  
  background(240);
  goal.show();
  test.show();
}

void draw() {
  background(240);
  goal.show();
  
  test.update(goal);
  test.show();
}
