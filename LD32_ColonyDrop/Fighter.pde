

class Fighter {
  PVector location, velocity, vAcc;
  float rotation, acceleration, maxSpeed;
  float length, width, propulsion, rotationSpeed;
  ArrayList<Bullet> bullets;
  Weapon weapon;
  
  Fighter(float x, float y) {
    
    location = new PVector(x, y);
    velocity = new PVector(0.00000001, 0);
    vAcc = new PVector();
    rotation = 0.0;
    
    //default values
    length = 32.0;
    width = 24.0;
    propulsion = 0.001;
    rotationSpeed = 0.008;
    maxSpeed = 0.5;
    rotationSpeed = 0.01;
    
    bullets = new ArrayList<Bullet>();
    weapon = new StandardGun(this);
    
  }
  
  void update(int delta) {
    /*
      evaluate inputs/ai etc
      --> changes rotation & propulsion (=acceleration vector)
    */
    weapon.update(location, delta);
    if (key_thrust) 
      acceleration = propulsion;
    else
      acceleration = 0.0;
      
    if (key_left)
      rotation -= rotationSpeed * delta;
    if (key_right)
      rotation += rotationSpeed * delta;
    if(key_shoot)
      weapon.shoot(rotation);
      //bullets.add(new Bullet(location.x, location.y, rotation, mag(velocity.x, velocity.y) + 0.5));
    //physics?
    
    //update bullets
    /*
    for(int i = 0; i < bullets.size(); ++i){
      Bullet bullet = (Bullet) bullets.get(i);
      bullet.update(delta);
      if(bullet.r <= 0) 
        bullets.remove(i);
    }
    */
    //update vectors
    if(acceleration == 0.0) 
      velocity.mult(0.99);
    else {
      vAcc.set(polarVector(rotation, acceleration));
      vAcc.mult( ((PVector.angleBetween(vAcc, velocity) / HALF_PI) +(maxSpeed-velocity.mag()))/2);
      //vAcc.mult( maxSpeed-velocity.mag());
      velocity.add( PVector.mult(vAcc, delta) );
    }
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
        rotate(rotation);
        /*
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
                */
        imageMode(CENTER);
        
        if (acceleration != 0.0) {
          
        tint(255, 100 + random(155), random(50), delta * random(20));
        image(sparkImage, -length/2 , 0.0, 10 + random(48), 8 + random(20));
        }
        //noTint();
        tint(#BABCAF);
        image(fighterImage, 0, 0);  
      popMatrix();
    }
  }
  
  
}
