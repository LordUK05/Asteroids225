PShape Player;

void Player() {
  fill(255);
  stroke(255);
  textSize(20);
  Player = createShape();
  Player.beginShape();
  Player.vertex(0, 0);
  Player.vertex(-20, +40);
  Player.curveVertex(-20, 40);
  Player.curveVertex(0, 30);
  Player.curveVertex(20, 40);
  Player.endShape();
  if (mouseX<400 && mouseY<400) {
    int ySec1 = 400-mouseY;
    int xSec1 = 400-mouseX;
    if (xSec1>ySec1) {
      Player.rotate(-atan(xSec1/ySec1));
    } else if (ySec1>xSec1) {
      Player.rotate(atan(ySec1/xSec1)-1.57);
    } else {
      Player.rotate(radians(-45));
    }
    text("Y: "+ySec1+" X:"+-xSec1, 100, 200);
    //println(sqrt(pow(400-mouseY,2)+pow(400-mouseX,2)));
    //Player.rotate(radians(180+(asin(400-mouseX/sqrt(pow(400-mouseY,2)+pow(400-mouseX,2))))));
    //println(1.57+atan(xSec1/ySec1));
    //Player.rotate(degrees(1.57+atan(xSec1/ySec1)));
  }

  shape(Player, width/2, height/2);
}
