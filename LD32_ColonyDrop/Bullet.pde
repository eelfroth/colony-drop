
class Bullet{
  
  PVector location, velocity;
  float r;
  
  Bullet(float x, float y, float rotation, float speed){
    location = new PVector(x, y);
    velocity = polarVector(rotation, speed);
    r = 10;
  }
  
  void update(int delta){
    location.add( PVector.mult(velocity, delta) );
  }
  
  void display(int delta){
    pushMatrix();
      
      translate(location.x, location.y);
    
      stroke(200);
      fill(0);
      strokeWeight(1);
      
      ellipse( location.x, location.y, r, r);

    popMatrix();
  }
}
