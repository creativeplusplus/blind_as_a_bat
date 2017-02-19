float player1_vel = 0;
float player1_dir = 0;
float player2_vel = 0;
float player2_dir = 0;

float s =0;

/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  //frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  background(0);  
  //rotateTest();
  
  fill(200);
  s = player1_dir;
  pushMatrix();
  translate(width/2,height/2);
  rotate(radians(s));
  triangle(-30, 30, 0, -30, 30, 30); 
  popMatrix();
  //s++;
  
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(123); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
  //println(" typetag: "+theOscMessage.get(0).floatValue());
  if (theOscMessage.checkAddrPattern("/player1")==true) {
    //player1_vel = theOscMessage.get(0).floatValue();
    player1_dir = theOscMessage.get(0).floatValue();
    println("p1_dir" + player1_dir);
    //println("p1_dir" + player1_dir);
  }
  //else if (theOscMessage.checkAddrPattern("/player2")==true) {
    //player2_vel = theOscMessage.get(0).floatValue();
    //player2_dir = theOscMessage.get(1).floatValue();
    //println("p2_vel" + player2_vel);
    //println("p2_dir" + player2_dir);
  //}
}

void rotateTest() {
  fill(200);
  s = player1_dir;
  pushMatrix();
  translate(width/2,height/2);
  rotate(radians(90));
  triangle(-30, 30, 0, -30, 30, 30); 
  popMatrix();
}