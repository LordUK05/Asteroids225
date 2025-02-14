PShape Player;

void Player() {
  pushMatrix();
  Player.setFill(0);
  Player.setStroke(255);
  textSize(20);

  // Figure out distance from mouse pos to centre
  float distX = mouseX-width/2;
  float distY = mouseY-height/2;
  float len = sqrt(distX*distX+distY*distY);
  float lineLen = 40;

  // Clamp values to make sure line doesnt exceed 30PX in length (this is used to make sure the player will be drawn in the correct location and not contort)
  distX = (distX/len)*lineLen;
  distY = (distY/len)*lineLen;


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
  rotate(-angle-radians(90)); // Have to add 90DEG as otherwise its not pointing at the mouse
  popMatrix(); // Return canvas to normal

  // Set fill
  fill(255);
  stroke(255);
}
