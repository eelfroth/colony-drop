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
  
  font = loadFont("DejaVuSerif-18.vlw");
  
  camera = new View(0, 0, width, height);
  debugUI = new DebugUI(8, 8);
  sky = new Sky(10000, 10);
  
  
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
  
  fill(0, 4 * delta);
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
    
    testFighter.update(delta);
    camera.update(delta);
    
    
    
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
      }
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
  testFighter = new Fighter(width/2, height/2);
  
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

