import com.leapmotion.leap.*;
import processing.sound.*; //imports processing sound module

// Sound
Sound s; //initialiser for the sound in random audio - allows for adjustment of volume
SinOsc sin1, sin2; //sin oscilators that create the sound for random audio
SoundFile audio; //plays the mp3 file loaded in audio 1, 2 and 3
float speed, volume; //used to adjust the rate and volume of the music in the sound file
boolean audioSetupFlag;

// Buttons
int w1, w2, w3, w4; //Screen widths divded into 4 segments
int  h1, h2, h3, h4; //Screen height divded into 4 segments
int ranRGBval = 255;  
PFont bannerFont;
PFont descriptionFont;

String page = "Home";
Button homeStartButton, backButton, menuTrack1Button, menuTrack2Button, menuCustomTrackButton, menuRandomAudioButton;
Label homeHeading, homeDescription, menuControllerMsg;

// Music Note Background
MusicNote[] notes = new MusicNote[60];
int noteCounter = 0;

// Music Wave
Controller controller = new Controller();
boolean controllerConnected;
int waveXSpacing, waveWidth;
float waveTheta, waveAmplitude, wavePeriod, waveDX, rightHandX, rightHandY, leftHandX, leftHandY, rightHandV;
float[] waveYValues, rightHandVs;

void settings() {
  size(displayWidth*3>>2, displayHeight*3>>2);
  
  // Music Wave Setup
  waveXSpacing = 16;
  waveWidth = width + waveXSpacing;
  waveTheta = 0.0;
  waveAmplitude = height/16;
  wavePeriod = width*2/3;
  waveYValues = new float[waveWidth/waveXSpacing];
  rightHandVs = new float[round(frameRate)];
}

void setup() {
  //Setup screen widths and heights
  w1 = width/4;
  w2 = width/2;
  w3 = 3*width/4;
  w4 = width;
  h1 = height/4;
  h2= height/2;
  h3 = 3 * height/4;
  h4 = height;
  
  colorMode(HSB,360, 100, 100);
  
  bannerFont = createFont("NEON CLUB MUSIC_medium.otf", h1/2);
  descriptionFont = createFont("VCR_OSD_MONO_1.001.ttf", h1/8);
  
  // ================================================================================================================================================================================================================================================================================================================================
  // BUTTON AND LABEL DECLARATIONS
  
  // Shared
  // Buttons
  backButton = new Button(0, 0, w1/4, h1/4, "Back", h1/8, descriptionFont, color(ranRGBval, 360, 260), color(0, 0, 360));
  
  // Home Screen
  // Buttons
  homeStartButton = new Button(w1, h2, w2, h1, "START", h1/2, descriptionFont, color(ranRGBval, 360, 260), color(0, 0, 360));
  // Labels
  homeHeading = new Label(w2, h1, CENTER, BOTTOM,  "Conductify", bannerFont, color(0, 0, 360));
  homeDescription = new Label(w1, h1*0.75, CENTER, BOTTOM, "Use your hands to navigate this application. Choose between set songs or randomly generated audio. Your right hand will control the tempo, while your left hand controls the volume.", descriptionFont, color(0, 0, 360), w2, h1);
  
  // Main Menu
  // Buttons
  menuTrack1Button = new Button(w1-10, h1-10, w1, h1, "Track 1", h1/4, descriptionFont, color(ranRGBval, 360, 260), color(0, 0, 360));
  menuTrack2Button = new Button(w2 +10, h1 -10, w1, h1, "Track 2", h1/4, descriptionFont, color(ranRGBval, 360, 260), color(0, 0, 360));
  menuCustomTrackButton = new Button(w1-10, h2 +10, w1, h1, "Upload", h1/4, descriptionFont, color(ranRGBval, 360, 260), color(0, 0, 360));
  menuRandomAudioButton = new Button(w2 +10, h2+10, w1, h1, "Random", h1/4, descriptionFont, color(ranRGBval, 360, 260), color(0, 0, 360));
  // Labels
  menuControllerMsg = new Label(w2, h1*0.5, CENTER, BOTTOM, "Leap Motion disconnected. Control Type: Mouse", descriptionFont, color(0, 0, 360));
  
}

void draw() {
  background(0);
  ranRGBval--;
  ranRGBval = ranRGBval == 0 ? 360 : ranRGBval;
  
  controllerConnected = controller.isConnected();

  switch(page) {
    case "Home":
      handleNotes();
      homeScreen();
      break;
    case "Menu":
      handleNotes();
      menuScreen();
      break;
    case "Track 1":
      gameScreen("Track 1");
      break;
    case "Track 2":
      gameScreen("Track 2");
      break;
    case "Upload":
      gameScreen("Upload");
      break;
    case "Random":
      gameScreen("Random");
      break;
    default:
      break;
  }
}

void handleNotes() {
  if (noteCounter != 4) {
    noteCounter++;
  } else {
    noteCounter = 0;
  }
  
  if (noteCounter == 4) {
    for (int i = 0; i < notes.length - 1; i++) {
      notes[i] = notes[i + 1];
    }
    
    notes[notes.length - 1] = new MusicNote(color(random(360), 100, 100));
  }
  
  for (int i = 0; i < notes.length; i++) {
    if (notes[i] instanceof MusicNote) {
      notes[i].display();
    }
  }
}

void homeScreen() {
  // Show the start button and page
  homeStartButton.display(ranRGBval);
  homeHeading.display();
  homeDescription.display();

  if (homeStartButton.isPressed()) {
    page = "Menu";
    homeStartButton.isDisplayed = false;
    delay(300);
  }
}

void menuScreen() {
  if (controllerConnected) {
    menuControllerMsg = new Label(w2, h1*0.5, CENTER, BOTTOM, "Leap Motion connected. Control Type: Leap Motion", descriptionFont, color(0, 0, 360));
  } else {
    menuControllerMsg = new Label(w2, h1*0.5, CENTER, BOTTOM, "Leap Motion disconnected. Control Type: Mouse", descriptionFont, color(0, 0, 360));
  }
  
  menuControllerMsg.display();
  
  backButton.display(ranRGBval);
  menuTrack1Button.display(ranRGBval);
  menuTrack2Button.display(ranRGBval);
  menuCustomTrackButton.display(ranRGBval);
  menuRandomAudioButton.display(ranRGBval);
  
  if (backButton.isPressed()) {
    page = "Home";
    
    backButton.isDisplayed = false;
    menuTrack1Button.isDisplayed = false;
    menuTrack2Button.isDisplayed = false;
    menuCustomTrackButton.isDisplayed = false;
    menuRandomAudioButton.isDisplayed = false;
    
    delay(300);
  }
  
  if (menuTrack1Button.isPressed() || menuTrack2Button.isPressed() || menuCustomTrackButton.isPressed() || menuRandomAudioButton.isPressed()) {
    audioSetupFlag = false;
    
    if (menuTrack1Button.isPressed()) page = "Track 1";
    if (menuTrack2Button.isPressed()) page = "Track 2";
    if (menuCustomTrackButton.isPressed()) page = "Upload";
    if (menuRandomAudioButton.isPressed()) page = "Random";
    
    backButton.isDisplayed = false;
    menuTrack1Button.isDisplayed = false;
    menuTrack2Button.isDisplayed = false;
    menuCustomTrackButton.isDisplayed = false;
    menuRandomAudioButton.isDisplayed = false;
    
    delay(300);
  }
}

void gameScreen(String type) {
  if (controllerConnected) {
    updateWaveVariables("Controller");
  } else {
    updateWaveVariables("Mouse");
  }
  
  if (type == "Random") {
    setRandomAudio();
  } else {
    setAudioFile(type);
  }
  
  renderWave();
   
  backButton.display(ranRGBval);
   
  if (backButton.isPressed()) {
    page = "Menu";
    
    stopAudio(type);
    
    backButton.isDisplayed = false;
    
    delay(300);
  }
}

void updateWaveVariables(String controlType) {
  if (controlType == "Controller") {
    Frame frame = controller.frame();
    
    if(frame.hands().count() == 2) {
      rightHandX = frame.hands().rightmost().palmPosition().getX();
      rightHandY = frame.hands().rightmost().palmPosition().getY();
      
      leftHandX = frame.hands().leftmost().palmPosition().getX();
      leftHandY = frame.hands().leftmost().palmPosition().getY();
      
      waveAmplitude = (leftHandY - 100) < 0 ? 1 : (leftHandY - 100) > height/2 ? height/2 - 1 : (leftHandY - 100);
      
      rightHandV = frame.hands().rightmost().palmVelocity().getX();
      rightHandV = abs(rightHandV) > 2*width/3 ? 2*width/3 : abs(rightHandV) < width/5 ? width/5 : abs(rightHandV);
      rightHandV = 2*width/3 - rightHandV;
      wavePeriod = round((calcAvgVelocity(rightHandV))/10)*10;
    }
  } else {
    waveAmplitude = map(mouseY, height, 0, 1, height/2 - 1);
    wavePeriod = map(mouseX, 0, width, width*2/3, width/5);
  }
  
  waveDX = (TWO_PI / wavePeriod) * waveXSpacing;
   
  waveTheta += 0.02;
 
  float x = waveTheta;
  for (int i = 0; i < waveYValues.length; i++) {
    waveYValues[i] = sin(x) * waveAmplitude;
    x += waveDX;
  }
}

float calcAvgVelocity(float v) {
  float count = 0;
  
  for (int i = 0; i < rightHandVs.length - 1; i++) {
    rightHandVs[i] = rightHandVs[i+1];
  }
  
  rightHandVs[rightHandVs.length-1] = v;
  
  for (int i = 0; i < rightHandVs.length; i++) {
    count += rightHandVs[i];
  }
  
  return count/rightHandVs.length;
}

void renderWave() {
  noStroke();
  fill(255);
  for (int i = 0; i < waveYValues.length; i++) {
    ellipse(i * waveXSpacing, height/2 + waveYValues[i], 16, 16);
  }
}

void setRandomAudio() {
  if (!audioSetupFlag) {
    sin1 = new SinOsc(this);
    sin1.play(350, 0.3);
    sin2 = new SinOsc(this);
    sin2.play(305, 0.3);
    
    s = new Sound(this);
    
    audioSetupFlag = true;
  }
  
  volume = map(waveAmplitude, 1, height/2 - 1, 0.01, 1);
  int freq1 = int(map(wavePeriod, width*2/3, width/5, 0.01, 300));
  int freq2 = int(map(wavePeriod, width*2/3, width/5, 0.01, 900));
  
  sin1.freq(freq1);
  sin2.freq(freq2);
  s.volume(volume);
}

void setAudioFile(String type) {
  if (!audioSetupFlag) {
    if (type == "Track 1") {
      audio = new SoundFile(this, "track1-cut.mp3");
      audio.loop();
    }
    else if (type == "Track 2") {
      audio = new SoundFile(this, "track2-cut.mp3");
      audio.loop();
    }
    else if (type == "Upload") selectInput("Select an audio sample...", "fileSelected");
    
    audioSetupFlag = true;
  }
  
  volume = map(waveAmplitude, 1, height/2 - 1, 0.01, 1); 
  speed = map(wavePeriod, width*2/3, width/5, 0.5, 2);
  audio.amp(volume);
  audio.rate(speed);
}

void fileSelected(File file) {
  audio = new SoundFile(this, file.getAbsolutePath());
  audio.loop();
}

void stopAudio(String type) {
  if (type == "Random") {
    sin1.stop();
    sin2.stop();
  } else {
    audio.stop();
  }
}
