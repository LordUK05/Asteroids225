int[] enemyPos = {200,400,500,500};


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
