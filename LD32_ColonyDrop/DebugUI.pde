class DebugUI {
  
  PVector location;
  
  String myString;
  int updateInterval;
  int lastUpdate;
  
  DebugUI(float x, float y) {
    location = new PVector(x, y);
    updateInterval = 1000;
    lastUpdate = -updateInterval;
    myString = "";
  }
  
  void update(int delta) {
    
    if(millis() - lastUpdate >= updateInterval) {
      myString = "";
      myString += "fR: " + float(round(frameRate*100))/100 + "\n";
      myString += "Δt: " + delta + "\n";
      
      myString += "ship x: " + testFighter.location.x + "\n";
      myString += "ship y: " + testFighter.location.y + "\n";
      myString += "ship α: " + testFighter.rotation + "\n";
      
      lastUpdate = millis();
    }
  }
  
  void display() {
    pushMatrix();
      
      translate(location.x, location.y);
      
      //fill(0);
      noFill();
      stroke(#629D67);
      rect(0, 0, 128, 15*5);
      fill(#629D67);
      text(myString, 4, 14);
      
    popMatrix();
  }
}
