void setup(){
   size(800,800);
}

void mouse(){
 text(mouseX+" , "+mouseY, 50,50); 
}

void draw(){
  background(0);
  Player(); 
  mouse();
}
