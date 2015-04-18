
class Explosion{
   PVector location;
   int particleCount;
   float particleMinSpeed, particleMaxSpeed, particleMaxRadius;  
   ArrayList<Particle> particles;
   
   Explosion(PVector _location, int _particleCount, float _particleMinSpeed, float _particleMaxSpeed, float _particleMaxRadius){
     location = _location;
     particles = new ArrayList<Particle>();
     for(int i = 0; i < _particleCount; ++i){
       float direction = random(0, TWO_PI);
       particles.add(new Particle(_location, random(_particleMinSpeed, particleMaxSpeed), random(1, _particleMaxRadius)));
     }
   }
   
  void update(int delta){
    for(int i = 0; i < particles.size(); ++i){
      Particle particle = (Particle) particles.get(i);
      particle.update(delta);
      if(particle.radius <= 0) 
        particles.remove(i);
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
  float radius;
  
  Particle(PVector _location, float _speed, float _radius){
    location = _location;
    velocity = polarVector(random(0, TWO_PI), _speed);
    radius = _radius;
  }
  
  void update(int delta){
    location.add( PVector.mult(velocity, delta) );
    radius -= 0.01*delta;
  }
  
  void display(int delta){
     pushMatrix();
      
      translate(location.x, location.y);
    
      stroke(200);
      fill(0);
      strokeWeight(1);
      
      ellipse( 0,0, radius, radius);

    popMatrix();
  }
}
