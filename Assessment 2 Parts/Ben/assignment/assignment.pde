import com.leapmotion.leap.*;

Controller controller = new Controller();

int xspacing;                       // How far apart should each horizontal location be spaced
int w;                              // Width of entire wave

float theta;                        // Start angle at 0
float amplitude;                    // Height of wave
float period;                       // How many pixels before the wave repeats
float dx;                           // Value for incrementing X, a function of period and xspacing
float[] yvalues;                    // Using an array to store height values for the wave

float rightX;
float rightY;

float leftX;
float leftY;

float rightVelocity;
float[] velocities = new float[round(frameRate)];

void settings() {
  size(displayWidth*3>>2, displayHeight*3>>2);
  xspacing = 16;
  w = width+16;
  theta = 0.0;
  amplitude = height/16;
  period = 2*width/3;
  yvalues = new float[w/xspacing];
}

void setup() {

}

void draw() {
  background(0);
  
  Frame frame = controller.frame();
  
  if(frame.hands().count() == 2) {
    rightX = frame.hands().rightmost().palmPosition().getX();
    rightY = frame.hands().rightmost().palmPosition().getY();
    
    leftX = frame.hands().leftmost().palmPosition().getX();
    leftY = frame.hands().leftmost().palmPosition().getY();
    
    amplitude = (leftY - 100) < 0 ? 1 : (leftY - 100) > height/2 ? height/2 - 1 : (leftY - 100);
    
    rightVelocity = frame.hands().rightmost().palmVelocity().getX();
    rightVelocity = abs(rightVelocity) > 2*width/3 ? 2*width/3 : abs(rightVelocity);
    rightVelocity = 2*width/3 - rightVelocity;
    period = round((calcAvgVelocity(rightVelocity))/10)*10;
  }
  
  dx = (TWO_PI / period) * xspacing;
  
  textSize(30);
  text(frame.hands().count() + " ", 10, 40);
  text(controller.isConnected() + " ", 10, 80);
  text(controller.isServiceConnected() + " ", 10, 120);
  
  calcWave();
  renderWave();
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}

void renderWave() {
  noStroke();
  fill(255);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
  }
}

float calcAvgVelocity(float v) {
  float count = 0;
  
  for (int i = 0; i < velocities.length - 1; i++) {
    velocities[i] = velocities[i+1];
  }
  
  velocities[velocities.length-1] = v;
  
  for (int i = 0; i < velocities.length; i++) {
    count += velocities[i];
  }
  
  System.out.println(count/velocities.length);
  
  return count/velocities.length;
}
