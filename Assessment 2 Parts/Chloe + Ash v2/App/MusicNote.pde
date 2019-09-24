
class MusicNote {
  float rotationAngle, transX = -1, transY = -1;
  color noteColour;
  int alpha = 255;
  
  //BEN PLZ EXPLAIN
  MusicNote(color colour) {
    noteColour = colour;
    rotationAngle = random(TWO_PI);
    while (transX < 0 || transX > width) {
      transX = random(width);
    }
    while (transY < 0 || transY > height) {
      transY = random(height);
    }
    
  }
  
  void display() {
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
    popMatrix();
    alpha -= 1;
  }
}
