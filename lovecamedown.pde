//
ArrayList<TriangleClass> triangles;
//
// ---------------------------------------------------------------
//

import processing.video.*;

// Size of each cell in the grid, ratio of window size to video size
int videoScale = 8;
// Number of columns and rows in our system
int cols, rows;
// Variable to hold onto Capture object
Capture video;


void setup()
{
  // init
  size(displayWidth, displayHeight);
  
  video = new Capture(this, displayWidth,displayHeight);
  video.start();
  //  frameRate(3);
  //Size of the triangles
  int widthX= 35;
  int widthY= 35;
  //#'s of triangles to display
  int row = 20;
  int column = 35;
  int widthXhalf= widthX/2;
  int widthYhalf= widthY/2;
  triangles = new ArrayList<TriangleClass>();  // Create an empty ArrayList
  // the broad side up
  for (int y1=0; y1 < row*widthY; y1+=widthY) {
    for (int x1=0; x1 < column*widthX; x1+=widthX) {
      // for the Color :
      color MyC1 = color( random (255), random (255), random (255)); 
      //color MyC1 = color( 22, (x1 % 2) == 0 ? 0 : 255, 22 );
      // color MyC1 = color (255, 0, 0);
      // color MyC1 = color (0);
      // A new TriangleClass object is added to the ArrayList (by default to the end)
      triangles.add(new TriangleClass(
      x1-widthXhalf, y1,
      x1+widthXhalf, y1,
      x1, y1+widthY,
      MyC1 ));
    }
  }
  // 
  // the broad side down
  for (int y1=0; y1 < row*widthY; y1+=widthY) {
    for (int x1=0; x1 < column*widthX; x1+=widthX) {
      // for the Color :
      //color MyC1 = color(  (x1 % 2) == 0 ? 0 : 255, 22, 22);
      color MyC1 = color( random (0), random (0), random (255));  
      // color MyC1 = color (0, 255, 0);
      // color MyC1 = color (0);
      // A new TriangleClass object is added to the ArrayList (by default to the end)
      triangles.add(new TriangleClass(
      x1+2*widthXhalf, y1+widthY,
      x1+widthXhalf, y1,
      x1-0, y1+widthY,
      MyC1 ));
    }
  }
  noStroke();
} // func
//
//
void draw()
{
   // Read image from the camera
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  

  TriangleClass myCurrentTriangle ;
  //
  for (int i=0; i < triangles.size(); i++) {
    // get object from ArrayList
    myCurrentTriangle = triangles.get(i);
    color blue = color(0, 152, 153);
    color c = video.pixels[(video.width-myCurrentTriangle.z1) + myCurrentTriangle.z2*video.width];
    color bluetint = blendColor(int(brightness(c)), blue, ADD);
    myCurrentTriangle.myColor = bluetint;
    myCurrentTriangle.display();
  } // for
} // func
//


// =====================================================================
// Simple class
class TriangleClass {
  //
  float x1, y1, x2, y2, x3, y3;    // points
  color myColor;                  // fill color
  float twothird = 2.0/3.0;
  float tempZ1, tempZ2; 
  int z1, z2;  //center position
  //
  // constructor
  TriangleClass(
  float tempX1, float tempY1,
  float tempX2, float tempY2,
  float tempX3, float tempY3,
  color tempmyColor1 ) {
    x1 = tempX1;
    y1 = tempY1;
    x2 = tempX2;
    y2 = tempY2;
    x3 = tempX3;
    y3 = tempY3;   
    myColor=tempmyColor1;
    tempZ1 = tempX2+(tempX3-tempX2)/2;
    tempZ2 = tempY2+(tempY3-tempY2)/2;
    z1 = int(tempX1 + (tempZ1-tempX1)*twothird);
    z2 = int(tempY1 + (tempZ2-tempY1)*twothird);
   
    
  }  // constructor

  void display() {
    // show rectangle
    fill(myColor);
    triangle(x1, y1, x2, y2, x3, y3);
  } // func
  //
} // class
// =====================================================================
