class SpaceColony{
  PVector location;
  int w, h, d;
  ArrayList<Block[][]> layers;
  SpaceColony(int _w, int _h, int _d){
    w = _w;
    h = _h;
    d = _d;
    location = new PVector(0, 0);
    layers = new ArrayList();
    generateColony(w, h, d);
  }
  
  void update(int delta){
    if(layerEmpty(currentDepth)){
      if(currentDepth < d-1){
        currentDepth++;
      }else{
          // GAME OVER
      }
    }
  }
  
  void generateColony(int _w, int _h, int _d){
    for(int i = 0; i < d; ++i){
      Block[][] layer = new Block[w][h];
      layers.add(layer);
      for(int x=0; x<w; ++x) {
        for(int y=0; y<h; ++y) {
          float dist = dist(x, y, w/2, h/2);
          if ( dist < 7 && dist > 6) {
            layers.get(i)[x][y] = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
            layers.get(i)[x][y].cFill = #2C3E43;
          }
          else if ( dist < 6 && dist > 5) {
            layers.get(i)[x][y] = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
          }
          else if ( dist < 5.1 && dist > 4) {
            layers.get(i)[x][y] = new Block(x*BLOCK_SIZE, y*BLOCK_SIZE);
            layers.get(i)[x][y].cFill = #1A2027;
          }
        }
      }
    }
  }
  
  void display(int delta, int _d){
    for(int x=0; x<w; x++) {
      for(int y=0; y<h; y++) {
        if(layers.get(_d)[x][y] != null) 
          layers.get(_d)[x][y].display();
      }
    }
  }
  
  Block collision(float x, float y){
    if(x < location.x || x > location.x + w*BLOCK_SIZE || y < location.y || y > location.y +h*BLOCK_SIZE)
      return null;
    else
      return layers.get(currentDepth)[floor(x/BLOCK_SIZE)][floor(y/BLOCK_SIZE)];
  }
  
  boolean layerEmpty(int layer){
      for(int x=0; x<w; ++x) {
        for(int y=0; y<h; ++y) {
          if(layers.get(layer)[x][y] != null) return false;
        }
      }
      return true;
  }
}


