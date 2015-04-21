class Sky {
  ArrayList<Star> stars;
  
  Sky(int amount, float maxDepth) {
    stars = new ArrayList<Star>();
    for(int i=0; i<amount; i++) {
      Star s = new Star(-5000 + random(10000), -5000 + random(10000),  random(maxDepth));
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
  
  Star(float x, float y, float z) {
    location = new PVector(x, y, z);
    radius = 5 - z;
    if (radius < 0.5) radius = 0.5;
  }
  
  void display(){
     if ( camera.inView(location) ) {
      pushMatrix();
          
        camera.translateToView();  
        translate(location.x, location.y);
        
        fill(255, random(255));
        //strokeWeight(1);
        noStroke();
        
        ellipse( 0,0, radius, radius);
  
      popMatrix();
     }
  }
}
