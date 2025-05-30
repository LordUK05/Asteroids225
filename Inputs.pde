// Movement variables

boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
boolean fire = false;
boolean stuck = false;
String stuckPos = "NONE";
long lastFireTime = 0;
int[] playerPos = {400, 400};
int[] speed = {0, 0};
PVector pvSpeedx = new PVector(0, 0);
PVector pvSpeedy = new PVector(0, 0);
int movementSpeed = 5;
// Check if menu element has been clicked
void mouseClicked() {
  if (isTitle) { // ALL INPUTS BELOW ARE FOR THE TITLE SCREEN
    if (mouseX>200 && mouseX<600 && mouseY>350 && mouseY<450) {
      isTitle = false;
      isGame = true;
      isKillable = false;
      invincibilityTimer = millis();
      startAllEnemies();
    } else if (mouseX>200 && mouseX<600 && mouseY>500 && mouseY<550) {
      isTitle = false;
      isSettings = true;
      optionsFile("CREATEWRITER");
    } else if (mouseX>200 && mouseX<600 && mouseY>650 && mouseY<750) {
      exit();
    }
  } else if (isGame && !fire && System.nanoTime()-lastFireTime > 150000000) {
    bullets.add(new bullet(playerPos));
    lastFireTime = System.nanoTime();
  } else if (isSettings) { // ALL CONTROLS BELOW ARE FOR THE SETTINGS SCREEN
    if (mouseX>50 && mouseX<100 && mouseY>50 && mouseY<100) {
      isSettings = false;
      isTitle = true;
      optionsFile("CLOSE");
    } else if (mouseX>200 && mouseX<600 && mouseY>150 && mouseY<250){
      debug = !debug;
    }
  }
  
  if (isEndscreen){ // CONTROLS FOR THE ENDING SCREEN
   if (mouseX>200 && mouseX<600 && mouseY>450 && mouseY<550) {
     print("RESET");
     up = false; down = false; left = false; right = false; fire = false; stuck = false;
     speed[0] = 0; speed[1] = 0;
     playerPos[0] = 400; playerPos[1] = 400;
     enemiesKilled = 0;
     score = 0;
     enemies = new ArrayList<enemy>();
     isEndscreen = false;
     isTitle = true;
   } else if (mouseX>200 && mouseX<600 && mouseY>600 && mouseY<700) {
     exit(); 
   }
  }
}

void mouseReleased() { // Used only in the game scene to stop mouse dragged from firing multiple bullets.
  if (isGame) {
    fire = false;
  }
}
// Check if mouse is dragged (Makes menus feel more responsive)
void mouseDragged() { // Same code as mouseClicked but for the dragged event, moving a single pixel while clicked changes the event to mouseDragged, having this function makes everything "feel" responsive.
  if (isTitle) { // ALL INPUTS BELOW ARE FOR THE TITLE SCREEN
    if (mouseX>200 && mouseX<600 && mouseY>350 && mouseY<450) {
      isTitle = false;
      isGame = true;
      isKillable = false;
      invincibilityTimer = millis();
      startAllEnemies();
    } else if (mouseX>200 && mouseX<600 && mouseY>500 && mouseY<550) {
      isTitle = false;
      isSettings = true;
      optionsFile("CREATEWRITER");
    } else if (mouseX>200 && mouseX<600 && mouseY>650 && mouseY<750) {
      exit();
    }
  } else if (isGame && !fire && System.nanoTime()-lastFireTime > 150000000) {
    bullets.add(new bullet(playerPos));
    fire = true;
    lastFireTime = System.nanoTime();
  } else if (isSettings) { // ALL CONTROLS BELOW ARE FOR THE SETTINGS SCREEN
    if (mouseX>50 && mouseX<100 && mouseY>50 && mouseY<100) {
      isSettings = false;
      isTitle = true;
      optionsFile("CLOSE");
    } else if (mouseX>200 && mouseX<600 && mouseY>150 && mouseY<250 && frameCount % 15 == 0){
      debug = !debug;
    }
    
  }
  
  if (isEndscreen){ // CONTROLS FOR THE ENDING SCREEN
   if (mouseX>200 && mouseX<600 && mouseY>450 && mouseY<550) {
     print("RESET");
     up = false; down = false; left = false; right = false; fire = false; stuck = false;
     speed[0] = 0; speed[1] = 0;
     playerPos[0] = 400; playerPos[1] = 400;
     enemiesKilled = 0;
     score = 0;
     enemies = new ArrayList<enemy>();
     isEndscreen = false;
     isTitle = true;
   } else if (mouseX>200 && mouseX<600 && mouseY>600 && mouseY<700) {
     exit(); 
   }
  }
}
// Movement handling, checks if its in the correct scene
void keyPressed() {
  if (isGame) {
    switch (keyCode) { // Switch case for key codes for W A S and D
    case 87:
      up = true;
      break;
    case 65:
      left = true;
      break;
    case 83:
      down = true;
      break;
    case 68:
      right = true;
      break;
    }
  }
}

// Checks if key is released to reset movement boolean
void keyReleased() {
  if (isGame) {
    switch (keyCode) { // Switch for key codes WASD, this one releases the movement so its not stuck on.
    case 87:
      up = false;
      break;
    case 65:
      left = false;
      break;
    case 83:
      down = false;
      break;
    case 68:
      right = false;
      break;
    }
  }
}

void mouseWheel(MouseEvent event){ // Used for scrolling options in options scene
  if (isSettings){
    if (mouseX>200 && mouseX<600 && mouseY>300 && mouseY<400){
      float change = event.getCount();
      enemyCount -= int(change);
      enemyCount = max(enemyCount, 1);
      enemyCount = min(enemyCount, 99);
    }
    if (mouseX>200 && mouseX<600 && mouseY>450 && mouseY<550){
      float change = event.getCount();
      enemyVelocity -= int(change);
      enemyVelocity = max(enemyVelocity, 1);
      enemyVelocity = min(enemyVelocity, 99);
    }
  }
}
// Handles all movement, with smoothing
void movement() { // I apologise in advance for how unreadble this is, the comments try and explain the thought processes i was having while making it.
  // Left and right movement for the player, im using a method of smoothing so that movement doesnt feel binary // frameCount %% X (e.g. 10)
  // Add conditions for moving being stopped if stuck
  if (left && right) { // Lerps movement to 0,0 as Left and Right Cancel // Any direction && oppositeDirection is done to make sure that the movement cancels out and one doesnt prevail
    if (speed[0]==0) { // Dont do anything if theres no speed
    } else if (speed[0]<0) { // Else lerp accordingly
      speed[0] = min(speed[0]+1, 0);
    } else if (speed[0]>0) {
      speed[0] = max(speed[0]-1, 0);
    }
  }
  if (left && (frameCount % 5 == 0) && stuckPos != "LEFT") { // Allows player movement only on specific frames to make it slower // Left movement
    speed[0] = max(speed[0]-1, -movementSpeed);
  }
  if (right && (frameCount % 5 == 0) && stuckPos != "RIGHT") { // Same thing but for the other direction // Right movement
    speed[0] = min(speed[0]+1, movementSpeed);
  }
  if (!left && !right) { // Stop moving the player if neither left or right are held
    if (speed[0]==0) {
    } else if (speed[0]<0) {
      speed[0] = min(speed[0]+1, 0);
    } else if (speed[0]>0) {
      speed[0] = max(speed[0]-1, 0);
    }
  }
  // Up and down movement (the exact same as the left and right, but with diff var names)
  if (up && down) { // If up and down are held, cancel out
    if (speed[1]==0) {
    } else if (speed[1]<0) {
      speed[1] = min(speed[1]+1, 0);
    } else if (speed[1]>0) {
      speed[1] = max(speed[1]-1, 0);
    }
  }
  if (up && (frameCount % 5 == 0) && stuckPos != "TOP") { // Movement up, but only on every 5th frame (Capped FPS of 60)
    speed[1] = max(speed[1]-1, -movementSpeed);
  }
  if (down && (frameCount % 5 == 0) && stuckPos != "BOTTOM") { // Down movement
    speed[1] = min(speed[1]+1, movementSpeed);
  }
  if (!down && !up) { // If no vertical movement keys are held, stop the player from moving.
    if (speed[1]==0) {
    } else if (speed[1]<0) {
      speed[1] = min(speed[1]+1, 0);
    } else if (speed[1]>0) {
      speed[1] = max(speed[1]-1, 0);
    }
    pvSpeedx.x = speed[0];
    pvSpeedy.y = speed[1];
  }

  // Stuck handler, this checks if the player is hitting the playable area border, and stopping the players movement + stopping enemies from updating their positions
  if (playerPos[0]>850) {
    print("OUT");
  }
  // This IF statement isnt the best, but i need to know where the player is stuck to allow only the correct inputs to move the player.
  if (playerPos[0] + speed[0] >= environmentPos[0]+858) {
    stuck = true;
    stuckPos = "RIGHT";
  } else if (playerPos[0] + speed[0] <= environmentPos[0]-858) {
    stuck = true;
    stuckPos = "LEFT";
  } else if (playerPos[1] + speed[1] <= environmentPos[1]-860) {
    stuck = true;
    stuckPos = "TOP";
  } else if (playerPos[1] + speed[1] >= environmentPos[1]+860) {
    stuck = true;
    stuckPos = "BOTTOM";
  } else {
    stuck = false;
    stuckPos = "NONE";
  }

  if (stuckPos == "TOP") {
    speed[1] = max(speed[1], 0);
  } else if (stuckPos == "BOTTOM") {
    speed[1] = min(speed[1], 0);
  } else if (stuckPos == "LEFT") {
    speed[0] = max(speed[1], 0);
  } else if (stuckPos == "RIGHT") {
    speed[0] = min(speed[1], 0);
  }

  if (playerPos[0]>829) { // Found a bug where the player could escape playable area, so ive implemented this to clamp the player inside // Still kinda works? but its not noticable unless you have debugging enabled (top left corner, hold W)
    playerPos[0] = 829;
  } else if (playerPos[0]<-29) {
    playerPos[0] = -29;
  } else if (playerPos[1]>829) {
    playerPos[1] = 829;
  } else if (playerPos[1]<-29) {
    playerPos[1] = -29;
  }

  playerPos[0] += speed[0];
  playerPos[1] += speed[1];
}
