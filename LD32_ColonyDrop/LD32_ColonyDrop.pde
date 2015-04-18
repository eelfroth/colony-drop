
int lastMillis;

Fighter testFighter;
ArrayList<Explosion> explosions;
DebugUI debugUI;

void setup() {
  size(800, 600);  
  frameRate(-1);
  
  background(0);
  smooth();
  
  debugUI = new DebugUI(8, 8);
  testFighter = new Fighter(width/2, height/2);
  explosions = new ArrayList<Explosion>();
  
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
  
  testFighter.display(delta);
  debugUI.display();
}

void mousePressed(){
  explosions.add(new Explosion(new PVector(mouseY, mouseX), 40, 0.1 , 1, 15));
}
