class SpaceColony{
  int w, h, d;
  ArrayList<Block[][]> layers;
  SpaceColony(int _w, int _h, int _d){
    w = _w;
    h = _h;
    d = _d;
    layers = new ArrayList();
    generateColony(w, h, d);
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
}


