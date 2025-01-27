PFont gameFont;

void setup(){
   size(800,800);
   gameFont = createFont("GameFont.ttf", 64);
}



void mouse(){
  fill(255);
  textSize(15);
 text(mouseX+" , "+mouseY, 100,50); 
}

void draw(){
  background(0);
  SceneHandler();
  //Player(); 
  mouse();
}
