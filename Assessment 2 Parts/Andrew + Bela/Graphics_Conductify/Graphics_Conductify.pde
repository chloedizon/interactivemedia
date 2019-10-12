//Created by 12876797 - Andrew Unsworth
//And by 12918304 - Isabela Hipolito

import beads.*;

//variables for the cubes
int cubesIndex = 0;
int cubesLength = 30;
Cube[] cubes = new Cube[cubesLength];
boolean cubesFull;
color fillColor;
color strokeColor;
boolean beat;

//variables for the beat detection
Frequency f;
AudioContext ac;
PeakDetector beatDetector;

void settings() {
  //dynamic window size depending on the size of the users screen
  size(int(displayWidth/1.25), int(displayHeight/1.25), P3D);
}

void setup() {  
  //AC is a link to audio hardware on computer
  ac = new AudioContext();
  
  //Load file into SamplePlayer
  String fileName = dataPath("Running in the 90_s.mp3");
  SamplePlayer player = new SamplePlayer(ac, SampleManager.sample(fileName));
  
  //Create Gain object, add sample as an input and g as an input to the audio context
  Gain g = new Gain(ac, 2, 0.5);
  g.addInput(player);
  ac.out.addInput(g);
  
  //Break the audio stream into manageable chunks
  ShortFrameSegmenter sfs = new ShortFrameSegmenter(ac);
  sfs.addInput(ac.out);
  
  //Calculates DFT, transforms waveform into sine components which allows for signal processing
  FFT fft = new FFT();
  
  //Gives a plot of the portion of a signal's power within frequency bins
  PowerSpectrum ps = new PowerSpectrum();
  sfs.addListener(fft);
  fft.addListener(ps);
  
  //44.1kHz is a commonplace 'sampling rate' for digital audio (industry standard)
  f = new Frequency(44100.0f);
  //Add listener to detect the frequency at different points in the sample
  ps.addListener(f);
  
  //Detects spectral difference betwen one frame and the next, used to produce Onsets for PeakDetector
  SpectralDifference sd = new SpectralDifference(ac.getSampleRate());
  ps.addListener(sd);
  
  //Detects peaks in sound, uses SD to get Onsets
  //Onset refers to beginning of a musical note or sound
  beatDetector = new PeakDetector();
  sd.addListener(beatDetector);
  
  //Used for changing sensitivity of beat detector
  beatDetector.setThreshold(0.8f);
  beatDetector.setAlpha(0.9f);
  
  //Listener for when a beat is detected
  beatDetector.addMessageListener(
    //Using beads as message handlers
    new Bead(){
      protected void messageReceived(Bead b)
      {
        beat = true;
      }
    }
  );
  
  ac.out.addDependent(sfs);
  ac.start();
  
  //background - set the colour mode to HSB (hue, saturation, brightness) for nicer colours..
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  //map the HSB colour values to mouse position on the screen. Ensures that the user can move their mouse across the whole screen to change colour rather than a limited range
  float x = map(mouseX, 0, width, 0, 360);
  float y = map(mouseY, 0, height, 0, 100);
  
  //change the background according to mouse position; x is used to determine Hue value, while y is used to determine Saturation value
  //Hue and Saturation were chosen to be dynamic since the background needed to stay dark (so the white sine wave can be seen in the final project)
  background(x, y, 60);
  
  //create a cube and cube array/add to the cube array when a beat is detected
  if(beat) {
    //Randomise fill and stroke for each new cube
    fillColor = color(random(255), random(255), random(255));
    strokeColor = color(random(255), random(255), random(255));
    
    //Get frequency of sound when a beat is detected
    float frequency = f.getFeatures();
    
    //Make sure cubes are not too big or small
    float cubeSize = frequency/(height/3) + 30;
    
    //Create new cube and append it to cubes array
    Cube cube = new Cube(cubeSize, fillColor, strokeColor, width/2, height/2, random(100, 300), random(100, 300));
    
    //set value of the specified index in the array as the cube
    cubes[cubesIndex] = cube;
    cubesIndex++;
    
    //Once array has been completely filled
    if (cubesIndex >= cubesLength) {
      cubesIndex = 0;
      cubesFull = true;
    }
    
    //sets beat to false so that the loop knows that all of the above has been completed for the set beat
    beat = !beat;
  }    
  
  //this loop runs when cubesFull is true i.e. the array has been filled with cubes
  if (cubesFull) {
    for (int i = 0; i < cubesLength; i++) {
      moveCubes(i);
    }
    //this loop runs cubesFull is false i.e. the array has not yet been filled with cubes
  } else {
    for (int i = 0; i < cubesIndex; i++) {
      moveCubes(i);
    }
  }
}

void moveCubes(int index) {
  //Display and move all cubes
  cubes[index].display();
  cubes[index].move();
}
