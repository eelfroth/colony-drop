
int lastMillis;

Fighter testFighter;
DebugUI debugUI;

void setup() {
  size(800, 600);  
  frameRate(-1);
  
  background(0);
  smooth();
  
  debugUI = new DebugUI(8, 8);
  testFighter = new Fighter(width/2, height/2);
  
  lastMillis = millis();
}

void draw() {
  int delta = millis() - lastMillis;
  lastMillis = millis();
  
  testFighter.update(delta);
  debugUI.update(delta);
  
  fill(0, 2 * delta);
  noStroke();
  rect(0, 0, width, height);
  
  testFighter.display(delta);
  debugUI.display();
}
