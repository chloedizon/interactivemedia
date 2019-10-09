//Sound
import processing.sound.*; // imports processing sound module
Sound s; // initialiser for the sound in random audio - allows for adjustment of volume
SinOsc sin1, sin2; // sin oscilators that create the sound for random audio
SoundFile audio; // plays the mp3 file loaded in audio 1, 2 and uploaded audio
float speed, volume; // used to adjust the rate and volume of the music in the sound file
boolean audioSetupFlag; // Used to track whether the audio for each track has been set up. Used when a menu button is clicked.

//Buttons
int w1, w2, w3, w4; // Screen widths divded into 4 segments
int  h1, h2, h3, h4; // Screen height divded into 4 segments
int ranRGBval = 255;  // Used to smoothly transition HSB colours
PFont bannerFont; // Font used for banners/headers
PFont descriptionFont; // Font used for descriptive text
Button homeStartButton, backButton, menuTrack1Button, menuTrack2Button, menuCustomTrackButton, menuRandomAudioButton;

//Pages
String page = "Home"; // Used for our Swtich - The original should be home
Label homeHeading, homeDescription; // used to initialise Heading and Description on home page
MusicNote[] notes = new MusicNote[60]; // Array of music notes to display in the background. Array set to 60 items, therefore it can only contain up to 60 items.
int noteCounter = 0; // Used to determine when to dislplay a note.

// The settings() function allows us to use variables in the size() function.
void settings() {
  // Sets the app size dynamically based on the width of the users screen.
  size(displayWidth*3>>2, displayHeight*3>>2);
}

void setup() {
  // Setup screen widths and heights like 4x4 grid
  w1 = width/4;
  w2 = width/2;
  w3 = 3*width/4;
  w4 = width;
  h1 = height/4;
  h2= height/2;
  h3 = 3 * height/4;
  h4 = height;
  
  colorMode(HSB,360, 100, 100); //Setup colour mode to be HSB
  
  // Setup the fonts and their sizes
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
  
}

void draw() {
  background(0); // Sets the background to black.
  ranRGBval--; // Decrements the random RGB value of all buttons.
  ranRGBval = ranRGBval == 0 ? 360 : ranRGBval; // Java shorthand for an if statement; if ranRGBval == 0, set it to 360, else keep the original value.

  // Switch is used to change between 'pages' - works like an 'if else' for multiple cases
  // For different cases, different screens will show.
  switch(page) {
    case "Home":
      // handleNotes() function displays the background music notes.
      handleNotes();
      homeScreen();
      break;
    case "Menu":
      // handleNotes() function displays the background music notes.
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

// Function to display the background music notes, and track which ones to display.
void handleNotes() {
  // A note should be displayed every 4 frames. This increments the noteCounter variable to track this.
  if (noteCounter != 4) {
    // Adds one to noteCounter.
    noteCounter++;
  } else {
    noteCounter = 0;
  }
  
  // Once a note fades out completely, it gets replaced with a new MusicNote.
  
  // Runs every 4 frames.
  if (noteCounter == 4) {
    // For loop shifts each note down the array and makes room for one to be added at the end of the array.
    for (int i = 0; i < notes.length - 1; i++) {
      // Sets current index to the one after it, thereby shifting each index forward one place.
      // E.g. sets the 5th note to the 6th note, and so on till the 59th to the 60th. Leaves the 60th alone.
      notes[i] = notes[i + 1];
    }
    
    // Adds a new music note to the end of the array, the -1 is because arrays are indexed from 0.
    // Replaces the 60th element with a new Note.
    notes[notes.length - 1] = new MusicNote(color(random(360), 100, 100));
  }
  
  // Displays each note in the array to the screen.
  for (int i = 0; i < notes.length; i++) {
    // Checks whether the index in the notes array is a MusicNote. Prevents errors in the start of the program when the array isn't full of notes yet.
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

  // If start is pressed, go to menu page and stop showing home button
  if (homeStartButton.isPressed()) {
    page = "Menu";
    homeStartButton.isDisplayed = false;
    delay(100); // Mouse click is slower than FPS, needs delay so that user doesn't click twice into the next menu.
  }
}

void menuScreen() {
  // Always display these buttons on menu page with their random colours, pass in ranRGBval to update the colour.
  backButton.display(ranRGBval);
  menuTrack1Button.display(ranRGBval);
  menuTrack2Button.display(ranRGBval);
  menuCustomTrackButton.display(ranRGBval);
  menuRandomAudioButton.display(ranRGBval);
  
  // If back button pressed, go Home and stop showing menu buttons
  if (backButton.isPressed()) {
    page = "Home";
    
    backButton.isDisplayed = false;
    menuTrack1Button.isDisplayed = false;
    menuTrack2Button.isDisplayed = false;
    menuCustomTrackButton.isDisplayed = false;
    menuRandomAudioButton.isDisplayed = false;
    
    delay(100);
  }
  
  // If menu tracks are pressed, go to their respective page, stop showing menu buttons
  if (menuTrack1Button.isPressed() || menuTrack2Button.isPressed() || menuCustomTrackButton.isPressed() || menuRandomAudioButton.isPressed()) {
    audioSetupFlag = false; // Declares that the audio for the next screen has not been set up yet. Used so that the audio isn't reset with every frame. 
    // Makes sure that the audio isn't set up repeatedly in the loop making "zz zz zz zz" noise
    
    if (menuTrack1Button.isPressed()) page = "Track 1";
    if (menuTrack2Button.isPressed()) page = "Track 2";
    if (menuCustomTrackButton.isPressed()) page = "Upload";
    if (menuRandomAudioButton.isPressed()) page = "Random";
    
    backButton.isDisplayed = false;
    menuTrack1Button.isDisplayed = false;
    menuTrack2Button.isDisplayed = false;
    menuCustomTrackButton.isDisplayed = false;
    menuRandomAudioButton.isDisplayed = false;
    
    delay(100);
  }
}

// Setup for game screen. Go to screen chosen. if back button pressed go back to menu and stop the audio.
void gameScreen(String type) {
  // Checks for random audio, as it is handled differently to predetermined audio files.
  if (type == "Random") {
    setRandomAudio();
  } else {
    // Pass in the type of audio to play, either 'Track 1', 'Track 2', or 'Upload'.
    setAudioFile(type);
  }
   
  // Display the back button. 
  backButton.display(ranRGBval);
   
  // If the back button is pressed, go back to the menu, stop playing the music. 
  if (backButton.isPressed()) {
    page = "Menu";
    
    stopAudio(type);
    
    backButton.isDisplayed = false;
    
    delay(100);
  }
}

// Plays the random audio and updates its volume and frequency.
void setRandomAudio() {
  // Runs once on start of the function. Sets audioSetupFlag to true after completion.
  if (!audioSetupFlag) {
    sin1 = new SinOsc(this);
    sin1.play(350, 0.3); //sin1.play(frequency, amplitude)
    sin2 = new SinOsc(this);
    sin2.play(305, 0.3);
    
    s = new Sound(this);
    
    // Ensures audio isn't set up twice.
    audioSetupFlag = true;
  }
  
  // Maps mouse position to volume and frequency of the audio.
  volume = map(mouseY, height, 0, 0, 1);
  int freq1 = int(map(mouseX, 0, width, 0, 300));
  int freq2 = int(map(mouseX, 0, width, 0, 900));
  
  sin1.freq(freq1);
  sin2.freq(freq2);
  s.volume(volume);
}

// Plays the selected audio file and updates its volume and speed.
void setAudioFile(String type) {
  // Runs once on start of the function. Sets audioSetupFlag to true after completion.
  if (!audioSetupFlag) {
    // Runs a predetermined track.
    if (type == "Track 1") {
      audio = new SoundFile(this, "track1-cut.mp3");
      // Sets the track to loop so that once it finishes playing the user doesn't hear nothing.
      audio.loop();
    }
    // Runs a predetermined track.
    else if (type == "Track 2") {
      audio = new SoundFile(this, "track2-cut.mp3");
      // Sets the track to loop so that once it finishes playing the user doesn't hear nothing.
      audio.loop();
    }
    // Runs the track that the user selects, redirects to the fileSelected() function after track selection.
    else {
      selectInput("Select an audio sample...", "fileSelected");
    }
    
    // Ensures audio isn't set up twice.
    audioSetupFlag = true;
  }
  
  // Maps mouse position to volume and speed of the audio.
  volume = map(mouseY, height, 0, 0, 1.0); 
  speed = map(mouseX, 0, width, 1, 2);
  audio.amp(volume);
  audio.rate(speed);
}

void fileSelected(File file) {
  // Sets the sound file to the file the user selects.
  audio = new SoundFile(this, file.getAbsolutePath());
  // Sets the track to loop so that once it finishes playing the user doesn't hear nothing.
  audio.loop();
}

// Used to stop the audio when the user hits the back button.
void stopAudio(String type) {
  // Random audio is stopped differently to the predetermined tracks.
  if (type == "Random") {
    sin1.stop();
    sin2.stop();
  } else {
    audio.stop();
  }
}
