
class Weapon{
  PVector location;
  boolean loaded, reloading;
  int magazineSize, burst, shotsLeft;
  float reloadTime, reloadTimer, bulletSpeed;
  
  Weapon(PVector _location, int _magazineSize, int _burst, float bulletSpeed, float _reloadTime){
    location     = new PVector();
    location.set(_location);
    magazineSize = _magazineSize;
    burst        = _burst;
    reloadTime   = _reloadTime;
    reloadTimer  = 0;
    shotsLeft    = _magazineSize;
    
    loaded    = true;
    reloading = false;
  }
  
  void update(PVector _location, int delta){
    location.set(_location);
    if(shotsLeft <= 0){
      reloadTimer += 30*delta;
      reloading = true;
      loaded    = false;
    }
    if(reloadTimer >= reloadTime){
      loaded      = true;
      reloading   = false;
      reloadTimer = 0;
      shotsLeft   = magazineSize;
    }
  }
  
  void shoot(float direction){
    if(loaded){
      for(int i=0; i < burst; ++i){
        if(shotsLeft > 0){
          bullets.add(new Bullet(location.x, location.y, direction, bulletSpeed));
        }
      }
    }
  }
   
}
