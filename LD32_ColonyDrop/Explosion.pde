
class Explosion{
   PVector location;
   int particleCount;
   float particleMinSpeed, particleMaxSpeed, particleMaxRadius;  
   ArrayList<Particle> particles;
   
   Explosion(PVector _location, int _particleCount, float _particleMinSpeed, float _particleMaxSpeed, float _particleMaxRadius, float _spin){
     location = _location;
     particles = new ArrayList<Particle>();
     for(int i = 0; i < _particleCount; ++i){
       float speed = random(_particleMinSpeed, _particleMaxSpeed);
       println(speed);
       particles.add(new Particle(_location, speed , random(1, _particleMaxRadius), _spin));
     }
   }
   
  void update(int delta){
    for(int i = 0; i < particles.size(); ++i){
      Particle particle = (Particle) particles.get(i);
      particle.update(delta);
      if(particle.radius <= 0) { 
        particles.remove(i);
        i--;
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
  
  Particle(PVector _location, float _speed, float _radius, float _spin){
    location = new PVector();
    location.set(_location);
    velocity = polarVector(random(0, TWO_PI), _speed);
    radius = _radius;
    spin = _spin;
  }
  
  void update(int delta){
    velocity.rotate(random(-0.1, 0.1));
    velocity.rotate(spin);
    location.add( PVector.mult(velocity, delta) );
    radius -= 0.01*delta;
  }
  
  void display(int delta){
     pushMatrix();
      
      translate(location.x, location.y);
    
     // stroke(radius*15, radius*5, 0);
     //noStroke();
      tint(255, radius*15, 0, random(255));
      strokeWeight(1);
      image(particleImage, 0, 0, radius, radius);
     // ellipse( 0,0, radius, radius);

    popMatrix();
  }
}
