
class Bullet{
  
  PVector location, velocity;
  float r;
  int lifetime = 500;
  
  Bullet(float x, float y, float rotation, float speed){
    location = new PVector(x, y);
    velocity = polarVector(rotation, speed);
    r = 10;
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
        image(shotImage, 0, 0, r*5, r*5);
      popMatrix();
    }
   
    // ellipse( location.x, location.y, r, r);
  }
}
