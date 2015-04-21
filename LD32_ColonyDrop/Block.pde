class Block {
  
  PVector location;
  int width, height;
  boolean destoy;
  color cStroke, cFill;
  int image;
  
  Block(float x, float y) {
    location = new PVector(x, y);
    width = BLOCK_SIZE;
    height = BLOCK_SIZE;
    
    cStroke = #25454D;
    cFill = #283036;
    image = floor(random(blockImageCount));
  }
  
  void display() {
    if ( camera.inView(location, width, height) ) {
      pushMatrix();
        
        camera.translateToView(); 
        translate(location.x, location.y);
        
        stroke(cStroke);
        tint(cFill);
        
        image(blockImage[image], 0, 0, width, height);
      
      popMatrix();
    }
  }
  
  void displayBG(int depth) {
    if ( camera.inView(location, width, height) ) {
      pushMatrix();
        
        camera.translateToView(); 
        translate(location.x, location.y);
        
        stroke(10);
        if      (depth==1) tint(15);
        else if (depth==2) tint(8, 200);
        else               tint(3, 128);
        
        image(blockImage[image], 0, 0, width, height);
      
      popMatrix();
    }
  }
  
}
