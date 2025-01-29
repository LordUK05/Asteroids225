PFont gameFont;

void setup() {
  frameRate(60);
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



void debug() {     // REMOVE BEFORE SUBMISSION
  fill(255);
  textSize(15);
  text(mouseX+" , "+mouseY, 100, 50);
  text("W: "+up+" A: "+left+" S: "+down+" D: "+right, 200,100);
  text("Pos: "+playerPos[0]+" "+playerPos[1]+"\nSpd(X,Y): "+speed[0]+" "+speed[1], 100,120);
}

void draw() {
  movement();
  background(0);
  SceneHandler();
  debug();
}
