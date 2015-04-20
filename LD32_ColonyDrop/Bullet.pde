
class Bullet{
  
  PVector location, velocity;
  float r;
  int lifetime, maxLifetime;
  
  Bullet(float x, float y, float rotation, float speed, int range){
    location = new PVector(x, y);
    velocity = polarVector(rotation, speed);
    r = 24;
    maxLifetime = range;
    lifetime = maxLifetime;
  }
  
  void update(int delta){
    location.add( PVector.mult(velocity, delta) );
    lifetime -= delta;
  }
  
  void display(int delta){
   
    if ( camera.inView(location) ) {
      pushMatrix();
          
        camera.translateToView();  
      
        translate(location.x, location.y);
        /*
        stroke(200);
        fill(0);
        strokeWeight(1);
        
        ellipse( 0,0, r, r);
        */
        //tint(random(0, 255), 0, 0, random(255));
        tint(200, 128+sin(float(lifetime) / maxLifetime*0.5)*64, random(200));
        imageMode(CENTER);
        image(shotImage, 0, 0, r*2, r*2);
      popMatrix();
    }
   
    // ellipse( location.x, location.y, r, r);
  }
}
