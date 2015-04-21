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
ArrayList<EnemyFighter> enemyFighters;
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
  testFighter = new Fighter(0, 0);
  
  explosions = new ArrayList<Explosion>();
  bullets    = new ArrayList<Bullet>();
  enemyFighters = new ArrayList<EnemyFighter>();
  
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
  
  if(counter < 0){
    enemyFighters.add(new EnemyFighter(new PVector(width/2, height/2), random(TWO_PI), 0.3));
    counter = random(0, 200);
  }else{
    counter--;
  }
  
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
  
  for(int i = 0; i < enemyFighters.size(); ++i){
    EnemyFighter enemyFighter = (EnemyFighter) enemyFighters.get(i);
    enemyFighter.update(delta);
    enemyFighter.display(delta);
  }
  
  testFighter.display(delta);
  debugUI.display();
}

