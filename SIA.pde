import ketai.sensors.*;

KetaiSensor sensor;
//GRADIENT HINZUFÜGEN METALLIC BLUE 

float orientationX=0;
float orientationZ=0;
float orientationY=0;

int motorLinks = 0;
int motorRechts = 0;

float uiLinks = 0;
float uiRechts = 0;

float zero = 0;

int x= width/2;
int y= width/2;

float[] arcLinks = new float[3]; // 1 fast 
float[] arcRechts = new float[3];

float UiMovementY;
float UiMovementZ;


/*
void settings(){
 fullScreen();
 smooth(16);
 }
 */

void setup()
{
  frameRate(60);
  size(1920,1080);
  sensor=new KetaiSensor(this);
  sensor.start();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
  //fullScreen(2);
}

////////////////////////
/*
void onAccelerometerEvent(float x, float y, float z)
 {
 beschleunigungX = (-x + beschleunigungX) * 0.5; // -x
 beschleunigungY = (-y + beschleunigungX) * 0.5; // -y
 beschleunigungZ = (-z + beschleunigungX) * 0.5; // -z
 }
 */
 void onOrientationEvent(float x, float y, float z)
 {
 orientationX = -x;//(-x + orientationX) * 0.5;
 orientationY = -y;//(-y + orientationY) * 0.5;
 orientationZ = -z - zero;//(-z + orientationZ) * 0.5;
 }
 
////////////////////////

void mousePressed() {
  println("Pressed: " + mouseX + " " + mouseY);                                                                              //BUG
  if (mouseX < 150 && mouseY < 150) {
    zero = orientationZ + zero;
  }
}

void draw()
{ 
  //orientationSensorMouse();



  float kippWinkelX= map(atan(constrain(orientationY, -30, 30) / 30)*180/PI, -45, 45, -1, 1);
  //float kippWinkelY= asin(orientationZ/orientationY)*180/PI;

  //kippWinkelY = map(orientationY, -30, 30, -1, 1);


  //uiLinks = constrain(orientationZ * kippWinkelX + orientationZ, -30, 30); // -
  //uiRechts = constrain(orientationZ * -kippWinkelX + orientationZ, -30, 30); //+

  uiLinks = constrain(orientationZ * kippWinkelX + orientationZ, -30, 30); // -
  uiRechts = constrain(orientationZ * -kippWinkelX + orientationZ, -30, 30); //+

  UiMovementY = map(orientationY, -30, 30, -60, 60);
  UiMovementZ = map(orientationZ, 30, -30, -60, 60);


  background(0, 34, 64);

  noStroke();  
  fill(1, 68, 127);
  ellipse(75, 75, 75, 75);
  strokeWeight(6);
  stroke(2, 137, 255);
  noFill();
  ellipse(75, 75, 50, 50);

  translate(UiMovementY, UiMovementZ);
  //%-ARC
  prozentArc(500, height / 2, uiLinks);
  prozentArc(1420, height / 2, uiRechts);

  //KREIS IN DER MITTE  
  ellipseMid(500, height / 2, uiLinks);
  ellipseMid(1420, height / 2, uiRechts);


  //%-ANZEIGE  
  percentageText(500, height / 2, uiLinks);
  percentageText(1420, height / 2, uiRechts);

  /*
  //ÄUßERE BÖGEN  
   arcSettings(uiLinks, 'L');
   arcSettings(uiRechts, 'R');
   arcs(500,height / 2, uiLinks, 'L');
   arcs(1420,height / 2, uiRechts, 'R');
   */



  arcSettings(0, true);
  arcSettings(0, false);













  //debug
  println(frameRate);
  //text(kippWinkelX, 1000, 500);
  //text(kippWinkelY, 1000, 700);


  //line(width / 2, 0, width / 2, height);
  //line(0, height / 2, width, height / 2);
}

void prozentArc(int x, int y, float speed) {
  //%-ARC
  noStroke();
  fill(2, 137, 255);
  if (speed > 0) {
    arc(x, y, 500, 500, 0, constrain(map(speed, 0, 30, 0, TWO_PI), 0, TWO_PI));
  } else {
    arc(x, y, 500, 500, constrain(map(speed, 0, 30, 0, TWO_PI), -TWO_PI, 0), 0);
  }
}

void ellipseMid(int x, int y, float speed) {
  fill(1, 68, 127);
  ellipse(x, y, constrain(map(abs(speed), 0, 30, 200, 350), 200, 350), constrain(map(abs(speed), 0, 30, 200, 350), 200, 350));
}

void percentageText(int x, int y, float speed) {
  fill(255, 255, 255);
  textSize(75);
  //text((int)(beschleunigungX * 10) + "%", 500, 500);
  text((int) constrain(map(speed, 0, 30, 0, 100), -100, 100) + "%", x, y);
}

void arcSettings(float speed, boolean LtrueRfalse) {

  stroke(2, 137, 255);
  strokeWeight(5);
  noFill();

  if (LtrueRfalse) {


    //for(int i = 0; i <){

    //}
    arcLinks[0] += constrain(map(uiLinks, -30, 30, -0.1, 0.1), -0.1, 0.1);
    arcLinks[1] += constrain(map(uiLinks, -30, 30, -0.2, 0.2), -0.2, 0.2);
    arcLinks[2] += constrain(map(uiLinks, -30, 30, -0.3, 0.3), -0.3, 0.3);

    arc(500, height / 2, 600, 600, HALF_PI + map(uiLinks, -30, 30, -0.5, 0.5) + arcLinks[0], PI + map(uiLinks, -30, 30, -0.5, 0.5) + arcLinks[0]);
    arc(500, height / 2, 700, 700, PI + map(uiLinks, -30, 30, -1, 1) + arcLinks[1], PI+QUARTER_PI + map(uiLinks, -30, 30, -1, 1) + arcLinks[1]);
    arc(500, height / 2, 800, 800, PI+QUARTER_PI + map(uiLinks, -30, 30, -1.5, 1.5) + arcLinks[2], TWO_PI + map(uiLinks, -30, 30, -1.5, 1.5) + arcLinks[2]);
  } else {
    arcRechts[0] += constrain(map(uiRechts, -30, 30, -0.1, 0.1), -0.1, 0.1);
    arcRechts[1] += constrain(map(uiRechts, -30, 30, -0.2, 0.2), -0.2, 0.2);
    arcRechts[2] += constrain(map(uiRechts, -30, 30, -0.3, 0.3), -0.3, 0.3);

    arc(1420, height / 2, 600, 600, HALF_PI + map(uiRechts, -30, 30, -0.5, 0.5) + arcRechts[0], PI + map(uiRechts, -30, 30, -0.5, 0.5) + arcRechts[0]);
    arc(1420, height / 2, 700, 700, PI + map(uiRechts, -30, 30, -1, 1) + arcRechts[1], PI+QUARTER_PI + map(uiRechts, -30, 30, -1, 1) + arcRechts[1]);
    arc(1420, height / 2, 800, 800, PI+QUARTER_PI + map(uiRechts, -30, 30, -1.5, 1.5) + arcRechts[2], TWO_PI + map(uiRechts, -30, 30, -1.5, 1.5) + arcRechts[2]);
  }
}

void arcs(int x, int y, float speed, char c) {
}
/*
void orientationSensorMouse() {
  //orientationX = 
  orientationY = constrain(map(mouseX, 1920, 0, -30, 30), -30, 30);
  orientationZ = constrain(map(mouseY, 1080, 0, -30, 30), -30, 30);
}
*/