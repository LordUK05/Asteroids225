// SCOPE
// PRIORITY 0: (Most important)
// Movement                                                                           COMPLETE
// Player                                                                             COMPLETE // Maybe make class?
// Environment                                                                        COMPLETE
// Proper enemies - Initial size, duplication like with slimes, movement velocity     COMPLETE
// Projectiles // USE A CLASS                                                         COMPLETE
// Deaths / Enemy duplication // ENEMY CLASS                                          COMPLETE
// End screen                                                                         COMPLETE
// Scoring                                                                            COMPLETE
// PRIORITY 1: (Would be cool to have)
// Settings                                                                           COMPLETE
// Hover text OUTSIDE OF SCOPE

// Assign classes to enemies and figure out mitosis COMPLETE

// ArrayList<class> VARNAME = new ArrayList<class>(); <- Used

PFont gameFont;
boolean debug = true;
PShape backButton;
PShape purpleBackButton;
String[] options;


void setup() {
  frameRate(60);
  size(800, 800);
  gameFont = createFont("GameFont.ttf", 64);
  // Make the back button
  backButton = createShape();
  backButton.beginShape();
  backButton.vertex(121, 13);
  backButton.vertex(144, 30);
  backButton.vertex(55, 100);
  backButton.vertex(144, 170);
  backButton.vertex(121, 190);
  backButton.vertex(12, 100);
  backButton.endShape(CLOSE);
  purpleBackButton = createShape();
  purpleBackButton.beginShape();
  purpleBackButton.fill(255, 0, 255);
  purpleBackButton.vertex(121, 13);
  purpleBackButton.vertex(144, 30);
  purpleBackButton.vertex(55, 100);
  purpleBackButton.vertex(144, 170);
  purpleBackButton.vertex(121, 190);
  purpleBackButton.vertex(12, 100);
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

  // Load Settings
  optionsFile("LOAD");
}

void debug() {     // Add buttons to enable / disable this in settings
  fill(0, 255, 0);
  textSize(15);
  text(mouseX+" , "+mouseY, 100, 80);
  text("W: "+up+" A: "+left+" S: "+down+" D: "+right, 200, 100);
  text("Pos: "+playerPos[0]+" "+playerPos[1]+"\nSpd(X,Y): "+speed[0]+" "+speed[1], 100, 120);
  text(enemies+"\n"+bullets, 400, 20);
  text("EnemyCount: "+enemies.size()+"\nBulletsCount: "+bullets.size(), 100, 160);
  text(str(stuck)+"\n"+stuckPos, 400, 450);
}

void draw() { // The draw block, kept neat for readibility
  movement();
  background(0);
  SceneHandler();
  if (debug) {
    debug();
  }
}
