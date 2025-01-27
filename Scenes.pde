boolean isTitle = true;
boolean isEndscreen = false;

void SceneHandler() {
  textFont(gameFont);
  if (isTitle) {
    background(0);
    fill(255);
    textSize(60);
    text("NOT Asteroids", 410, 150);
    textSize(20);
    textAlign(3);
    text("By:\nWill Price - 2025", 400, 190);
    fill(0);
    rect(200, 400, 400, 100);#
    fill(255);
    textSize(70);
    if (mouseX>200 && mouseX<600 && mouseY>400 && mouseY<500){
      fill(255,0,255);
      stroke(255,0,255);
    } else {
        stroke(255);
    }
    text("PLAY", 400, 475);
    //fill(255);
    //text("PLAY", 400, 475);
  } else if (isTitle == false && isEndscreen == false){
     Player(); 
  }
}
