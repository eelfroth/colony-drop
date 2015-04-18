class Block {
  
  PVector location;
  int width, height;
  boolean destoy;
  color cStroke, cFill;
  
  Block(float x, float y) {
    location = new PVector(x, y);
    width = BLOCK_SIZE;
    height = BLOCK_SIZE;
    
    cStroke = #25454D;
    cFill = #283036;
  }
  
  void display() {
    pushMatrix();
    
      translate(location.x, location.y);
      
      stroke(cStroke);
      fill(cFill);
      
      rect(0, 0, width, height);
    
    popMatrix();
  }
  
}
