
//constants
final int BLOCK_SIZE = 32;

//global variables
int lastMillis;

//pointer
Fighter testFighter;
ArrayList<Explosion> explosions;
DebugUI debugUI;
ArrayList<Block> spaceColony;

void setup() {
  size(800, 600);  
  frameRate(-1);
  
  background(0);
  smooth();
  
  debugUI = new DebugUI(8, 8);
  testFighter = new Fighter(width/2, height/2);
  explosions = new ArrayList<Explosion>();
  
  spaceColony = new ArrayList<Block>();
  for(int x=0; x<width/BLOCK_SIZE; x++) {
    for(int y=0; y<height/BLOCK_SIZE; y++) {
      if ( dist(x, y, width/BLOCK_SIZE/2, height/BLOCK_SIZE/2) < 5) {
        spaceColony.add( new Block(x*BLOCK_SIZE, y*BLOCK_SIZE) );
      }
    }
  }
  
  lastMillis = millis();
}

void draw() {
  int delta = millis() - lastMillis;
  lastMillis = millis();
  
  testFighter.update(delta);
  for(int i = 0; i < explosions.size(); ++i){
    Explosion explosion = (Explosion) explosions.get(i);
    explosion.update(delta);
    explosion.display(delta);
  }
  debugUI.update(delta);
  
  fill(0, 2 * delta);
  noStroke();
  rect(0, 0, width, height);
  
  for(int i=0; i<spaceColony.size(); i++) {
    Block b = spaceColony.get(i);
    b.display();
  }
  
  testFighter.display(delta);
  debugUI.display();
}

void mousePressed(){
  explosions.add(new Explosion(new PVector(width/2, height/2), 40, 2, 5, 5));
}
