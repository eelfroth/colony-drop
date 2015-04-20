

class Fighter {
  PVector location, velocity;
  float rotation, acceleration;
  float length, width, propulsion, rotationSpeed;
  ArrayList<Bullet> bullets;
  
  Fighter(float x, float y) {
    
    location = new PVector(x, y);
    velocity = new PVector();
    rotation = 0.0;
    
    //default values
    length = 32.0;
    width = 24.0;
    propulsion = 0.0004;
    rotationSpeed = 0.01;
    
    bullets = new ArrayList<Bullet>();
    
  }
  
  void update(int delta) {
    /*
      evaluate inputs/ai etc
      --> changes rotation & propulsion (=acceleration vector)
    */
    
    if (key_thrust) 
      acceleration = propulsion;
    else
      acceleration = 0.0;
      
    if (key_left)
      rotation -= rotationSpeed * delta;
    if (key_right)
      rotation += rotationSpeed * delta;
    if(key_shoot)
      bullets.add(new Bullet(location.x, location.y, rotation, random(0.5, 1)));
    //physics?
    
    //update bullets
    for(int i = 0; i < bullets.size(); ++i){
      Bullet bullet = (Bullet) bullets.get(i);
      bullet.update(delta);
      if(bullet.r <= 0) 
        bullets.remove(i);
    }
    
    //update vectors
    velocity.add( PVector.mult(polarVector(rotation, acceleration), delta) );
    location.add( PVector.mult(velocity, delta) );
  }
  
  void display(int delta) {
    /*
      placeholder triangle
    */
    for(int i = 0; i < bullets.size(); ++i){
      Bullet bullet = (Bullet) bullets.get(i);
      bullet.display(delta);
    }
  
    if ( camera.inView(location) ) {
      pushMatrix();
          
        camera.translateToView();  
        translate(location.x, location.y);
        rotate(rotation);
        
        if (acceleration != 0.0) {
        fill(255, 100 + random(155), random(100), delta * random(20));
        noStroke();
        
        ellipse(-length/2 - 12, 0.0, 12 + random(28), 8 + random(8));
        }
      
        stroke(200);
        fill(0);
        strokeWeight(1);
        
        triangle( length/2,  0.0    ,
                 -length/2,  width/2, 
                 -length/2, -width/2
                );
  
      popMatrix();
    }
  }
  
  
}
