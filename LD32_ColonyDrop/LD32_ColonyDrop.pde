//constants
final int BLOCK_SIZE = 32;

//global variables
int lastMillis;

//global pointers
Fighter testFighter;
ArrayList<Block> spaceColony;
ArrayList<Explosion> explosions;
ArrayList<Bullet> bullets;
PImage sparkImage;
PImage shotImage;
PImage fighterImage;
DebugUI debugUI;
View camera;

float counter = 50;

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
  spaceColony = new ArrayList<Block>();
  for(int x=0; x<width/BLOCK_SIZE; x++) {
    for(int y=0; y<height/BLOCK_SIZE; y++) {
      float dist = dist(x, y, width/BLOCK_SIZE/2, height/BLOCK_SIZE/2);
      if ( dist < 7 && dist > 6) {
        Block b = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
        spaceColony.add( b );
        b.cFill = #2C3E43;
      }
      else if ( dist < 6 && dist > 5) {
        Block b = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
        spaceColony.add( b );
      }
      else if ( dist < 5.1 && dist > 4) {
        Block b = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
        spaceColony.add( b );
        b.cFill = #1A2027;
      }
    }
  }
  
  camera = new View(0, 0, width, height);
  
  lastMillis = millis();
}
void draw() {
 
  if(counter < 0){
    explosions.add(new Explosion(new PVector(width/2, height/2), (int)random(40, 800), 0.1 , 0.1, 30, random(-0.03, 0.03)));
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
  
 
    
  for(int i=0; i<spaceColony.size(); i++) {
    Block b = spaceColony.get(i);
    b.display();
  }
  for(int i = 0; i < explosions.size(); ++i){
    Explosion explosion = (Explosion) explosions.get(i);
    explosion.update(delta);
    explosion.display(delta);
    if(explosion.particles.size() < 1) {
      explosions.remove(i--);
    }
  }
  for(int i = 0; i < bullets.size(); ++i){
    Bullet bullet = (Bullet) bullets.get(i);
    bullet.update(delta);
    bullet.display(delta);
    if(bullet.lifetime <= 0) 
        bullets.remove(i);
  }
  
  testFighter.display(delta);
  debugUI.display();
}

void mousePressed(){
  explosions.add(new Explosion(new PVector(mouseY, mouseX), (int)random(40, 800), 0.1 , 0.1, 30, random(-0.03, 0.03)));
}
