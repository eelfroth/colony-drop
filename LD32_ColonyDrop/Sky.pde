class Sky {
  ArrayList<Star> stars;
  
  Sky(int amount, float maxDepth) {
    stars = new ArrayList<Star>();
    for(int i=0; i<amount; i++) {
      Star s = new Star(-5000 + random(10000), -5000 + random(10000),  random(maxDepth), maxDepth);
      stars.add(s);
    }
  }
  
  void display() {
    for(int i=0; i<stars.size(); i++) {
      Star s = stars.get(i);
      s.display();
    }
  }
}

class Star {
  PVector location;
  float radius;
  
  Star(float x, float y, float z, float maxDepth) {
    location = new PVector(x, y, z);
    radius =  (1-(z/maxDepth))  * 3;
    if (radius < 0.5) radius = 0.5;
  }
  
  void display(){
     if ( camera.inView(location.x, location.y, location.z) ) {
      pushMatrix();
          
        camera.translateToView(location.z);  
        translate(location.x, location.y);
        if(mode == "game") {
          rotate(testFighter.velocity.heading());
        }
        
        fill(100, random(255));
        //strokeWeight(1);
        noStroke();
        if(mode == "game") {
          float mag = 1+testFighter.velocity.mag();
          ellipse( 0,0, radius * mag * mag * mag * mag * mag * mag * mag, radius);
        }
        else ellipse( 0,0, radius, radius);
  
      popMatrix();
     }
  }
}
