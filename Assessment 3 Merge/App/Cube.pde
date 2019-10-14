class Cube {
  float cSize, xPos, yPos, zPos, xRotation, yRotation, moveX, moveY;
  int direction, cFillColor, cStrokeColor;
  
  Cube(float size, color fillColor, color strokeColor, float x, float y, float rx, float ry) {    
    //Generate a random direction for the cube to fly from 1 to 4
    direction = int(random(1, 5));
    
    //Set variables for which direction the cube will move
    switch(direction) {
      case 1:
        //Move top left
        moveX = -1;
        moveY = -1;
        xPos = x/1.25;
        yPos = y/1.25;
        break;
      case 2:
        //Move top right
        moveX = 1;
        moveY = -1;
        xPos = x*1.2;
        yPos = y/1.25;
        break;
      case 3:
        //Move bottom left
        moveX = -1;
        moveY = 1;
        xPos = x/1.25;
        yPos = y*1.2;
        break;
      case 4:
        //Move bottom right
        moveX = 1;
        moveY = 1;
        xPos = x*1.2;
        yPos = y*1.2;
        break;  
    }
    
    //Initialise cube variables
    cSize = size;
    cFillColor = fillColor;
    cStrokeColor = strokeColor;
    
    //Set rotation and z values
    zPos = -4000;
    xRotation = rx;
    yRotation = ry;
  }
  
  void move() {
    xPos += moveX;
    yPos += moveY;
    zPos += 75;
  }
  
  void display() {
    lights();
    fill(cFillColor);
    stroke(cStrokeColor);
    
    pushMatrix();
    translate(xPos, yPos, zPos);
    rotateX(frameCount/xRotation);
    rotateY(frameCount/yRotation);
    box(cSize);
    popMatrix();
  }
}
