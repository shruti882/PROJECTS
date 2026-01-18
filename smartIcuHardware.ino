//kit unique id
int kitid=1;

//LCD
#include <LiquidCrystal.h>
// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 12, en = 11, d4 = 7, d5 = 6, d6 = 5, d7 = 4;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

//buzzer
const int buzzPin =  8;      // the number of the Buzzer pin

//button
const int buttonPin = 9;     // the number of the pushbutton pin
int buttonState = 0;         // variable for reading the pushbutton status
int counter = 0;

//load cell
#include "HX711.h"
#define calibration_factor -7050.0 //This value is obtained using the SparkFun_HX711_Calibration sketch
#define LOADCELL_DOUT_PIN  3
#define LOADCELL_SCK_PIN  2
HX711 scale;
int salineFlag=0;

//lm-35
#define lm35_pin A0 // LM35 is connected to this PIN

//pulse sensor - HW-827
#define USE_ARDUINO_INTERRUPTS true    // Set-up low-level interrupts for most acurate BPM maths.
#include <PulseSensorPlayground.h>     // Includes the PulseSensorPlayground Library.  
const int PulseWire = 1;       // PulseSensor PURPLE WIRE connected to ANALOG PIN 0
const int LED13 = 13;          // The on-board Arduino LED, close to PIN 13.
int Threshold = 550;           // Determine which Signal to "count as a beat" and which to ignore.
                               // Use the "Getting Started Project" to fine-tune Threshold Value beyond default setting.
                               // Other
PulseSensorPlayground pulseSensor;  // Creates an instance of the PulseSensorPlayground object called "pulseSensor


void setup() {
  Serial.begin(9600);

  //Configure Button
  pinMode(buttonPin, INPUT);

  //Configure LCD
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.setCursor(0, 0);
  lcd.print("WELCOME TO");  
  lcd.setCursor(0, 1);
  lcd.print("SMART ICU");  

  //Configure Buzzer
  pinMode(buzzPin, OUTPUT); // initialize the Buzzer pin as an output:
  digitalWrite(buzzPin, HIGH);

  // Configure the load cell  
  //Serial.println("HX711 scale demo");
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  scale.set_scale(calibration_factor); //This value is obtained by using the SparkFun_HX711_Calibration sketch
  scale.tare(); //Assuming there is no weight on the scale at start up, reset the scale to 0

  // Configure the PulseSensor object, by assigning our variables to it. 
  pulseSensor.analogInput(PulseWire);   
  pulseSensor.blinkOnPulse(LED13);       //auto-magically blink Arduino's LED with heartbeat.
  pulseSensor.setThreshold(Threshold);   
  // Double-check the "pulseSensor" object was created and "began" seeing a signal. 
   if (pulseSensor.begin()) {
    //Serial.println("We created a pulseSensor Object !");  //This prints one time at Arduino power-up,  or on Arduino reset.  
  }
}

void loop() 
{
  Serial.println(kitid);
  delay(1000);
  lm35();
  pulseData();
  loadCell();
  buttonPress(); //- 2000
}

void lm35() 
{
  //Read Raw ADC Data
  int adcData = analogRead(lm35_pin);
  // Convert that ADC Data into voltage
  float voltage = adcData * (5.0 / 1024.0);
  // Convert the voltage into temperature 
  float temperature = voltage * 100;
  // Print the temperature data
  //Serial.print("Temperature: ");
  Serial.println(temperature);
  //Serial.println("*C");
  if(temperature>50.00)
  {
    buzzerON();
    lcdPrint("Temperature Alert");
    delay(1000);
    buzzerOFF();
  }
  else
  {
    delay(1000);
  }
}

void pulseData() 
{
  int myBPM = pulseSensor.getBeatsPerMinute();  // Calls function on our pulseSensor object that returns BPM as an "int".
                                               // "myBPM" hold this BPM value now. 
  if (pulseSensor.sawStartOfBeat()) 
  {            // Constantly test to see if "a beat happened". 
    //Serial.println("♥  A HeartBeat Happened ! "); // If test is "true", print a message "a heartbeat happened".
    //Serial.print("BPM: ");                        // Print phrase "BPM: " 
    Serial.println(myBPM);                        // Print the value inside of myBPM. 
    if(myBPM>50)
    {
      buzzerON();
      lcdPrint("Pulse Alert");
      delay(1000);
      buzzerOFF();
    }
    else
    {
      delay(1000);
    }
  }
  else
  {
    Serial.println("0");
    delay(1000);    
  }
}

void loadCell() 
{
  //Serial.print("Reading: ");
  //Serial.print(scale.get_units(), 1); //scale.get_units() returns a float
  //Serial.println(" lbs"); //You can change this to kg but you'll need to refactor the calibration_factor
  if(scale.get_units()>0.7)
  {
    //Serial.println("Saline Started");
    lcdPrint("Saline Started");
    salineFlag=1;
  }
  if(scale.get_units()<0.7 && salineFlag==1)
    {
      salineFlag=0;
      buzzerON();
      lcdPrint("Saline Alert");
      //Serial.println("Saline Ended");
    }
  
}

void lcdPrint(String msg) 
{
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(kitid);
  lcd.setCursor(0, 1);
  lcd.print(msg);
}

void buzzerON()
{
  digitalWrite(buzzPin,LOW);
}
void buzzerOFF()
{
  digitalWrite(buzzPin,HIGH);
}

void buttonPress()
{
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);
  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if(buttonState == HIGH) 
  {
    counter++;
    //Serial.println("Pressed");
    lcdPrint("Help Alert");
    buzzerON();
    delay(1000);   
    buzzerOFF();
  }
  else
  {
    delay(1000);   
  }
  if(counter==1)
  {
    lcdPrint("Help Alert");
    buzzerON();
    delay(1000);   
    buzzerOFF();
  }
  else if(counter>=2)
  {
    counter=0;
    buzzerOFF();
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("WELCOME TO");  
    lcd.setCursor(0, 1);
    lcd.print("SMART ICU");  
    delay(1000);
  }
  else
  {
    delay(1000);   
  }
}