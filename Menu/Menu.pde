//Sound
import processing.sound.*;
Sound s;
SinOsc sin1, sin2;
SoundFile audio;
float speed, volume;
boolean randomAudioFlag = false, randomAudioStop = false, 
        mooseSoundFlag = false, mooseSoundStop = false, 
        memSoundFlag = false, memSoundStop = false, 
        ukeSoundFlag = false, ukeSoundStop = false;

//Buttons
boolean startBtnPressed, a1BtnPressed, a2BtnPressed, a3BtnPressed, a4BtnPressed, menuBackBtnPressed, gameBackBtnPressed; //Used to track every menu btn
int w1, w2, w3, w4; //Screen widths divded into 4 segments
int  h1, h2, h3, h4; //Screen height divded into 4 segments
int ranRGBval = 255;  
PFont bannerFont;
PFont descriptionFont;
int x = 100;

void settings() {
  size(displayWidth*3>>2, displayHeight*3>>2);
}

void setup() {
 // Assume the every btn has not been pressed yet
  startBtnPressed = false;
  a1BtnPressed = false;
  a2BtnPressed = false;
  a3BtnPressed = false;
  a4BtnPressed = false;
  menuBackBtnPressed = false;
  gameBackBtnPressed = false;

  //Setup screen widths and heights
  w1 = width/4;
  w2 = width/2;
  w3 = 3*width/4;
  w4 = width;
  h1 = height/4;
  h2= height/2;
  h3 = 3 * height/4;
  h4 = height;
  
  bannerFont = createFont("NEON CLUB MUSIC_medium.otf", h1/2);
  descriptionFont = createFont("VCR_OSD_MONO_1.001.ttf", h1/8);
}

void draw() {
  background(0);
  colorMode(HSB,360, 100, 100);
  ranRGBval--;
   if (ranRGBval == 0) {
    ranRGBval = 360;
  }


  if (startBtnPressed) {
    soundMenu();
  } else {
    // Show the start button and page
    fill(ranRGBval,360,260);
    rect(w1, h2, w2, h1);
    fill(0,0,360);
    textFont(bannerFont);
       textAlign(CENTER, BOTTOM);
    text("Conductify", w2, h1);
    textFont(descriptionFont);
    text("Use your hands to navigate this application. Choose between set songs or randomly generated audio. Your right hand will control the tempo, while your left hand controls the volume.", w1, h1*0.75,w2,h1);
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
  } else if (menuBackBtnPressed) {
    startBtnPressed = false;
    menuBackBtnPressed = false;
  } else {
    fill(ranRGBval,360,260);
    rect(w1-10, h1-10, w1, h1);
    rect(w2 +10, h1 -10, w1, h1);
    rect(w1-10, h2 +10, w1, h1);
    rect(w2 +10, h2+10, w1, h1);
    rect(0, 0, w1/4, h1/4);

    fill(0,0,360);
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
    mooseSoundFlag = true;
  }

  if (mousePressed && mouseX > w2+10 && mouseX < w3+10 && mouseY >h1-10 && mouseY < h2-10) {
    a2BtnPressed = true;
    memSoundFlag = true;
  }

  if (mousePressed && mouseX > w1-10 && mouseX < w2-10 && mouseY >h2+10 && mouseY < h3+10) {
    a3BtnPressed = true;
    ukeSoundFlag = true;
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
  fill(0);
  rect(0, 0, w1/4, h1/4);
  fill(0,0,360);
  textSize(h1/8);
  text("Back", 0, 0, w1/4, h1/4);
  text("Playing " + s, w2, h2);
  //when any game button is triggered it will go to sound app. To play the specific audio chosen, the if statement will take the text of that audio and play the loop assigned to that button.
  //Setting mooseSoundStop to true in this if statement, means that when the user presses the back button, it will stop the moose audio without needing to store what s was before the back button was pressed.
  if (s == "Audio 1") {
    mooseSoundLoop();
    mooseSoundStop = true;
  }
  if (s == "Audio 2") {
    memSoundLoop();
    memSoundStop = true;
  }
  if (s == "Audio 3") {
    ukeSoundLoop();
    ukeSoundStop = true;
  }
  if (s == "Random Audio") {
    randomAudioLoop();
    randomAudioStop = true;
  }
  checkGameBtnPress();
}

void checkGameBtnPress() {
  if (mousePressed && mouseX > 0 && mouseX < w1/4 && mouseY > 0 && mouseY < h1/4) {
    gameBackBtnPressed = true;
  }
  gameBtnPressed();
}

void gameBtnPressed() {
  if (gameBackBtnPressed) {
    delay(300);
    a1BtnPressed = false;
    a2BtnPressed = false;
    a3BtnPressed = false;
    a4BtnPressed = false;
    gameBackBtnPressed = false;
    mooseSoundStop();
    memSoundStop();
    ukeSoundStop();
    randomAudioStop();
  }
 
}

//Audio 1 sound loop - it plays the audio moose.mp3
void mooseSoundLoop() {
  if (mooseSoundFlag) {
    audio = new SoundFile(this, "moose.mp3");
    audio.play();
    mooseSoundFlag = false;
  }
  volume = map(mouseY, height, 0, 0, 1.0);
  speed = map(mouseX, 0, width, 1, 2);
  audio.amp(volume);
  audio.rate(speed);
}

//Audio 1 sound stop - function to stop the audio moose.mp3
void mooseSoundStop() {
  //when mooseSoundStop = true then the audio will stop, if not mooseSoundStop will run until it is true.
  if (mooseSoundStop) {
    audio.stop();
  }
}

//Audio 2 sound loop - it plays the audio memories.mp3
void memSoundLoop() {
  if (memSoundFlag) {
    audio = new SoundFile(this, "memories.mp3");
    audio.play();
    memSoundFlag = false;
  }
  volume = map(mouseY, height, 0, 0, 1.0);
  speed = map(mouseX, 0, width, 1, 2);
  audio.amp(volume);
  audio.rate(speed);
}

//Audio 2 sound stop - function to stop the audio memories.mp3
void memSoundStop() {
  //when mooseSoundStop = true then the audio will stop, if not mooseSoundStop will run until it is true.
  if (memSoundStop) {
    audio.stop();
  }
}

//Audio 3 sound loop - function to play the audio ukulele.mp3
void ukeSoundLoop() {
  if (ukeSoundFlag) {
    audio = new SoundFile(this, "ukulele.mp3");
    audio.play();
    ukeSoundFlag = false;
  }
  volume = map(mouseY, height, 0, 0, 1.0);
  speed = map(mouseX, 0, width, 1, 2);
  audio.amp(volume);
  audio.rate(speed);
}

//Audio 3 sound stop - function to stop the audio ukulele.mp3
void ukeSoundStop() {
  //when mooseSoundStop = true then the audio will stop, if not mooseSoundStop will run until it is true.
  if (ukeSoundStop) {
    audio.stop();
  }
}

//Random Audio - function to play the audio generated from sin oscilators
void randomAudioLoop() {
  if (randomAudioFlag) {
    speed = 300;
    // Play two sine oscillators with slightly different frequencies for a nice "beat".
    sin1 = new SinOsc(this);
    sin1.play(300, 0.3);
    sin2 = new SinOsc(this);
    sin2.play(305, 0.3);
    
    // Create a Sound object for globally controlling the output volume.
    s = new Sound(this);
    
    randomAudioFlag = false;
  }
  
  // Map vertical mouse position to volume.
  float amplitude = map(mouseY, 0, height, 1, 0.0);
  int val = int(map(mouseX, 0, width, 0, 800));
  // Instead of setting the volume for every oscillator individually, we can just control the overall output volume of the whole Sound library.
  s.volume(amplitude);
  sin2.freq(val);
}

//Random Audio - function to stop the audio generated from sin oscilators
void randomAudioStop() {
   if (randomAudioStop) {
    sin1.stop();
    sin2.stop();
  }
}
