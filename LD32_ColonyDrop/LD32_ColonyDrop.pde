//constants
final int BLOCK_SIZE = 32;

//global variables
int lastMillis;
float counter = 50;

//global pointers
Fighter testFighter;
Block[][] spaceColony;
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
  
  spaceColony = new Block[width/BLOCK_SIZE][height/BLOCK_SIZE];
  for(int x=0; x<spaceColony.length; x++) {
    for(int y=0; y<spaceColony[0].length; y++) {
      float dist = dist(x, y, width/BLOCK_SIZE/2, height/BLOCK_SIZE/2);
      if ( dist < 7 && dist > 6) {
        spaceColony[x][y] = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
        spaceColony[x][y].cFill = #2C3E43;
      }
      else if ( dist < 6 && dist > 5) {
        spaceColony[x][y] = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
      }
      else if ( dist < 5.1 && dist > 4) {
        spaceColony[x][y] = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
        spaceColony[x][y].cFill = #1A2027;
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
  
 
    
  for(int x=0; x<spaceColony.length; x++) {
    for(int y=0; y<spaceColony[0].length; y++) {
      if(spaceColony[x][y] != null) 
        spaceColony[x][y].display();
    }
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
    if(bullet.lifetime <= 0){ 
        bullet.onDeath();
        bullets.remove(i);
    }
  }
  
  testFighter.display(delta);
  debugUI.display();
}

void mousePressed(){
  explosions.add(new Explosion(new PVector(mouseY, mouseX), (int)random(40, 800), 0.1 , 0.1, 30, random(-0.03, 0.03)));
}
