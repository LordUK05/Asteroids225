// Movement variables

boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

int[] playerPos = {400, 400};
int[] speed = {0, 0};
int movementSpeed = 5;
// Check if menu element has been clicked
void mouseClicked() {
  if (isTitle) {
    if (mouseX>200 && mouseX<600 && mouseY>350 && mouseY<450) {
      isTitle = false;
      isGame = true;
    } else if (mouseX>200 && mouseX<600 && mouseY>500 && mouseY<550) {
      isTitle = false;
      isSettings = true;
    } else if (mouseX>200 && mouseX<600 && mouseY>650 && mouseY<750) {
      exit();
    }
  } else if (isGame){
    bullets.add(new bullet(playerPos[0],playerPos[1],5,5));
  }
}
// Check if mouse is dragged (Makes menus feel more responsive)
void mouseDragged() {
  if (isTitle) {
    if (mouseX>200 && mouseX<600 && mouseY>350 && mouseY<450) {
      isTitle = false;
      isGame = true;
    } else if (mouseX>200 && mouseX<600 && mouseY>500 && mouseY<550) {
      isTitle = false;
      isSettings = true;
    } else if (mouseX>200 && mouseX<600 && mouseY>650 && mouseY<750) {
      exit();
    }
  }
}
// Movement handling, checks if its in the correct scene
void keyPressed() {
  if (isGame) {
    switch (keyCode) {
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
    switch (keyCode) {
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
// Handles all movement, with smoothing
void movement() {
  // Left and right movement for the player, im using a method of smoothing so that movement doesnt feel binary // frameCount %% X (e.g. 10)
  if (left && right) {
    if (speed[0]==0) {
    } else if (speed[0]<0) {
      speed[0] = min(speed[0]+1, 0);
    } else if (speed[0]>0) {
      speed[0] = max(speed[0]-1, 0);
    }
  }
  if (left && (frameCount % 5 == 0)) {
    speed[0] = max(speed[0]-1, -movementSpeed);
  }
  if (right && (frameCount % 5 == 0)) {
    speed[0] = min(speed[0]+1, movementSpeed);
  }
  if (!left && !right) {
    if (speed[0]==0) {
    } else if (speed[0]<0) {
      speed[0] = min(speed[0]+1, 0);
    } else if (speed[0]>0) {
      speed[0] = max(speed[0]-1, 0);
    }
  }
  // Up and down movement (the exact same as the left and right, but with diff var names)
  if (up && down) {
    if (speed[1]==0) {
    } else if (speed[1]<0) {
      speed[1] = min(speed[1]+1, 0);
    } else if (speed[1]>0) {
      speed[1] = max(speed[1]-1, 0);
    }
  }
  if (up && (frameCount % 5 == 0)) {
    speed[1] = max(speed[1]-1, -movementSpeed);
  }
  if (down && (frameCount % 5 == 0)) {
    speed[1] = min(speed[1]+1, movementSpeed);
  }
  if (!down && !up) {
    if (speed[1]==0) {
    } else if (speed[1]<0) {
      speed[1] = min(speed[1]+1, 0);
    } else if (speed[1]>0) {
      speed[1] = max(speed[1]-1, 0);
    }
  }

  // Position calculation (To know where the player loaded at the start of the scene)
  playerPos[0] += speed[0];
  playerPos[1] += speed[1];
}
