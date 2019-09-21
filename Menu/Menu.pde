//Sound
import processing.sound.*; //imports processing sound module
Sound s; //initialiser for the sound in random audio - allows for adjustment of volume
SinOsc sin1, sin2; //sin oscilators that create the sound for random audio
SoundFile audio; //plays the mp3 file loaded in audio 1, 2 and 3
float speed, volume; //used to adjust the rate and volume of the music in the sound file
boolean randomAudioFlag = false, randomAudioStop = false, 
        mooseSoundFlag = false, mooseSoundStop = false, 
        memSoundFlag = false, memSoundStop = false, 
        ukeSoundFlag = false, ukeSoundStop = false; //boolean flags and stops to play and stop all audio

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
    soundApp("Audio 1"); //plays Audio 1
  } else if (a2BtnPressed) {
    soundApp("Audio 2"); //plays Audio 2
  } else if (a3BtnPressed) {
    soundApp("Audio 3"); //plays Audio 3
  } else if (a4BtnPressed) {
    soundApp("Random Audio"); // plays random audio
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
    mooseSoundFlag = true; //sets the audio 1 flag to true to trigger the setup of audio 1
  }

  if (mousePressed && mouseX > w2+10 && mouseX < w3+10 && mouseY >h1-10 && mouseY < h2-10) {
    a2BtnPressed = true;
    memSoundFlag = true; //sets the audio 2 flag to true to trigger the setup of audio 2
  }

  if (mousePressed && mouseX > w1-10 && mouseX < w2-10 && mouseY >h2+10 && mouseY < h3+10) {
    a3BtnPressed = true;
    ukeSoundFlag = true; //sets the audio 3 flag to true to trigger the setup of audio 3
  }

  if (mousePressed && mouseX > w2+10 && mouseX < w3+10 && mouseY >h2+10 && mouseY < h3+10) {
    a4BtnPressed = true;
    randomAudioFlag = true; //sets the random audio flag to true to trigger the setup of random audio
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
  checkGameBtnPress(); //waits until back button is pressed
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
    //audio functions - waits until the sound/audio stop flag is triggered by the back button
    mooseSoundStop(); 
    memSoundStop();
    ukeSoundStop();
    randomAudioStop();
  }
 
}

//Audio 1 sound loop - it plays the audio moose.mp3
void mooseSoundLoop() {
  //setup loop
  if (mooseSoundFlag) {
    audio = new SoundFile(this, "moose.mp3");
    audio.play(); //starts the playback of the audio soundfile
    mooseSoundFlag = false; //stops the looping of the setup
  }
  //loop
  volume = map(mouseY, height, 0, 0, 1.0); //map remaps a number from one range to another i.e. for volume, the range is between 0 and 1. It will take the Y value of the mouse and adjust it to fit the volume. It's height to 0 because of the way processing maps the values i.e. height is the bottom and 0 is the top.
  speed = map(mouseX, 0, width, 1, 2); //remaps the value of the mouseX location to play the audio faster from it's normal speed to 2x its speed
  audio.amp(volume); //changes the amplitude/volume of the player by taking the mapped value from variable volume so the volume will get louder as the mouse moves up the screen
  audio.rate(speed); //sets the playback of the sound file to be faster as the mouse moves to the right. as a result the pitch of the music will also get higher.
}

//Audio 1 sound stop - function to stop the audio moose.mp3
void mooseSoundStop() {
  //when mooseSoundStop = true then the audio will stop, if not mooseSoundStop will run until it is true.
  if (mooseSoundStop) {
    audio.stop(); //stops the playback
  }
}

//Audio 2 sound loop - it plays the audio memories.mp3
void memSoundLoop() {
  //setup loop
  if (memSoundFlag) {
    audio = new SoundFile(this, "memories.mp3");
    audio.play(); //starts the playback of the audio soundfile
    memSoundFlag = false; //stops the looping of the setup
  }
  //loop
  volume = map(mouseY, height, 0, 0, 1.0); //map remaps a number from one range to another i.e. for volume, the range is between 0 and 1. It will take the Y value of the mouse and adjust it to fit the volume. It's height to 0 because of the way processing maps the values i.e. height is the bottom and 0 is the top.
  speed = map(mouseX, 0, width, 1, 2); //remaps the value of the mouseX location to play the audio faster from it's normal speed to 2x its speed
  audio.amp(volume); //changes the amplitude/volume of the player by taking the mapped value from variable volume so the volume will get louder as the mouse moves up the screen
  audio.rate(speed); //sets the playback of the sound file to be faster as the mouse moves to the right. as a result the pitch of the music will also get higher.
}

//Audio 2 sound stop - function to stop the audio memories.mp3
void memSoundStop() {
  //when mooseSoundStop = true then the audio will stop, if not memSoundStop will run until it is true.
  if (memSoundStop) {
    audio.stop(); //stops the playback
  }
}

//Audio 3 sound loop - function to play the audio ukulele.mp3
void ukeSoundLoop() {
  //setup loop
  if (ukeSoundFlag) {
    audio = new SoundFile(this, "ukulele.mp3");
    audio.play(); //starts the playback of the audio soundfile
    ukeSoundFlag = false; //stops the looping of the setup
  }
  //loop
  volume = map(mouseY, height, 0, 0, 1.0); //map remaps a number from one range to another i.e. for volume, the range is between 0 and 1. It will take the Y value of the mouse and adjust it to fit the volume. It's height to 0 because of the way processing maps the values i.e. height is the bottom and 0 is the top.
  speed = map(mouseX, 0, width, 1, 2); //remaps the value of the mouseX location to play the audio faster from it's normal speed to 2x its speed
  audio.amp(volume); //changes the amplitude/volume of the player by taking the mapped value from variable volume so the volume will get louder as the mouse moves up the screen
  audio.rate(speed); //sets the playback of the sound file to be faster as the mouse moves to the right. as a result the pitch of the music will also get higher.
}

//Audio 3 sound stop - function to stop the audio ukulele.mp3
void ukeSoundStop() {
  //when mooseSoundStop = true then the audio will stop, if not ukeSoundStop will run until it is true.
  if (ukeSoundStop) {
    audio.stop(); //stops the playback
  }
}

//Random Audio - function to play the audio generated from sin oscilators
void randomAudioLoop() {
  //setup loop
  if (randomAudioFlag) {
    // Play two sine oscillators with slightly different frequencies.
    sin1 = new SinOsc(this);
    sin1.play(350, 0.3);
    sin2 = new SinOsc(this);
    sin2.play(305, 0.3);
    
    // Create a Sound object for globally controlling the output volume.
    s = new Sound(this);
    
    randomAudioFlag = false; //stops the looping of the setup
  }
  //loop
  volume = map(mouseY, height, 0, 0, 1);  // Map vertical mouse position to volume.
  int freq1 = int(map(mouseX, 0, width, 0, 300)); //sets frequency of the oscilator for sin1
  int freq2 = int(map(mouseX, 0, width, 0, 900)); //sets frequency of oscilator for sin2
  
  sin1.freq(freq1); //sets the frequency for sin1 oscilator
  sin2.freq(freq2); //sets the frequency for sin2 oscilator
  s.volume(volume); // Instead of setting the volume for every oscillator individually, we can just control the overall output volume of the whole Sound library.
 
}

//Random Audio - function to stop the audio generated from sin oscilators
void randomAudioStop() {
   if (randomAudioStop) {
    sin1.stop(); //stops the sin oscilator sound for sin1
    sin2.stop(); //stops the sin oscilator sound for sin2
  }
}
