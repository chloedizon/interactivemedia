
// Class to generate and display all music notes in the app.
class MusicNote {
  // Variable declarations.
  float rotationAngle, transX = -1, transY = -1;
  color noteColour;
  int alpha = 255;
  
  // Music note constructor function. 
  MusicNote(color colour) {
    noteColour = colour;
    rotationAngle = random(TWO_PI);
    // Ensures the translation X and Y coordinates are on the screen.
    while (transX < 0 || transX > width) {
      transX = random(width);
    }
    while (transY < 0 || transY > height) {
      transY = random(height);
    }
    
  }
  
  // Displays the music note.
  void display() {
    // Pushes the normal translation and rotation to a stack.
    pushMatrix();
    rotate(rotationAngle);
    translate(transX, transY);
    beginShape();
    fill(noteColour, alpha);
    stroke(noteColour, alpha);
    ellipse(0, 0, 40, 30);
    line(20, -80, 20, 0);
    triangle(20, -80, 40, -40, 20, -60);
    triangle(30, -40, 40, -40, 20, -60);
    triangle(30, -40, 40, -40, 30, -20);
    endShape(CLOSE);
    // Returns the translation and rotation angles to the originals stored in the stack.
    popMatrix();
    // Increments the fade of the music note.
    alpha -= 1;
  }
}
