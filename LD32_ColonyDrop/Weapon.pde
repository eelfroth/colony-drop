
class Weapon{
  Fighter owner;
  PVector location;
  boolean loaded, reloading;
  int magazineSize, burst, shotsLeft, range;
  float reloadTime, reloadTimer, bulletSpeed;
  
  Weapon(Fighter _owner, int _magazineSize, int _burst, float _bulletSpeed, float _reloadTime, int _range){
    owner        = _owner;
    location     = new PVector();
    location.set(owner.location);
    magazineSize = _magazineSize;
    burst        = _burst;
    reloadTime   = _reloadTime;
    reloadTimer  = 1;
    shotsLeft    = _magazineSize;
    bulletSpeed  = _bulletSpeed;
    range        = _range;
    
    loaded    = true;
    reloading = false;
  }
  
  void update(PVector _location, int delta){
    location.set(_location);
    if(shotsLeft <= 0){
      reloadTimer +=1*delta;
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
    direction -= (burst/2)*0.1;
    if(loaded && !reloading){
      for(int i=0; i < burst; ++i){
        if(shotsLeft > 0){
          Bullet b = new Bullet(location.x, location.y, direction, bulletSpeed, range);
          b.velocity.add(owner.velocity);
          direction += 0.1; 
          bullets.add(b);
          shotsLeft--;
        }
      }
    }
  }
  
  void improve(){};
}

class StandardGun extends Weapon{
   StandardGun(Fighter _owner){
     super(_owner, 1, 1, 0.5, 200, 700);
   } 
   
   void improve(){
     burst++;
     magazineSize++;
   }
}
