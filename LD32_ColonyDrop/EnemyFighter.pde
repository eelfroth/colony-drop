class EnemyFighter{
 PVector acceleration, location, velocity;
 float speed, propulsion;
 EnemyFighter(PVector _location, float _rotation, float _speed){
    location = _location;
    velocity = polarVector(_rotation, _speed);
    speed = _speed;
    propulsion = 0.0003;
 } 
 
 void update(int delta){
      acceleration = PVector.sub(testFighter.location, location);
      //
      acceleration.normalize();
      acceleration.mult(propulsion);
      
      acceleration.mult( ((PVector.angleBetween(acceleration, velocity) / HALF_PI) +(speed-velocity.mag()))/2);
      acceleration.rotate(random(-0.5, 0.5));
      velocity.add(PVector.mult(acceleration, delta));
      location.add( PVector.mult(velocity, delta) );   
  }
  
    void display(int delta) {
    /*
      placeholder triangle
    */
    /*
    for(int i = 0; i < bullets.size(); ++i){
      Bullet bullet = (Bullet) bullets.get(i);
      bullet.display(delta);
    }
    */
    
    if ( camera.inView(location) ) {
      pushMatrix();
          
        camera.translateToView();  
        translate(location.x, location.y);
        
        rotate( velocity.heading() );
    
        imageMode(CENTER);
        //noTint();
        //tint(128, 100 + sin(float(millis()) / 50) * 50, 100 + sin(float(millis()) / 50) * 50);
        tint(0, 220, 100);
        image(fighterImage, 0, 0); 
      popMatrix();
    }
  }

   void onDeath(){
     explosions.add(new Explosion(location, (int)random(40, 800), 0.1 , 0.1, 30, random(-0.03, 0.03), 180));
     explosions.add(new Explosion(location, (int)random(40, 800), 0.01 , 0.05, 30, random(-0.04, 0.04), 255));
     
     sNoise01.trigger();
     sNoise01.setVolume(0.1);
   }
}
