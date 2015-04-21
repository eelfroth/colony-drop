class DebugUI {
  
  PVector location;
  
  String myString;
  int updateInterval;
  int lastUpdate;
  
  DebugUI(float x, float y) {
    location = new PVector(x, y);
    updateInterval = 500;
    lastUpdate = -updateInterval;
    myString = "";
  }
  
  void update(int delta) {
    
    if(millis() - lastUpdate >= updateInterval) {
      myString = "";
      myString += "fR: " + float(round(frameRate*100))/100 + "\n";
      myString += "Δt: " + delta + "\n";
      
      if(mode == "game")  {
        myString += "ship x: " +  float(round(testFighter.location.x * 100))/100 + "\n";
        myString += "ship y: " +  float(round(testFighter.location.y * 100))/100 + "\n";
        myString += "ship α: " +  float(round(testFighter.rotation * 100))/100 + "\n";
        myString += "shp vlcty: " +  float(round(testFighter.velocity.mag() * 100))/100 + "\n";
        
        myString += "bullets: " + bullets.size() + "\n";
        
        int particles = 0;
        for(Explosion e : explosions) {
          particles += e.particles.size();
        }
        
        myString += "particles: " + particles + "\n";
      }
      
      
      
      lastUpdate = millis();
    }
  }
  
  void display() {
    pushMatrix();
      
      translate(location.x, location.y);
      
      fill(0, 80);
      //noFill();
      stroke(#629D67);
      rect(0, 0, 128, 15*8);
      fill(#629D67);
      textAlign(LEFT);
      text(myString, 4, 14);
      
    popMatrix();
  }
}
