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
  if (left && right) {
    if (speed[0]==0){
    } else if (speed[0]<0){
       speed[0] = min(speed[0]+1, 0); 
    } else if (speed[0]>0){
    }  speed[0] = max(speed[0]-1, 0);
  } else if (left) {
    speed[0] = max(speed[0]-1, -movementSpeed);
  } else if (right) {
    speed[0] = min(speed[0]+1, movementSpeed);
  } else if (!left) {                          // Needs edge cases for where left is released and right is released snapping to zero
    speed[0] = min(speed[0]+1, 0);
  } else if (!right)
    speed[0] = max(speed[0]-1, 0);

  if (up && down) {
  }
}
