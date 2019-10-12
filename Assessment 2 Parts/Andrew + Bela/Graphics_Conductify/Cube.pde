class Cube {
  float size;
  int direction;
  int fillColor;
  int strokeColor;
  float moveX;
  float moveY;
  
  float x;
  float y;
  float z;
  float rx;
  float ry;
  
  Cube(float size, color fillColor, color strokeColor, float x, float y, float rx, float ry) {    
    //Generate a random direction for the cube to fly from 1 to 4
    this.direction = int(random(1, 5));
    
    //Set variables for which direction the cube will move
    switch(direction) {
      case 1:
        //Move top left
        moveX = -1;
        moveY = -1;
        this.x = x/1.25;
        this.y = y/1.25;
        break;
      case 2:
        //Move top right
        moveX = 1;
        moveY = -1;
        this.x = x*1.2;
        this.y= y/1.25;
        break;
      case 3:
        //Move bottom left
        moveX = -1;
        moveY = 1;
        this.x = x/1.25;
        this.y= y*1.2;
        break;
      case 4:
        //Move bottom right
        moveX = 1;
        moveY = 1;
        this.x = x*1.2;
        this.y= y*1.2;
        break;  
    }
    
    //Initialise cube variables
    this.size = size;
    this.fillColor = fillColor;
    this.strokeColor = strokeColor;
    
    //Set rotation and z values
    this.z = -4000;
    this.rx = rx;
    this.ry = ry;
  }
  
  void move() {
    x += moveX;
    y += moveY;
    z += 75;
  }
  
  void display() {
    lights();
    fill(fillColor);
    stroke(strokeColor);
    
    pushMatrix();
    translate(x, y, z);
    rotateX(frameCount/rx);
    rotateY(frameCount/ry);
    box(size);
    popMatrix();
  }
}
