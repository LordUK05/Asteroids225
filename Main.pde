PFont gameFont;

void setup() {
  size(800, 800);
  gameFont = createFont("GameFont.ttf", 64);
  Player = createShape();
  Player.beginShape();
  Player.vertex(0, 0);
  Player.vertex(-20, +40);
  Player.curveVertex(-20, 40);
  Player.curveVertex(0, 30);
  Player.curveVertex(20, 40);
  Player.endShape();
}



void mouse() {
  fill(255);
  textSize(15);
  text(mouseX+" , "+mouseY, 100, 50);
}

void draw() {
  background(0);
  SceneHandler();
  //Player();
  mouse();
}
