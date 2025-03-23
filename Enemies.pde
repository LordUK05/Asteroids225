PShape Enemy;
int[] environmentPos = {0,0};
// Technically the environment is an an enemy as it constrains your movement.
void Environment(){
  background(0);
  stroke(255,0,0);
  fill(0);
  environmentPos[0] = int(800-playerPos[0]); environmentPos[1] = int(800-playerPos[1]);
  square(environmentPos[0],environmentPos[1],900);
}


void startAllEnemies(){
  for (int i=0;i<5;i++){
    enemies.add(new enemy(-2));
  } 
}
// Void to call interal enemy update function to clear up the draw block
void UpdateEnemies(){
  for (enemy enemyShell : enemies){
    enemyShell.update();
  }
}

ArrayList<enemy> enemies = new ArrayList<enemy>();
class enemy{
  int[] selfPos;
  int[] movementVelocity;
  int state;
  
  enemy(int parentState) {
    // Set fill
    Enemy.setFill(0);
    Enemy.setStroke(255);
    state = parentState+1;
    selfPos = new int[] {int(random(0,750)),int(random(0,750))};
    movementVelocity = new int[] {int(random(-5,5)),int(random(-5,5))};
  }
  
  void update(){
    println(environmentPos[0]," ",environmentPos[1]);
    if (selfPos[0] > environmentPos[0]+350 || selfPos[0] < environmentPos[0]-450){
      movementVelocity[0] = -movementVelocity[0];
    } 
    if (selfPos[1] < environmentPos[1]-450 || selfPos[1] > environmentPos[1]+350) {
      movementVelocity[1] = -movementVelocity[1];
    }
    selfPos[0] -= speed[0] + movementVelocity[0];
    selfPos[1] -= speed[1] + movementVelocity[1];
    // + movementVelocity[0]
    // + movementVelocity[1]
    //square(selfPos[0],selfPos[1],60);
    fill(0,255,0);
    stroke(255);
    textSize(14);
    text("SelfPos:"+selfPos[0]+" "+selfPos[1]+"\nVel:"+movementVelocity[0]+" "+movementVelocity[1],selfPos[0],selfPos[1]);
    circle(selfPos[0],selfPos[1],3);
    shape(Enemy,selfPos[0],selfPos[1]);
    rectMode(LEFT);
    fill(0,0,0,0);
    stroke(0,255,0,255);
    rect(selfPos[0],selfPos[1],selfPos[0]+100,selfPos[1]+95);
    rectMode(CENTER);
  }
  
  boolean hit(){
    // Hit detection
    return true;
  }
  
  
}
