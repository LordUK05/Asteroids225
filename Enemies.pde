PShape Enemy;
int enemyCount; // Decides how many enemies to spawn at the start of each round (user decided) \\ NOT IN USE
int enemyVelocity; // Determines the lower and upper bounds of enemy speed (4 by default), inclusive \\ NOT IN USE
int[] environmentPos = {0, 0};
// Technically the environment is an an enemy as it constrains your movement.
void Environment() {
  background(0);
  stroke(255, 0, 0);
  fill(0);
  environmentPos[0] = int(800-playerPos[0]);
  environmentPos[1] = int(800-playerPos[1]);
  square(environmentPos[0], environmentPos[1], 900);
}


void startAllEnemies() {
  for (int i=0; i<5; i++) {
    enemies.add(new enemy(-1, 0, 0));
  }
}
// Void to call interal enemy update function to clear up the draw block
void UpdateEnemies() {
  for (enemy enemyShell : enemies) {
    enemyShell.update();
  }
  for (int x = 0; x<enemies.size(); x++) { // This is a mess, it goes through each enemy, going through each bullet checking if each bullet is in its hitbox, killing the enemy if it comes out true
    enemy enemyshell = enemies.get(x);
    int[] tmpEnemyPos = enemyshell.position();
    for (int i = 0; i<bullets.size(); i++) {
      bullet bulletshell = bullets.get(i); // classname varname = arraylistname.get (method) paramater int // Assigns a shell object the same way objectforloop does it, but with a counter to keep track of which to access
      PVector tmpBulletPos = bulletshell.position();
      if (tmpEnemyPos[0]<tmpBulletPos.x && tmpEnemyPos[1]<tmpBulletPos.y && tmpEnemyPos[0]+100>tmpBulletPos.x && tmpEnemyPos[1]+95>tmpBulletPos.y) { // I hate this, it checks if the bullet is within the bounds of the enemies hitbox
        //text(i+" "+x+"\n"+enemies.get(i),500,500);
        enemies.remove(x);
        enemies.add(new enemy(0, int(tmpBulletPos.x),int(tmpBulletPos.y)));
        bullets.remove(i);
      }
    }
  }
}


ArrayList<enemy> enemies = new ArrayList<enemy>();
class enemy {
  int[] selfPos;
  int[] movementVelocity;
  int state;
  float selfScale;

  enemy(int parentState, int parentX, int parentY) {
    // Set fill
    Enemy.setFill(0);
    Enemy.setStroke(255);
    state = parentState+1;
    if (parentState == -1){
      selfPos = new int[] {int(random(0, 750)), int(random(0, 750))};
    } else {
     selfPos = new int[] {parentX,parentY}; 
    }
    //movementVelocity = new int[] {int(random(-5,5)),int(random(-5,5))};
    movementVelocity = new int[] {int(random(-4, 4)), int(random(-4, 4))};
    switch (state){
     case 0:
       selfScale = 1.0;
       break;
     case 1:
       selfScale = 0.75;
       break;
    }
    Enemy.scale(selfScale);
  }

  void update() { // speed[] references players speed, its how im keeping objects "pinned" in world (worldspace)
    println(environmentPos[0], " ", environmentPos[1]);
    if (selfPos[0] > environmentPos[0]+350 || selfPos[0] < environmentPos[0]-450) {
      movementVelocity[0] = -movementVelocity[0];
    }
    if (selfPos[1] < environmentPos[1]-450 || selfPos[1] > environmentPos[1]+350) {
      movementVelocity[1] = -movementVelocity[1];
    }
    if (!stuck) {
      selfPos[0] -= speed[0] + movementVelocity[0];
      selfPos[1] -= speed[1] + movementVelocity[1];
    } else if (stuckPos == "LEFT" || stuckPos == "RIGHT") {
      selfPos[1] -= speed[1] + movementVelocity[1];
      selfPos[0] -= movementVelocity[0];
    } else if (stuckPos == "TOP" || stuckPos == "BOTTOM") {
      selfPos[0] -= speed[0] + movementVelocity[0];
      selfPos[1] -= movementVelocity[0];
    }

    shape(Enemy, selfPos[0], selfPos[1]);
    if (debug) {
      fill(0, 255, 0);
      stroke(255);
      textSize(14);
      text("SelfPos:"+selfPos[0]+" "+selfPos[1]+"\nVel:"+movementVelocity[0]+" "+movementVelocity[1], selfPos[0], selfPos[1]);
      rectMode(LEFT);
      fill(0, 0, 0, 0);
      stroke(0, 255, 0, 255);
      rect(selfPos[0], selfPos[1], selfPos[0]+100, selfPos[1]+95);
    }
    rectMode(CENTER);
  }

  boolean hit() {
    // Hit detection
    return true;
  }

  int[] position() {
    // return position
    return selfPos;
  }
}
