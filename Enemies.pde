int[] enemyPos = {200,400, 500,500}; // X,Y
int[] environment = {400,400,0}; // X,Y,Size | The first 3 elements are for the bounding box to check if they player is outside of the "main play area" which then begins checks to see if they collide with any individual box to save on performance.

// Technically the environment is an an enemy as it kills you.
void Environment(){
  background(0);
  stroke(255,0,0);
  fill(0);
  for (int i = 0; i<environment.length;i+=3){
    environment[i] -= speed[0];
    environment[i+1] -= speed[1];
  }
  rect(environment[0],environment[1],900,1000);
}

// Do all enemy calculations like movement and collisions
void Enemies(){
  // Set fill
  fill(0);
  stroke(255);
  // Calculate position of enemies before drawing them
  for (int i = 0; i<enemyPos.length; i+=2){
    enemyPos[i] -= speed[0];
    enemyPos[i+1] -= speed[1];
  }
  
  for (int i = 0; i<enemyPos.length; i+=2){
    square(enemyPos[i],enemyPos[i+1],60);
  }
}
