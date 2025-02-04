PShape Player;

void Player() {
  pushMatrix();
  fill(255);
  stroke(255);
  textSize(20);

  // Figure out distance from mouse pos to centre
  float distX = mouseX-width/2;
  float distY = mouseY-height/2;
  float len = sqrt(distX*distX+distY*distY);
  float lineLen = 40;

  // Clamp values to make sure line doesnt exceed 30PX in length
  if (len<lineLen) {
    distX = (distX/len)*lineLen;
    distY = (distY/len)*lineLen;
  } else if (len>lineLen) {
    distX = (distX/len)*lineLen;
    distY = (distY/len)*lineLen;
  }

  // Move shape to center using translation matrix
  translate(width/2, height/2);
  stroke(0,255,0);
  fill(0,0,0,0);
  square(0,0,40);
  // Rotate shape dependent on mouse pos
  float angle = atan2(distY, distX);
  rotate(angle+radians(90));
  shape(Player, 0, -20);  // draw shape

  // Attempt to reallign grid and unrotate canvas
  rotate(-angle-radians(90));
  popMatrix();

  // Set fill
  fill(255);
  stroke(255);
}
