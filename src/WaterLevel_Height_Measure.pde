import processing.serial.*; // imports library for serial communication
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;
Serial myPort; // defines Object Serial
// defubes variables
double WaterHeight = 0;
double WaterVolume = 0;

double WaterLevelPercentage;

final double BottleHeight= 8.5;
final double BottleRadius = 3.35;

final int beakerheight = 940; // IN PIXAL

void setup(){

  size (1000, 1000, P3D); // ***CHANGE THIS TO YOUR SCREEN RESOLUTION***
  smooth();
  myPort = new Serial(this, "COM5", 9600); // starts the serial communication
  myPort.bufferUntil(';'); // reads the data from the serial port up to the character ';'.
}
void draw() {

  background(30);
  
  GenerateBeakerandWater(WaterLevelPercentage);
  GenerateMeasurement(WaterLevelPercentage);
  GenerateVolumeDiagram();
  
}
void serialEvent (Serial myPort) { 
  
  String data = myPort.readStringUntil(';');
  data = data.substring(0, data.length()-1);
  int WaterLevelPercenSep = data.indexOf(":"); 
  String waterLevelPercenString = data.substring(0, WaterLevelPercenSep);
  WaterLevelPercentage = Double.valueOf( waterLevelPercenString == null || waterLevelPercenString.trim().isEmpty()? "0" : waterLevelPercenString);
  
  int SepIndex = data.indexOf(","); 
  String waterheightString = data.substring(WaterLevelPercenSep + 1, SepIndex);
  WaterHeight= Double.valueOf( waterheightString == null || waterheightString.trim().isEmpty()? "0" : waterheightString ); 
  
  String waterVolumeString = data.substring(SepIndex+1, data.length());
  WaterVolume= Double.valueOf(waterVolumeString == null || waterVolumeString.trim().isEmpty()? "0" : waterVolumeString );
}

void GenerateBeakerandWater(double waterlevelPercentage){ // waterlevel is the percentage of the water in respect of the full height of the cup
  strokeWeight(7);
  stroke(255);
  line(30,30, 30, 970);
  line(30,970, 500, 970);
  line(500,970, 500, 30);
  
  strokeWeight(1);
  
  fill(#416bdf);
  int waterheight = (int)(beakerheight * waterlevelPercentage / 100);
  rect(30,970, 470, -waterheight);
}

void GenerateMeasurement(double waterlevelPercentage){ // waterlevel is the percentage of the water in respect of the full height of the cup
  strokeWeight(7);
  stroke(255);
  int displayheight = (int)((beakerheight * (100 - waterlevelPercentage )/ 100)) + 30;
  line(540,970, 540, displayheight);
  line(520, 970, 560, 970);
  line(520, displayheight, 560, displayheight);
  fill(#ffffff);
  textSize(50);
  int textheight = displayheight + displayheight/2;
  if(textheight >= 950){
    textheight = 950;
  }
  
  if(textheight <= 550){
    textheight = 550;
  }
  text("Height:", 580, textheight);
  
  text(WaterHeight + " cm", 750, textheight); 
}

void GenerateVolumeDiagram(){
  fill(#416bdf);
  strokeWeight(0);
  ellipse(725, 200, 300, 300);
  strokeWeight(7);
  line(575, 370, 875, 370);
  line(575, 350, 575, 390);
  line(875, 350, 875, 390);
  fill(#ffffff);
  textSize(30);
  text("Diameter:", 600, 430);
  text((int)(BottleRadius * 2) + " cm", 725, 430); 
  text("Volume:", 600, 480);
  text(WaterVolume + " ml", 725, 480); 
  
}

//oh my nigga, imma kill myself.. >:( FUCK THIS SHIT.
