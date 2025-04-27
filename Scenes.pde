boolean isTitle = true;
boolean isEndscreen = false;
boolean isGame = false;
boolean isSettings = false;
PrintWriter optionsFile;
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
// Function for handling all the options file thingies, makes maintaining it SOOO much easier. Robust enough to handle the event of the file being deleted
void optionsFile(String option) {
  if (option == "LOAD") {
    try {
      options = loadStrings("data/options.txt");
      if (options.length == 0) {
        debug = false;
        enemyCount = 5;
        enemyVelocity = 5;
      } else {
        debug = boolean(options[0]);
        enemyCount = int(options[1]);
        enemyVelocity = int(options[2]);
      }
    }
    catch (NullPointerException NPE) {
      NPE.printStackTrace();
      println("Caught NPE, Dumping and restoring all affected values");
      debug = false;
      enemyCount = 5;
      enemyVelocity = 5;
    }
  } else if (option == "CLOSE") {
    optionsFile.println(debug);
    optionsFile.println(enemyCount);
    optionsFile.println(enemyVelocity);
    optionsFile.flush();
    println("OptionsFile Flushed");
    optionsFile.close();
    println("OptionsFile Closed");
  } else if (option == "CREATEWRITER"){
    optionsFile = createWriter("/data/options.txt");
    print("OptionsFileLoaded"); 
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
  // Play button
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
  // Setting options
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
  // Quit button
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
  UpdateEnemies();
  UpdateBullets();
  Player();
  fill(255);
  stroke(255);
  score();
}

void endscreen() {
  background(0);
  text("GameOver", width/2, 100);
}

void setting() {
  try {
    optionsFile = createWriter("/data/options.txt");
  }
  catch (NullPointerException e) {
    print("Failed to load OptionsFile");
    optionsFile = createWriter("/data/options.txt");
    print("Forceloaded OptionsFile");
  }
  background(0);
  fill(0);
  // Back Button
  if (mouseX>50 && mouseX<100 && mouseY>50 && mouseY<100) {
    stroke(255, 0, 255);
    square(75, 75, 50);
    shape(purpleBackButton, 50, 50, 50, 50);
  } else {
    stroke(255);
    square(75, 75, 50);
    shape(backButton, 50, 50, 50, 50);
  }

  fill(255);
  stroke(255);
  textSize(40);
  text("Settings:", width/2, 100);
  textSize(20);
  text("(Scroll)", 700, 360);
  text("(Scroll)", 700, 510);
  textSize(40);
  // Debug Option
  if (mouseX>200 && mouseX<600 && mouseY>150 && mouseY<250) { // Render the correct debug button based on mouse pos
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
  // Enemy Count Option
  if (mouseX>200 && mouseX<600 && mouseY>300 && mouseY<400) { // Render the correct enemycount button based on mouse pos
    fill(0);
    stroke(255, 0, 255);
    rect(width/2, 350, 400, 100);
    fill(255, 0, 255);
    text("EnemyCount:\n"+enemyCount, 400, 340);
  } else {
    fill(0);
    stroke(255);
    rect(width/2, 350, 400, 100);
    fill(255);
    text("EnemyCount:\n"+enemyCount, 400, 340);
  }
  // Enemy Speed Option
  if (mouseX>200 && mouseX<600 && mouseY>450 && mouseY<550) { // Render the correct enemycount button based on mouse pos
    fill(0);
    stroke(255, 0, 255);
    rect(width/2, 500, 400, 100);
    fill(255, 0, 255);
    text("EnemySpeed:\n"+enemyVelocity, 400, 490);
  } else {
    fill(0);
    stroke(255);
    rect(width/2, 500, 400, 100);
    fill(255);
    text("EnemySpeed:\n"+enemyVelocity, 400, 490);
  }
}
