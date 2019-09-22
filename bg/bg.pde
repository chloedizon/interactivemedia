MusicNote[] notes = new MusicNote[30];
int count = 8;

void settings() {
  size(displayWidth*3/4, displayHeight*3/4);
}

void setup() {
  colorMode(HSB,360, 100, 100);
}

void draw() {
  background(0);
  
  handleNotes();
  
  if (count != 8) {
    count++;
  } else {
    count = 0;
  }
}


void handleNotes() {  
  if (count == 8) {
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
