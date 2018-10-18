class Brain {
   PVector[] directions;
   int step;
   int size;
   
   Brain(int aSize) {
     step = 0;
     size = aSize;
     directions = new PVector[size];
     randomizeDirections();
   }
   
   void randomizeDirections() {
     for(int i = 0; i < directions.length; i++) {
       float randomAngle = random(2*PI);
       directions[i] = PVector.fromAngle(randomAngle);
     }
   }
   
   PVector nextDirection() {
     return directions[step++];
   }
   
   boolean hasDirections() {
     return size > step;
   }
   
   Brain clone() {
     Brain clone = new Brain(size);
     arrayCopy(directions, clone.directions);
     return clone;
   }
   
   void mutate(float mutationRate) {
     for(int i = 0; i < directions.length; i++) {
       if(random(1) < mutationRate) {
         float randomAngle = random(2*PI);
         directions[i] = PVector.fromAngle(randomAngle);
       }
     }
  }
}
