
class Bullet{
  
  PVector location, velocity;
  float r;
  
  Bullet(int x, int y, int rotation, int speed){
    location = new PVector(x, y);
    velocity = polarVector(rotation, speed),
    r = 10;
  }
  
  
}
