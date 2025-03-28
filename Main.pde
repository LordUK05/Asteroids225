// SCOPE
// PRIORITY 0: (Most important)
// Movement   COMPLETE
// Player     COMPLETE // Maybe make class?
// Environment COMPLETE
// Proper enemies - Initial size, duplication like with slimes, movement velocity
// Projectiles // USE A CLASS    COMPLETE
// Deaths / Enemy duplication // ENEMY CLASS
// End screen
// Scoring
// PRIORITY 1: (Would be cool to have)
// Settings
// Hover text

// BUGS:
// Dragging play causes a bullet to fire as im using clicked and released functions
// Bullets follow the player in screenspace
// Ask adam about bullet.shouldKill
// Ask adam about bullets following player

// Assign classes to enemies and figure out mitosis

// ArrayList<class> VARNAME = new ArrayList<class>(); <- Used

PFont gameFont;
boolean debug = true;
PShape backButton;
PShape purpleBackButton;
// PImage Name;
// x = loadImage("Name.png")
// image(name, x, y);

void setup() {
  frameRate(60);
  size(800, 800);
  gameFont = createFont("GameFont.ttf", 64);
  // Make the back button
  backButton = createShape();
  backButton.beginShape();
  backButton.vertex(121,13);
  backButton.vertex(144,30);
  backButton.vertex(55,100);
  backButton.vertex(144,170);
  backButton.vertex(121,190);
  backButton.vertex(12,100);
  backButton.endShape(CLOSE);
  purpleBackButton = createShape();
  purpleBackButton.beginShape();
  purpleBackButton.fill(255, 0, 255);
  purpleBackButton.vertex(121,13);
  purpleBackButton.vertex(144,30);
  purpleBackButton.vertex(55,100);
  purpleBackButton.vertex(144,170);
  purpleBackButton.vertex(121,190);
  purpleBackButton.vertex(12,100);
  purpleBackButton.endShape(CLOSE);
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

void debug() {     // Add buttons to enable / disable this in settings
  fill(0,255,0);
  textSize(15);
  text(mouseX+" , "+mouseY, 100, 80);
  text("W: "+up+" A: "+left+" S: "+down+" D: "+right, 200,100);
  text("Pos: "+playerPos[0]+" "+playerPos[1]+"\nSpd(X,Y): "+speed[0]+" "+speed[1], 100,120);
  text(enemies+"\n"+bullets,400,20);
  text("EnemyCount: "+enemies.size()+"\nBulletsCount: "+bullets.size(),100,160);
  text(str(stuck)+"\n"+stuckPos, 400,450);
}

void draw() {
  movement();
  background(0);
  SceneHandler();
  debug();
}
