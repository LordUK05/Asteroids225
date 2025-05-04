int enemyCount = 4; // Decides how many enemies to spawn at the start of each round (user decided) \\ NOT IN USE
int enemyVelocity; // Determines the lower and upper bounds of enemy speed (5 by default), inclusive \\ NOT IN USE
int[] environmentPos = {0, 0};
int enemiesKilled = 0;
// Technically the environment is an an enemy as it constrains your movement.
void Environment() {
  fill(255);
  background(0);
  stroke(255, 0, 0);
  fill(0);
  environmentPos[0] = int(800-playerPos[0]);
  environmentPos[1] = int(800-playerPos[1]);
  square(environmentPos[0], environmentPos[1], 900);
}


void startAllEnemies() {
  isKillable = false; // makes it so player cant instantly die
  invincibilityTimer = millis(); // Starts a timer so player isnt invicible forever
  for (int i=0; i<enemyCount; i++) { // Adds all enemies to the scene
    enemies.add(new enemy(-1, 0, 0));
  }
}
// Void to call interal enemy update function to clear up the draw block
void UpdateEnemies() {
  for (enemy enemyShell : enemies) { // Update each enemy (Position mainly) see Enemy.update
    enemyShell.update();
  }
  for (int x = 0; x<enemies.size(); x++) { // This function does 2 things, it loops through every enemy, then every bullet checking if an enemy is hit by a bullet, then it checks if there are any enemies completley out of bounds.
    enemy enemyshell = enemies.get(x);
    int[] tmpEnemyPos = enemyshell.position();    
    for (int i = 0; i<bullets.size(); i++) { //This goes through each enemy, then going through each bullet checking if each bullet is in the enemies hitbox, killing the enemy if it comes out true
      bullet bulletshell = bullets.get(i); // classname varname = arraylistname.get (method) paramater int // Assigns a shell object the same way objectforloop does it, but with a counter to keep track of which to access in case of removal from array
      PVector tmpBulletPos = bulletshell.position();
      // Check if its a child or adult asteroid, using the correct collision dection depending.
      if (enemyshell.selfScale == 1) {
        if (tmpEnemyPos[0]<tmpBulletPos.x && tmpEnemyPos[1]<tmpBulletPos.y && tmpEnemyPos[0]+100>tmpBulletPos.x && tmpEnemyPos[1]+95>tmpBulletPos.y) { // I hate this, it checks if the bullet is within the bounds of the enemies hitbox
          enemies.remove(x);
          enemies.add(new enemy(0, int(tmpBulletPos.x), int(tmpBulletPos.y))); // Add children
          enemies.add(new enemy(0, int(tmpBulletPos.x), int(tmpBulletPos.y)));
          bullets.remove(i); // then delete the enemy
          enemiesKilled += 1;
        }
      } else { // If its not an adult enemy do the same check but for the child's hitbox
        if (tmpEnemyPos[0]<tmpBulletPos.x && tmpEnemyPos[1]<tmpBulletPos.y && tmpEnemyPos[0]+75>tmpBulletPos.x && tmpEnemyPos[1]+70>tmpBulletPos.y) {
          enemies.remove(x);
          bullets.remove(i);
          enemiesKilled += 1;
        }
      }
    }
    if (tmpEnemyPos[0] > environmentPos[0]+360 || tmpEnemyPos[0] < environmentPos[0]-460 || tmpEnemyPos[1] < environmentPos[1]-460 || tmpEnemyPos[1] > environmentPos[1]+360){
      // This logic statement is placed weirdly, due to exectuion flows, but basically it checks if an enemy is fully (>45%~) out of bounds, and cant be saved, it just kills them and makes a new one
      // This is needed because of a weird initialisation bug where only the first waves of enemies spawns relative to (0,0) instead of (400,400)
        enemies.remove(x);
        enemies.add(new enemy(-1, int(random(environmentPos[0]-350, environmentPos[0]+350)), int(random(environmentPos[1]-350, environmentPos[1]+350)) ));
    }
  }
  if (enemies.size() == 0) { // If there are no enemies, spawn some
    startAllEnemies();
  }
}

PShape makeEnemyPS() {
  // Declare enemy (May add more variants later) // never got round to it.
  PShape Enemy;
  Enemy = createShape();
  Enemy.beginShape();
  Enemy.vertex(30, 0);
  Enemy.vertex(47, 12);
  Enemy.vertex(72, 0);
  Enemy.vertex(94, 24);
  Enemy.vertex(68, 36);
  Enemy.vertex(95, 60);
  Enemy.vertex(67, 95);
  Enemy.vertex(36, 82);
  Enemy.vertex(26, 94);
  Enemy.vertex(0, 72);
  Enemy.vertex(15, 50);
  Enemy.vertex(0, 24);
  Enemy.endShape(CLOSE);
  return Enemy;
}

ArrayList<enemy> enemies = new ArrayList<enemy>(); // An array of objects in memory used to store instances of the type enemy.
class enemy {
  int[] selfPos;
  int[] movementVelocity;
  int state;
  float selfScale;
  PShape Enemy;
  enemy(int parentState, int parentX, int parentY) {
    // Set fill
    state = parentState+1;
    switch (state) {
    case 0:
      selfScale = 1.0;
      break;
    case 1:
      selfScale = 0.75;
      break;
    }

    Enemy = makeEnemyPS(); // Generate a PShape for the enemy and save it in the private attributes, means scale can be controlled per enemy.
    Enemy.scale(selfScale);
    Enemy.setFill(0);
    Enemy.setStroke(255);
    if (parentState == -1) {
      selfPos = new int[] {int(random(environmentPos[0]-350, environmentPos[0]+350)), int(random(environmentPos[1]-350, environmentPos[1]+350))}; // Spawn at a random location if its a new enemy
    } else {
      selfPos = new int[] {parentX, parentY}; // if its not a new enemy spawn it where its parent died
    }
    //movementVelocity = new int[] {int(random(-5,5)),int(random(-5,5))}; // unused
    movementVelocity = new int[] {int(random(-enemyVelocity, enemyVelocity)), int(random(-enemyVelocity, enemyVelocity))};
  }

  void update() { // speed[] references players speed, its how im keeping objects "pinned" in world (worldspace)
    if (selfPos[0] > environmentPos[0]+350 || selfPos[0] < environmentPos[0]-450) {
      movementVelocity[0] = -movementVelocity[0];
    }
    if (selfPos[1] < environmentPos[1]-450 || selfPos[1] > environmentPos[1]+350) {
      movementVelocity[1] = -movementVelocity[1];
    }

    // Stuck detection, basically checking if the player is in a position thats "stuck" (on the verge of being out of bounds, stopping the player from moving, stopping enemies by extension so they dont desync)
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

    shape(Enemy, selfPos[0], selfPos[1]); // Draw the enemy in the right spot
    if (debug) { // Debugging information.
      fill(0, 255, 0);
      stroke(255);
      textSize(14);
      text("SelfPos:"+selfPos[0]+" "+selfPos[1]+"\nVel:"+movementVelocity[0]+" "+movementVelocity[1]+"\n"+selfScale, selfPos[0], selfPos[1]);
      rectMode(LEFT);
      fill(0, 0, 0, 0);
      stroke(0, 255, 0, 255);
      if (selfScale == 1) {
        rect(selfPos[0], selfPos[1], selfPos[0]+100, selfPos[1]+95);
      } else {
        rect(selfPos[0], selfPos[1], selfPos[0]+75, selfPos[1]+70);
      }
    }
    rectMode(CENTER);
  }

  int[] position() {
    // return position
    return selfPos;
  }
}
