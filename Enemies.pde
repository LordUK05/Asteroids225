int[] enemyPos = {200,400,500,500}; 
// X,Y
// Thinking of throwing this whole system away and going for something simpler, that wont be as resource intensive.
int[] environment = new int[0];

// Force generate the environment please
// X,Y,Size | The first 3 elements are for the bounding box to check if they player is outside of the "main play area" which then begins checks to see if they collide with any individual box to save on performance.
PShape Enemy;
// Technically the environment is an an enemy as it kills you.
void Environment(){
  background(0);
  stroke(255,0,0);
  fill(0);
  // For the time being im shelving the environment till i can come up with something better than THIS
  //for (int i = 0; i<2000; i+=100){
  //  rect(400,i-playerPos[1]-200,1200,50);    
  //}
  //for (int i = 0; i<2000; i+=100){
  //  rect(i-playerPos[0],500,50,1200);
  //}
  square(800-playerPos[0],800-playerPos[1],900);
}

// Do all enemy calculations like movement and collisions // MAKE THIS A CLASS STORE POSITION AND VEL INSIDE OF IT or dont
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
    rectMode(LEFT);
    fill(0,0,0,0);
    stroke(0,255,0,255);
    rect(enemyPos[i],enemyPos[i+1],enemyPos[i]+100,enemyPos[i+1]+100);
    rectMode(CENTER);
  }
  
}
