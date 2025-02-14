int[] enemyPos = {200,400, 500,500}; 
// X,Y
int[] environment = {400,400,900,-154,-104,92,-167,-25,66,-155,53,90,-169,129,62,-165,195,70,-167,263,66,-166,330,68,-156,408,88,-159,493,82,-170,564,60,-170,624,60,-170,684,60,-151,763,98,-161,851,78,   
970,-120,60,962,-52,76,951,35,98,958,126,84,956,212,88,965,291,70,953,373,94,962,458,76,956,540,88,970,614,60,951,693,98,964,778,72,965,849,70,960,924,80}; // Force generate the environment please
// X,Y,Size | The first 3 elements are for the bounding box to check if they player is outside of the "main play area" which then begins checks to see if they collide with any individual box to save on performance.
PShape Enemy;
// Technically the environment is an an enemy as it kills you.
void Environment(){
  background(0);
  stroke(255,0,0);
  fill(0);
  
  for (int i = 0; i<environment.length; i+=3){
     square(environment[i],environment[i+1],environment[i+2]);
  }
    
  for (int i = 0; i<environment.length;i+=3){
    environment[i] -= speed[0];
    environment[i+1] -= speed[1];
  }
  
}

// Do all enemy calculations like movement and collisions
void Enemies(){
  // Set fill
  Enemy.setFill(0);
  Enemy.setStroke(255);
  // Calculate position of enemies before drawing them
  for (int i = 0; i<enemyPos.length; i+=2){
    enemyPos[i] -= speed[0];
    enemyPos[i+1] -= speed[1];
  }
  // Draws the enemies at the updated positions
  for (int i = 0; i<enemyPos.length; i+=2){
    //square(enemyPos[i],enemyPos[i+1],60);
    shape(Enemy,enemyPos[i],enemyPos[i+1]);
  }
}
