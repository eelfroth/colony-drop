
class Explosion{
   PVector location;
   int particleCount;
   float particleMinSpeed, particleMaxSpeed, particleMaxRadius;  
   ArrayList<Particle> particles;
   
   Explosion(PVector _location, int _particleCount, float _particleMinSpeed, float _particleMaxSpeed, float _particleMaxRadius, float _spin, float gColorStart){
     location = _location;
     particles = new ArrayList<Particle>();
     for(int i = 0; i < _particleCount; ++i){
       float speed = random(_particleMinSpeed, _particleMaxSpeed);
       particles.add(new Particle(_location, speed , random(1, _particleMaxRadius), _spin, gColorStart));
     }
   }
   
  void update(int delta){
    for(int i = 0; i < particles.size(); ++i){
      Particle particle = (Particle) particles.get(i);
      particle.update(delta);
      if(particle.radius <= 0) { 
        particles.remove(i--);
      }
    }
  }
    
    void display(int delta){
       for(int i = 0; i < particles.size(); ++i){
          Particle particle = (Particle) particles.get(i);
          particle.display(delta);
    }
  }
}

class Particle{
  PVector location, velocity;
  float radius, spin;
  float gColor;
  
  Particle(PVector _location, float _speed, float _radius, float _spin, float _gColorStart){
    location = new PVector();
    location.set(_location);
    velocity = polarVector(random(0, TWO_PI), _speed);
    radius = _radius;
    spin = _spin;
    gColor = _gColorStart;
  }
  
  void update(int delta){
    velocity.rotate(random(-0.1, 0.1));
    velocity.rotate(spin);
    location.add( PVector.mult(velocity, delta) );
    radius -= 0.01*delta;
    if(gColor >= 0)
      gColor -= 1;
      
    Block bCollide = colony.collision(location.x, location.y);
    if(bCollide != null){
      
      radius = 0;
    }
  }
  
  void display(int delta){
     if ( camera.inView(location) ) {
      pushMatrix();
          
        camera.translateToView();  
        translate(location.x, location.y);
        
        tint(255, gColor, 0, random(255));
        strokeWeight(1);
        
        image(sparkImage, 0,0, radius, radius);
  
      popMatrix();
     }
  }
}
