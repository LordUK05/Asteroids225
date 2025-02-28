boolean isTitle = true;
boolean isEndscreen = false;
boolean isGame = false;
boolean isSettings = false;

void SceneHandler() {
  textFont(gameFont);
  if (isTitle) {
    title();
    //fill(255);
    //text("PLAY", 400, 475);
  } else if (isGame) {
    game();
  } else if (isEndscreen) {
    endscreen();
  } else if (isSettings) {
    setting();
  }
}

void title() {
  stroke(255);
  textAlign(CENTER);
  background(0);
  fill(255); // Get text to appear
  textSize(60);
  text("Comets", width/2, 150); //410
  textSize(20);
  text("By:\nWill Price - 2025", width/2, 190); //400
  fill(0);
  textSize(70);
  rectMode(CENTER);

  if (mouseX>200 && mouseX<600 && mouseY>350 && mouseY<450) { // Render the correct play button based on mouse pos
    fill(0);
    stroke(255, 0, 255);
    rect(width/2, 400, 400, 100);
    fill(255, 0, 255);
    text("PLAY", 400, 425);
  } else {
    fill(0);
    stroke(255);
    rect(width/2, 400, 400, 100);
    fill(255);
    text("PLAY", 400, 425);
  }

  if (mouseX>200 && mouseX<600 && mouseY>500 && mouseY<550) { // Render the correct play button based on mouse pos
    fill(0);
    stroke(255, 0, 255);
    rect(width/2, 550, 400, 100);
    fill(255, 0, 255);
    text("CONFIG", 400, 575);
  } else {
    fill(0);
    stroke(255);
    rect(width/2, 550, 400, 100);
    fill(255);
    text("CONFIG", 400, 575);
  }

  if (mouseX>200 && mouseX<600 && mouseY>650 && mouseY<750) { // Render the correct play button based on mouse pos
    fill(0);
    stroke(255, 0, 255);
    rect(width/2, 700, 400, 100);
    fill(255, 0, 255);
    text("QUIT", 400, 725);
  } else {
    fill(0);
    stroke(255);
    rect(width/2, 700, 400, 100);
    fill(255);
    text("QUIT", 400, 725);
  }

  stroke(255);
  fill(0);
  //rect(width/2, 550, 400, 100);

  //rect(width/2, 700, 400, 100);
}

void game() {
  fill(255);
  stroke(255);
  Environment();
  Enemies();
  Player();
  fill(255);
  stroke(255);
}

void endscreen() {
  background(0);
  text("GameOver", width/2, 100);
}

void setting() {
  background(0);
  fill(0);
  if (mouseX>50 && mouseX<100 && mouseY>50 && mouseY<100) {
    stroke(255,0,255);
    square(75, 75, 50);
    shape(backButton, 50, 50, 50, 50);
  } else {
    stroke(255);
    square(75, 75, 50);
    shape(backButton, 50, 50, 50, 50);
  }

  fill(255);
  stroke(255);
  textSize(40);
  text("Settings:", width/2, 100);
  if (mouseX>200 && mouseX<600 && mouseY>150 && mouseY<250) { // Render the correct play button based on mouse pos
    fill(0);
    stroke(255, 0, 255);
    rect(width/2, 200, 400, 100);
    fill(255, 0, 255);
    text("DEBUG:\n"+debug, 400, 190);
  } else {
    fill(0);
    stroke(255);
    rect(width/2, 200, 400, 100);
    fill(255);
    text("DEBUG:\n"+debug, 400, 190);
  }
}
