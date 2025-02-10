#include<AsyncSonarLib.h> // using AsyncSonar Library.

#define trigPin A0 // pin for trig and echo for HC-SR04

const double Object_Radius = 3.35; // radius of your container
const double Object_Height  = 8.5; // height of your container

const int radarOffet = -30;

double distance;

double waterHeight;
double waterVolume;

double waterHeightPercentage;
 
void PingRecieved(AsyncSonar& sonarResult){ // function called on every echo receive
  distance = sonarResult.GetFilteredMM() * 0.1;
}

void TimeOut(AsyncSonar& sonar) // function called when no response
{

}

AsyncSonar Sensor(trigPin, PingRecieved, TimeOut); // assigning the sonar

void TriggerSensor(){
  Sensor.Start(); // start pinging the sensor
  delay(30);
  Sensor.Update(); // update the sensor result
}

void GetWaterLevel(){
  TriggerSensor();
  waterHeight = Object_Height - distance; // get the water height inside the container
}

void GetWaterHeightPercentage(){ // for the UI.
  GetWaterLevel();
  waterHeightPercentage = (waterHeight / Object_Height) * 100;
}

void GetWaterVolume(){
  GetWaterLevel();
  waterVolume = 3.14 * square(Object_Radius) * waterHeight; // get the volume of the water inside the container
}
 
void setup() 
{ 
  Serial.begin(9600); 
} 

void WaterMeasurementMode(){
  GetWaterVolume(); // Get water volume also include get water height
  Serial.print(waterHeightPercentage);
  Serial.print(":");
  Serial.print(waterHeight);
  Serial.print(",");
  Serial.print(waterVolume);
  Serial.print(";");
}
 
void loop() 
{ 
  WaterMeasurementMode();
}