
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

class Rocket extends Bullet{
  PVector acceleration;
  boolean hasTarget;
  PVector targetLocation;
  int targetingTime;
  float speed;
  Rocket(float x, float y, float rotation, float speed){
    super(x, y, rotation, speed);
    targetLocation = new PVector(x, y);
    hasTarget = false;
    targetingTime = 500;
  }
  
  void update(int delta){
    if(!hasTarget){
      location.add( PVector.mult(velocity, delta) );
      targetingTime -= delta;
    }else{
      acceleration = PVector.sub(targetLocation, location);
      acceleration.normalize();
      velocity.add(PVector.mult(acceleration, delta));
      if(velocity.mag() > speed)
        velocity.normalize();
      location.add( PVector.mult(velocity, delta) );   
    }
    
    if(targetingTime <= 0){
      findTarget();
      targetingTime = 500;
    }
    
  }
  
  void findTarget(){
     Block target = spaceColony.get(0);
     for(int i = 1; i < spaceColony.size(); ++i){
       Block temp = (Block) spaceColony.get(i);
       if(dist(location.x, location.y, target.location.x, target.location.y) > dist(location.x, location.y, temp.location.x, temp.location.y)){
         target = temp;
       }
     }
     targetLocation = target.location;
     hasTarget = true;
   }
  
  
}
