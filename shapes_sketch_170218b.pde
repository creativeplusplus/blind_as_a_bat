float redDistance = 0;
float greenDistance = 0;
float blueDistance = 0;

float x = 0;
float y = 0;

float loc1_x = 0;
float loc1_y = 0;
float loc2_x = 0;
float loc2_y = 0;
float loc3_x = 0;
float loc3_y = 0;

// Initialize shape size vars
float shapeSize1 = 0;
float shapeSize2 = 0;
float shapeSize3 = 0;

float offsetShape1 = 0;
float offsetShape2 = 0;
float offsetShape3 = 0;

// OSC FLOATS
float player1_x = 0;
float player1_y = 0;
float player2_x = 0;
float player2_y = 0;

// OSC Imports
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;


void setup() {
  size(500,500);
  background(0);
  frameRate(25);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("192.168.2.179",8888);
  
  //create 3 random shapes
  shape1();
  shape2();
  shape3();
  
  // Boundary Detection
  shapeDetection();
  
  // Disttance
  distance();
  
  
  println("loc1_x= " + loc1_x);
  println("loc1_y= " + loc1_y);
  
  println("loc2_x= " + loc2_x);
  println("loc2_y= " + loc2_y);
  
  println("loc3_x= " + loc3_x);
  println("loc3_y= " + loc3_y);
  
  
}

void draw() {
  //printOut();
  
  shapeDetection();
  player1();
 
 
}

void shape1() {  // RED SHAPE
  fill(255,0,0);
  shapeSize1 = random(30,100); // Randomize shape size var
  offsetShape1 = shapeSize1; // Calcs to keep shapes on the board
  loc1_x = int(random(50, width - offsetShape1));
  loc1_y = int(random(50, width - offsetShape1));
  rect(loc1_x, loc1_y,shapeSize1,shapeSize1);
  collisionDetect();
}

void shape2() { // GREEN SHAPE
  fill(0,255,0);
  shapeSize2 = random(30,100); // Randomize shape size var
  offsetShape2 = shapeSize2; // Calcs to keep shapes on the board
  loc2_x = int(random(50, width - offsetShape2));
  loc2_y = int(random(50, width - offsetShape2));
  rect(loc2_x, loc2_y,shapeSize2,shapeSize2);
  collisionDetect();
}

void shape3() { // BLUE SHAPE
  fill(0,0,255);
  shapeSize3 = random(30,100); // Randomize shape size var
  offsetShape3 = shapeSize3; // Calcs to keep shapes on the board
  loc3_x = int(random(50, width - offsetShape3));
  loc3_y = int(random(50, width - offsetShape3));
  rect(loc3_x, loc3_y,shapeSize3,shapeSize3); 
  collisionDetect();
 
}

void printOut() {
  //loop();
  //println(mouseX,mouseY); 
}

void collisionDetect(){ // Detects if shapes overlap. If they do, regenerate a new shape elsewhere.
  if(loc2_x >= loc1_x && loc2_x <= loc1_x + shapeSize1){
    if(loc2_y >= loc1_y && loc2_y <= loc1_y + shapeSize1){
      
    }
  }
  else if(loc3_x >= loc2_x && loc3_x <= loc2_x + shapeSize2){
    if(loc3_y >= loc2_y && loc3_y <= loc2_y + shapeSize2){
      
    }
  }
  else if(loc1_x >= loc3_x && loc1_x <= loc3_x + shapeSize3){
    if(loc1_y >= loc3_y && loc1_y <= loc3_y + shapeSize3){
      
    }
  }
}

void shapeDetection(){ // Detects when mouse object enters shape boundary
 
  if (player1_x >= loc1_x && player1_x <= loc1_x + shapeSize1 ){
    if (player1_y >= loc1_y && player1_y <= loc1_y + shapeSize1 ){
      println("RED DETECTION");
      winnerRed();
    }
  }
  else if (player1_x >= loc2_x && player1_x <= loc2_x + shapeSize2 ){
     if (player1_y >= loc2_y && player1_y <= loc2_y + shapeSize2 ){
      println("GREEN DETECTION");
      winnerGreen();
    }
  }
  else if (player1_x >= loc3_x && player1_x <= loc3_x + shapeSize2 ){
     if (player1_y >= loc3_y && player1_y <= loc3_y + shapeSize2 ){
      println("BLUE DETECTION");
      winnerBlue();
     }
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
  //println(" typetag: "+theOscMessage.get(0).floatValue());
  if (theOscMessage.checkAddrPattern("/player1")==true) {
    player1_x = theOscMessage.get(0).floatValue();
    player1_y = theOscMessage.get(1).floatValue();
    //println("p1_dir" + player1_dir);
    //println("p1_dir" + player1_dir);
    
  }
  else if (theOscMessage.checkAddrPattern("/player2")==true) {
    player2_x = theOscMessage.get(0).floatValue();
    player2_y = theOscMessage.get(1).floatValue();
    //println("p2_vel" + player2_vel);
    //println("p2_dir" + player2_dir);
  }
}

/*
void keyPressed() {
  rect(x, y, 25, 25);
  if (key == CODED) {
    if (keyCode == RIGHT) {
      x = x + 1 * 10;
    } else if (keyCode == DOWN) {
      y= y + 1 * 10;
    } else if (keyCode == UP) {
      y= y - 1 * 10;
    } else if (keyCode == LEFT) {
      x= x - 1 * 10;
    }
  }
}
*/

void player1(){
  fill(200,200,0);
  rect(player1_x,player1_y, 25,25);
  shapeDetection();
  distance();
  oscSend();
}

void distance(){
  redDistance = dist(player1_x, player1_y, loc1_x + shapeSize1, loc1_y + shapeSize1);
  //println("reddist=" + redDistance);
  greenDistance = dist(player1_x, player1_y, loc2_x + shapeSize2, loc2_y + shapeSize2);
  //println("grndist=" + greenDistance);
  blueDistance = dist(player1_x, player1_y, loc3_x + shapeSize3, loc3_y + shapeSize3);
  //println("bluedist=" + blueDistance);
}


void oscSend(){
  // RED DISTANCE
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessageRed = new OscMessage("/player1/distRed");
  myMessageRed.add(redDistance); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageRed, myRemoteLocation); 
  
  // GREEN DISTANCE
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessageGreen = new OscMessage("/player1/distGreen");
  myMessageGreen.add(greenDistance); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageGreen, myRemoteLocation); 
  
  // BLUE DISTANCE
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessageBlue = new OscMessage("/player1/distBlue");
  myMessageBlue.add(blueDistance); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageBlue, myRemoteLocation); 

}

void winnerRed(){
    // RED DISTANCE
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessageRedWin = new OscMessage("/player1/winRed");
  myMessageRedWin.add("win"); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageRedWin, myRemoteLocation); 
  println(myMessageRedWin);
  delay(1000);
  
}

void winnerGreen(){
    // RED DISTANCE
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessageGreenWin = new OscMessage("/player1/winGreen");
  myMessageGreenWin.add("win"); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageGreenWin, myRemoteLocation); 
  println(myMessageGreenWin);
  delay(1000);
  
}
void winnerBlue(){
    // RED DISTANCE
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessageBlueWin = new OscMessage("/player1/winBlue");
  myMessageBlueWin.add("win"); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageBlueWin, myRemoteLocation);
  println(myMessageBlueWin);
  delay(1000);
}
  
void mousePressed(){ 
   OscMessage myMessageReset = new OscMessage("/player1/reset");
  myMessageReset.add("reset"); /* add an int to the osc message *
  /* send the message */
  oscP5.send(myMessageReset, myRemoteLocation);
  println(myMessageReset);
  delay(1000);
  setup();
  
}