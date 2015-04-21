//constants
final int BLOCK_SIZE = 32;

//global variables
int lastMillis;
float counter = 50;
int currentDepth = 0;

//global pointers
Fighter testFighter;
SpaceColony colony;
ArrayList<Explosion> explosions;
ArrayList<Bullet> bullets;
DebugUI debugUI;
View camera;

//files
PImage sparkImage;
PImage shotImage;
PImage fighterImage;
PImage rocketImage;

void setup() {
  size(800, 600);  
  frameRate(-1);
  
  background(0);
  smooth();
  
  debugUI = new DebugUI(8, 8);
  testFighter = new Fighter(width/2, height/2);
  
  explosions = new ArrayList<Explosion>();
  bullets    = new ArrayList<Bullet>();
  
  sparkImage = loadImage("spark.png");
  shotImage  = loadImage("shot.png");
  fighterImage = loadImage("fighter.png");
  rocketImage = loadImage("rocket.png");
  //    colony dimensions:  w   h   d
  colony = new SpaceColony(20, 20, 10);
  
  camera = new View(0, 0, width, height);
  
  lastMillis = millis();
}
void draw() {
 /*
  if(counter < 0){
    explosions.add(new Explosion(new PVector(width/2, height/2), (int)random(10, 60), 0.08 , 0.1, 60, random(-0.03, 0.03), 215));
    counter = random(0, 200);
  }else{
    counter--;
  }
  */
  int delta = millis() - lastMillis;
  lastMillis = millis();
  
  testFighter.update(delta);
  camera.update(delta);
  
  debugUI.update(delta);
  
  fill(0, 4 * delta);
  noStroke();
  rect(0, 0, width, height);
    for(int i = 0; i < explosions.size(); ++i){
    Explosion explosion = (Explosion) explosions.get(i);
    explosion.update(delta);
    explosion.display(delta);
    if(explosion.particles.size() < 1) {
      explosions.remove(i--);
    }
  }
  colony.display(delta, currentDepth);


  for(int i = 0; i < bullets.size(); ++i){
    Bullet bullet = (Bullet) bullets.get(i);
    bullet.update(delta);
    bullet.display(delta);
    if(bullet.lifetime <= 0){ 
        bullet.onDeath();
        bullets.remove(i--);
    }
  }
  
  testFighter.display(delta);
  debugUI.display();
}

