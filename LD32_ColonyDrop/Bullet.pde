
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
  
  void onDeath(){
    explosions.add(new Explosion(location, (int)random(3, 10), 0.01 , 0.1, 8, random(-0.03, 0.03)));
  };
}

class Rocket extends Bullet{
  PVector acceleration;
  boolean hasTarget;
  PVector targetLocation;
  int targetingTime;
  float speed, propulsion;
  Rocket(float x, float y, float rotation, float speed, int range){
    super(x, y, rotation, speed, 1);
    targetLocation = new PVector(x, y);
    hasTarget = false;
    targetingTime = 500;
    propulsion = 0.008;
    lifetime = range;
  }
  
  void update(int delta){
    if(!hasTarget){
      location.add( PVector.mult(velocity, delta) );
      targetingTime -= delta;
    }else{
      acceleration = PVector.sub(targetLocation, location);
      acceleration.normalize();
      acceleration.mult(propulsion);
      
      acceleration.mult( ((PVector.angleBetween(acceleration, velocity) / HALF_PI) +(speed-velocity.mag()))/2);
      velocity.add(PVector.mult(acceleration, delta));
      /*if(velocity.mag() > speed)
        velocity.normalize(); */
      location.add( PVector.mult(velocity, delta) );   
    }
    
    if(targetingTime <= 0){
      findTarget();
      targetingTime = 500;
    }
    lifetime -= delta;
    
  }
  
  void findTarget(){
    /* Block target = spaceColony.get(0);
     for(int i = 1; i < spaceColony.size(); ++i){
       Block temp = (Block) spaceColony.get(i);
       if(dist(location.x, location.y, target.location.x, target.location.y) > dist(location.x, location.y, temp.location.x, temp.location.y)){
         target = temp;
       }
     }
     targetLocation = target.location;
     hasTarget = true;*/
   }
   
  void display(int delta) {
    
    if ( camera.inView(location) ) {
      pushMatrix();
          
        camera.translateToView();  
        translate(location.x, location.y);
        
        if (velocity.x > 0 && velocity.y > 0) 
          rotate( acos(velocity.x / velocity.mag()) );
        else if (velocity.x < 0 && velocity.y > 0) 
          rotate( acos(-velocity.x / -velocity.mag()) );
        else if (velocity.x > 0 && velocity.y < 0) 
          rotate( asin(velocity.y / velocity.mag()) );
        else if (velocity.x < 0 && velocity.y < 0) 
          rotate(PI + asin(-velocity.y / velocity.mag()) );
    
        imageMode(CENTER);
        
        if (hasTarget) {
          
          tint(255, 100 + random(155), random(50), delta * random(20));
          image(sparkImage, -r , 0.0, 10 + random(48), 8 + random(20));
        }
        //noTint();
        //tint(128, 100 + sin(float(millis()) / 50) * 50, 100 + sin(float(millis()) / 50) * 50);
        tint(#E0CCCC);
        image(rocketImage, 0, 0);  
      popMatrix();
    }
  }

   void onDeath(){
     explosions.add(new Explosion(location, (int)random(40, 800), 0.1 , 0.1, 30, random(-0.03, 0.03), 180));
     explosions.add(new Explosion(location, (int)random(40, 800), 0.01 , 0.03, 30, random(-0.03, 0.03), 255));
   }
  
  
}
