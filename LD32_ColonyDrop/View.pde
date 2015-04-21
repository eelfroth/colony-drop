/**
  
  To find out if in view use:
    camera.inView(PVector)  
  or
    camera.inView(PVector, w, h)
  
  To apply camera translation use:
    camera.translateToView()
  
  
*/

class View {
  
  PVector location, offset;
  int width, height;
  
  View(float x, float y, int w, int h) {
    location = new PVector(x, y);
    width = w;
    height = h;
    offset = new PVector(width/2, height/2);
  }
  
  void update(int delta) {
    if(mode == "game") {
      location = testFighter.location;
      offset.set(width/2 - testFighter.velocity.x * width/4, height/2 - testFighter.velocity.y * height/4, 0);
    }
  }
  
  boolean inView(PVector v) {
    return inView(v.x, v.y);
  }
  
  boolean inView(float x, float y) {
    if(x >=  location.x - offset.x && x <= location.x + width - offset.x) {
      if(y >=  location.y - offset.y && y <= location.y + width - offset.y) {
        return true;
      }
    }
    return false;
  }
  
  boolean inView(PVector v, int w, int h) {
    return inView(v.x, v.y, w, h);
  }
  
  boolean inView(float x, float y, int w, int h) {
    return inView(x, y) || inView(x + w, y) || inView(x, y + h) || inView(x + w, y + h);
  }
  
   boolean inView(float x, float y, float z) {
    if(x >=  location.x/(z+1) - offset.x && x <= location.x/(z+1) + width - offset.x) {
      if(y >=  location.y/(z+1) - offset.y && y <= location.y/(z+1) + width - offset.y) {
        return true;
      }
    }
    return false;
  }
  
  void translateToView() {
    translate(-location.x + offset.x, -location.y + offset.y);
  }
  
  void translateToView(float z) {
    translate( (-location.x/(z+1) + offset.x), (-location.y/(z+1) + offset.y) );
  }
  
}
