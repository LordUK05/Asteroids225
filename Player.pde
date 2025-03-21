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

// CLASS FOR BULLETS
// Spending most of W4 getting familiar with how classess work in processing
ArrayList<bullet> bullets = new ArrayList<bullet>();
class bullet { // The reason bullets follow player is because target is screenspace, and changing it to worldspace would mean recalculating every frame which means bullets stopping midair
  // Declare class variables
  PVector position = new PVector(0,0);
  boolean kill;
  PVector target = new PVector(0,0);
  PVector difference;
  long lifeStart; // This will determine when to kill the particle
  //float startingX, float startingY, float XV, float YV
  bullet () {
    // Declare how the variables are assigned when new object is created
    position.set(400,400); // Screenspace
    target.set(mouseX,mouseY);
    lifeStart = System.nanoTime();
    difference = PVector.sub(target, position); // Calculate difference between 
    difference.setMag(12);
  }
  
  void update(){
    position.add(difference); //????? Follows player
    circle(position.x,position.y,3);
    //square(target.x,target.y,5);
  }
  
  boolean shouldKill(){ // Ask adam how to call this, the documentation has NOTHING
   boolean kill = false;
    if (System.nanoTime()-lifeStart>2000000000){
     println("Projectile LifeTime: "+str(lifeStart-System.nanoTime()));
     kill = true;
    } 
  return kill;
  }
  
  PVector position(){
   return position;  
  }
}
