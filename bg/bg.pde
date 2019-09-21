
int num = 1; //How manx in one frame
int x = 100;
int ranRGBval = 360;

void setup() {
  size(1920, 1080);
  //frameRate(10);
    background(0);
}

void draw() {
  colorMode(HSB,360, 100, 100);
  ranRGBval=ranRGBval-5;
   if (ranRGBval == 0) {
    ranRGBval = 360;
  }
  //fill(200, 50, 100, alpha);
    //pushMatrix();
    //rotate(random(TWO_PI));
    //translate(random(width), random(height));
    drawBackground();
    //twinkle();
    //popMatrix();
  }


void drawBackground() {
  rotate(random(TWO_PI));
  translate(random(width), random(height));
  delay(100);
  beginShape();
   fill(ranRGBval,100, 100);
    stroke(ranRGBval, 100, 100);
    ellipse(x, x, 20, 15);
    line(x+10, x-40, x+10, x);
    triangle(x+10, x-40, x+20, x-20, x+10, x-30);
    triangle(x+15, x-20, x+20, x-20, x+10, x-30);
    triangle(x+15, x-20, x+20, x-20, x+15, x-10);
   delay(100);
  endShape(CLOSE);
}
