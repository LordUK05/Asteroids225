// SCOPE
// PRIORITY 0: (Most important)
// Movement   COMPLETE
// Player     COMPLETE
// Environment
// Proper enemies - Initial size, duplication like with slimes, movement velocity
// Projectiles - Ammo, cooldowns
// Deaths / Enemy duplication
// End screen
// Scoring
// PRIORITY 1: (Would be cool to have)
// Settings
// Hover text

PFont gameFont;

void setup() {
  frameRate(60);
  size(800, 800);
  gameFont = createFont("GameFont.ttf", 64);
  // Declare player
  Player = createShape();
  Player.beginShape();
  Player.vertex(0, 0);
  Player.vertex(-20, +40);
  Player.curveVertex(-20, 40);
  Player.curveVertex(0, 30);
  Player.curveVertex(20, 40);
  Player.endShape(CLOSE);
  // Declare enemy (May add more variants later)
  Enemy = createShape();
  Enemy.beginShape();
  Enemy.vertex(30,0);
  Enemy.vertex(47,12);
  Enemy.vertex(72,0);
  Enemy.vertex(94,24);
  Enemy.vertex(68,36);
  Enemy.vertex(95,60);
  Enemy.vertex(67,95);
  Enemy.vertex(36,82);
  Enemy.vertex(26,94);
  Enemy.vertex(0,72);
  Enemy.vertex(15,50);
  Enemy.vertex(0,24);
  Enemy.endShape(CLOSE);
}



void debug() {     // REMOVE BEFORE SUBMISSION
  fill(0,255,0);
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
