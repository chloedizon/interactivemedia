
// Class to generate and display all labels in the app.
class Label {
  // Variable declarations.
  float xPos, yPos, xPos2 = -1, yPos2 = -1;
  int align1, align2;
  String label;
  PFont font;
  color fontColour;
  
  // First constructor, used when the user doesn't constrict the label to a text box.
  Label(float x, float y, int a1, int a2, String l, PFont f, color fc) {
    // Sets all label variables to those passed into the constructor.
    xPos = x;
    yPos = y;
    align1 = a1;
    align2 = a2;
    label = l;
    font = f;
    fontColour = fc;
  }
  
  // Second constructor, used when the user constricts the label to a text box, accessed through passing in 2 extra variables; x2 and y2.
  Label(float x, float y, int a1, int a2, String l, PFont f, color fc, float x2, float y2) {
    // Sets all label variables to those passed into the constructor.
    xPos = x;
    yPos = y;
    align1 = a1;
    align2 = a2;
    xPos2 = x2;
    yPos2 = y2;
    label = l;
    font = f;
    fontColour = fc;
  }
  
  // Displays the label.
  void display() {
    fill(fontColour);
    textFont(font);
    textAlign(align1, align2);
    // Checks whether the first or second constructor has been used.
    if (xPos2 == -1 && yPos2 == -1) {
      text(label, xPos, yPos);
    } else {
      text(label, xPos, yPos, xPos2, yPos2);
    }
  }
}
