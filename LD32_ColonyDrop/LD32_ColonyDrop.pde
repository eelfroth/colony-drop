//constants
final int BLOCK_SIZE = 32;

//global variables
int lastMillis;
float counter = 50;
int currentDepth = 0;
String mode = "title";
int introImageCounter;

//global pointers
Fighter testFighter;
SpaceColony colony;
ArrayList<Explosion> explosions;
ArrayList<Bullet> bullets;
ArrayList<EnemyFighter> enemyFighters;
DebugUI debugUI;
View camera;
Sky sky;
Teleprompter introText;

//files
PImage sparkImage;
PImage shotImage;
PImage fighterImage;
PImage rocketImage;
PFont font;
PImage planetImage, lizard1Image, lizard2Image;
PImage[] blockImage;
int blockImageCount;

void setup() {
  size(800, 600);  
  frameRate(-1);
  
  background(0);
  smooth();
  
 
  sparkImage = loadImage("spark.png");
  shotImage  = loadImage("shot.png");
  fighterImage = loadImage("fighter.png");
  rocketImage = loadImage("rocket.png");
  planetImage = loadImage("planet.png");
  lizard1Image = loadImage("lizard01.png");
  lizard2Image = loadImage("lizard02.png");
  blockImageCount = 3;
  blockImage = new PImage[blockImageCount];
  blockImage[0] = loadImage("block01.png");
  blockImage[1] = loadImage("block02.png");
  blockImage[2] = loadImage("block03.png");
  
  font = loadFont("DejaVuSerif-18.vlw");
  
  camera = new View(0, 0, width, height);
  debugUI = new DebugUI(8, 8);
  sky = new Sky(10000, 100);
  
  
  lastMillis = millis();
}
void draw() {
  
  
  
  int delta = millis() - lastMillis;
  lastMillis = millis();
  
  fill(random(15), 4 * delta);
    noStroke();
    rect(0, 0, width, height);
  sky.display();
  
  if (mode == "title") {
    pushMatrix();
    
      textAlign(CENTER);
      textFont(font);
      fill(255, 100+random(155));
      text("fly: Arrow keys or WASD\nshoot: space\n\n[PRESS START]", width/2, height/1.5 + sin(float(millis()) / 300)*18);
      
    popMatrix();
  }
  

  else if (mode == "intro") {
    pushMatrix();
    
      //rotate( sin(float(millis()) / 300)*0.1);
      
      translate(float(width)/1.7, height/2.3  + sin(float(millis()) / 300)*18);
      rotate(-0.23);
      scale(2);
      
      
      imageMode(CENTER);
      tint(155 + (sin(float(millis()) / 1010)+1)*50, 150);
      
      if (introImageCounter == 0) image(planetImage, 0, 0);
      else if (introImageCounter == 1) image(lizard2Image, 0, 0);
      else  image(lizard1Image, 0, 0);
      
      
      
    popMatrix();
    
    introText.update(delta);
    introText.display();
  }
  
  
  else if (mode == "game") {
    introText = null;
    
    if(counter < 0){
    enemyFighters.add(new EnemyFighter(new PVector(width/2, height/2), random(TWO_PI), 0.3));
    counter = random(0, 200);
    }else{
      counter--;
    }
    
    testFighter.update(delta);
    camera.update(delta);
    
    
    
    //colony.display(delta, currentDepth);
  colony.update(delta);
  colony.display(delta, currentDepth);
 
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
        bullets.remove(i--);
    }else{
    // hier is vielleicht noch was an rechenleistung zu sparen wenn man bei dieser iteration bereits die enemyFighter updatet und drawed und dann da weiter macht
    for(int k = 0; k < enemyFighters.size(); ++k){
      EnemyFighter enemyFighter = (EnemyFighter) enemyFighters.get(k);
      if(dist(enemyFighter.location.x, enemyFighter.location.y, bullet.location.x, bullet.location.y) < 20){
         enemyFighters.remove(enemyFighter);
         bullet.onDeath();
         bullets.remove(i--); 
      }
    }
    }
  }
    
    for(int i = 0; i < enemyFighters.size(); ++i){
      EnemyFighter enemyFighter = (EnemyFighter) enemyFighters.get(i);
      enemyFighter.update(delta);
      enemyFighter.display(delta);
    }
    
    testFighter.display(delta);
    
  }
  

  //debugUI.update(delta);
  //debugUI.display();
}

void startGame() {
  //    colony dimensions:  w   h   d
  //introText = null;
  
  colony = new SpaceColony(20, 20, 10);
  
  debugUI = new DebugUI(8, 8);
  testFighter = new Fighter(0, 0);

  enemyFighters = new ArrayList<EnemyFighter>();
  
  explosions = new ArrayList<Explosion>();
  bullets    = new ArrayList<Bullet>();
  
  camera = new View(0, 0, width, height);
  
  mode = "game";
}

void startIntro() {
  introImageCounter = 0;
  introText = new Teleprompter("story.txt", 5 , 80, float(height)/1.5, width-160, 50);
  mode = "intro";

}

