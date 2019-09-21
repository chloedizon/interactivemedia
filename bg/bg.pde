int ranRGBval = 360;
float randX = random(height);

void setup() {
  size(1920, 1080);
    background(0);
}

void draw() {
  colorMode(HSB,360, 100, 100);
  ranRGBval=ranRGBval-5;
   if (ranRGBval == 0) {
    ranRGBval = 360;
  }
  
    drawBackground();

  }


void drawBackground() {
  fill(0);
  fill(0, 10);
  noStroke();
  rect(0, 0, width, height);
  rotate(random(TWO_PI));
  translate(random(width), random(height));
  beginShape();
  fill(ranRGBval,100, 100);
  stroke(ranRGBval, 100, 100);
  ellipse(randX, randX, 40, 30);
  line(randX+20, randX-80, randX+20, randX);
  triangle(randX+20, randX-80, randX+40, randX-40, randX+20, randX-60);
  triangle(randX+30, randX-40, randX+40, randX-40, randX+20, randX-60);
   triangle(randX+30, randX-40, randX+40, randX-40, randX+30, randX-20);
  endShape(CLOSE);
}
