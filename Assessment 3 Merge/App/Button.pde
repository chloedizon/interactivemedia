
class Button {
  float xPos, yPos, bWidth, bHeight;
  PFont bFont;
  String bLabel;
  int bFontSize;
  boolean isDisplayed;
  color bColour, lColour;
  
  Button(float x, float y, float w, float h, String label, int fontSize, PFont font, color button_colour, color label_colour) {
    xPos = x;
    yPos = y;
    bWidth = w;
    bHeight = h;
    bFontSize = fontSize;
    bFont = font;
    bLabel = label;
    bColour = button_colour;
    lColour = label_colour;    
  }
  
  void display(int hue) {
    bColour = color(hue, saturation(bColour), brightness(bColour));
    fill(bColour);
    rect(xPos, yPos, bWidth, bHeight);
    textFont(bFont);
    textSize(bFontSize);
    textAlign(TOP, LEFT);
    fill(lColour);
    text(bLabel, xPos + bWidth/2 - textWidth(bLabel)/2, yPos + bHeight/2 + textAscent()/2);
    isDisplayed = true;
  }
  
  boolean isPressed() {
    if(mousePressed && isDisplayed && mouseX >= xPos && mouseX <= xPos + bWidth && mouseY >= yPos && mouseY <= yPos + bHeight) {
      return true;
    }
    return false;
  }
  
  void setDisplayed(boolean flag) {
    isDisplayed = flag;
  }
}
