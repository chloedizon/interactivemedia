
class Label {
  float xPos, yPos, xPos2 = -1, yPos2 = -1;
  int align1, align2;
  String label;
  PFont font;
  color fontColour;
  
  Label(float x, float y, int a1, int a2, String l, PFont f, color fc) {
    xPos = x;
    yPos = y;
    align1 = a1;
    align2 = a2;
    label = l;
    font = f;
    fontColour = fc;
  }
  
  Label(float x, float y, int a1, int a2, String l, PFont f, color fc, float x2, float y2) {
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
  
  void display() {
    fill(fontColour);
    textFont(font);
    textAlign(align1, align2);
    if (xPos2 == -1 && yPos2 == -1) {
      text(label, xPos, yPos);
    } else {
      text(label, xPos, yPos, xPos2, yPos2);
    }
  }
}
