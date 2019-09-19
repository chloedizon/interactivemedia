//Sound
import processing.sound.*;
Sound s;
SinOsc sin;
float speed;
boolean randomSetup, randomAudioFlag = false;

//Buttons
boolean startBtnPressed, a1BtnPressed, a2BtnPressed, a3BtnPressed, a4BtnPressed, menuBackBtnPressed, gameBackBtnPressed; //Used to track every menu btn
int w1, w2, w3, w4; //Screen widths divded into 4 segments
int  h1, h2, h3, h4; //Screen height divded into 4 segments

void settings() {
  size(displayWidth*3>>2, displayHeight*3>>2);

  // Assume the every btn has not been pressed yet
  startBtnPressed = false;
  a1BtnPressed = false;
  a2BtnPressed = false;
  a3BtnPressed = false;
  a4BtnPressed = false;
  menuBackBtnPressed = false;
  gameBackBtnPressed = false;
  randomSetup = false;

  //Setup screen widths and heights
  w1 = width/4;
  w2 = width/2;
  w3 = 3*width/4;
  w4 = width;
  h1 = height/4;
  h2= height/2;
  h3 = 3 * height/4;
  h4 = height;
  
}
 
void setup() {
  //speed = 300;
  //// Play two sine oscillators with slightly different frequencies for a nice "beat".
  //sin = new SinOsc(this);
  //sin.play(300, 0.3);
  //sin = new SinOsc(this);
  //sin.play(305, 0.3);
  ////sin.freq(200);
  //// Create a Sound object for globally controlling the output volume.
  //s = new Sound(this);
  //randomSetup = true; 
 }

void draw() {
  background(255);

  if (startBtnPressed) {
    soundMenu();
  } else {
    // Show the start button and page
    fill(255);
    rect(w1, h2, w2, h1);
    fill(0);
    textSize(h1/2);
    text("Conductify", w2, h1/2);
    textSize(h1/8);
    textAlign(CENTER, TOP);
    text("Use your hands to navigate this application. Choose between set songs or randomly generated audio. Your right hand will control the tempo, while your left hand controls the volume.", w1, h2/2, w2, h4);

    textSize(h1/2);
    textAlign(CENTER, CENTER);
    text("START", w2, (h2 + h3)/2);

    if (mousePressed && mouseX > w1 && mouseX < w3 && mouseY >h2 && mouseY < h3) {
      startBtnPressed = true;
      delay(300); //Delayed, or else the mouse press will be too quick and will pick the audio level
    }
  }
}

void soundMenu() {

  if (a1BtnPressed) {
    soundApp("Audio 1");
  } else if (a2BtnPressed) {
    soundApp("Audio 2");
  } else if (a3BtnPressed) {
    soundApp("Audio 3");
  } else if (a4BtnPressed) {
    soundApp("Random Audio");
    randomAudioLoop();
  } else if (menuBackBtnPressed) {
    startBtnPressed = false;
    menuBackBtnPressed = false;
  } else {
    fill(255);
    rect(w1-10, h1-10, w1, h1);
    rect(w2 +10, h1 -10, w1, h1);
    rect(w1-10, h2 +10, w1, h1);
    rect(w2 +10, h2+10, w1, h1);
    rect(0, 0, w1/4, h1/4);

    fill(0);
    textSize(h1/4);
    textAlign(CENTER, CENTER);
    text("Pick your audio", w2, h1/2);

    text("Audio 1", (w1-10)+(w1/2), (h1-10)+(h1/2));
    text("Audio 2", (w2+10)+(w1/2), (h1-10)+(h1/2));
    text("Audio 3", (w1-10)+(w1/2), (h2+10)+(h1/2));
    text("Random Audio", (w2+10)+(w1/2), (h2+10)+(h1/2));

    textSize(h1/8);
    text("Back", 0, 0, w1/4, h1/4);

    checkMenuBtnPress();
  }
}

void checkMenuBtnPress() {
  if (mousePressed && mouseX > w1-10 && mouseX < w2-10 && mouseY >h1-10 && mouseY < h2-10) {
    a1BtnPressed = true;
  }

  if (mousePressed && mouseX > w2+10 && mouseX < w3+10 && mouseY >h1-10 && mouseY < h2-10) {
    a2BtnPressed = true;
  }

  if (mousePressed && mouseX > w1-10 && mouseX < w2-10 && mouseY >h2+10 && mouseY < h3+10) {
    a3BtnPressed = true;
  }

  if (mousePressed && mouseX > w2+10 && mouseX < w3+10 && mouseY >h2+10 && mouseY < h3+10) {
    a4BtnPressed = true;
    randomAudioFlag = true;
  }

  if (mousePressed && mouseX > 0 && mouseX < w1/4 && mouseY > 0 && mouseY < h1/4) {
    menuBackBtnPressed = true;
  }
}



void soundApp(String s) {
  //Here will be the actual code for the game
  background(255);
  fill(255);
  rect(0, 0, w1/4, h1/4);
  fill(0);
  textSize(h1/8);
  text("Back", 0, 0, w1/4, h1/4);
  text("Playing " + s, w2, h2);
  checkGameBtnPress();
}

void checkGameBtnPress() {
  if (mousePressed && mouseX > 0 && mouseX < w1/4 && mouseY > 0 && mouseY < h1/4) {
    gameBackBtnPressed = true;
    s.volume(0);
  }
  gameBtnPressed();
}

void gameBtnPressed() {
  if (gameBackBtnPressed) {
    delay(200);
    a1BtnPressed = false;
    a2BtnPressed = false;
    a3BtnPressed = false;
    a4BtnPressed = false;
    gameBackBtnPressed = false;
  }
 
}

//THIS IS THE AUDIO
//void randomAudioSetup(){
//  speed = 300;
//  // Play two sine oscillators with slightly different frequencies for a nice "beat".
//  sin = new SinOsc(this);
//  sin.play(300, 0.3);
//  sin = new SinOsc(this);
//  sin.play(305, 0.3);
//  //sin.freq(200);
//  // Create a Sound object for globally controlling the output volume.
//  s = new Sound(this);
//  randomSetup = true;
//}

void randomAudioLoop() {
  if (randomAudioFlag) {
    speed = 300;
    // Play two sine oscillators with slightly different frequencies for a nice "beat".
    sin = new SinOsc(this);
    sin.play(300, 0.3);
    sin = new SinOsc(this);
    sin.play(305, 0.3);
    //sin.freq(200);
    
    // Create a Sound object for globally controlling the output volume.
    s = new Sound(this);
    randomSetup = true;
    
    randomAudioFlag = false;
  }
  
  // Map vertical mouse position to volume.
  float amplitude = map(mouseY, 0, height, 1, 0.0);
  int val = int(map(mouseX, 0, width, 0, 800));
  // Instead of setting the volume for every oscillator individually, we can just
  // control the overall output volume of the whole Sound library.
  s.volume(amplitude);
  sin.freq(val);
  System.out.println(val);
  // sin.play(speed, 0.3);
}
