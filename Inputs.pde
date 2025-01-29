// Movement variables

boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;

int[] playerPos = {0, 0};
int[] speed = {0, 0};
int movementSpeed = 5;

void mouseClicked() {
  if (isTitle) {
    if (mouseX>200 && mouseX<600 && mouseY>400 && mouseY<500) {
      isTitle = false;
      isGame = true;
    }
  }
}

void mouseDragged() {
  if (isTitle) {
    if (mouseX>200 && mouseX<600 && mouseY>400 && mouseY<500) {
      isTitle = false;
      isGame = true;
    }
  }
}

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

void movement() {
  // Left and right movement for the player, im using a method of smoothing so that movement doesnt feel binary
  if (left && right) {
    if (speed[0]==0) {
    } else if (speed[0]<0) {
      speed[0] = min(speed[0]+1, 0);
    } else if (speed[0]>0) {
      speed[0] = max(speed[0]-1, 0);
    }
  }
  if (left) {
    speed[0] = max(speed[0]-1, -movementSpeed);
  }
  if (right) {
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
  if (up) {
    speed[1] = max(speed[1]-1, -movementSpeed);
  }
  if (down) {
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
  playerPos[0] -= speed[0];
  playerPos[1] -= speed[1];
}
