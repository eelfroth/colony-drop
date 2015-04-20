
/*
  From Polar Coordinates (r,θ) 
  to Cartesian Coordinates (x,y)  :
  x = r × cos( θ )
  y = r × sin( θ )  
  
  From Cartesian Coordinates (x,y) 
  to Polar Coordinates (r,θ)
  r = √ ( x2 + y2 )
  θ = tan-1 ( y / x )
*/
    
PVector polarVector(float rot, float mag) {
  PVector v = new PVector( mag * cos(rot), mag * sin(rot) );
  return v;
}

/* 
  Collision detection
  
*/

boolean collisionRectRect(float x1, float y1, int w1, int h1, float x2, float y2, int w2, int h2) {
  //if(x1 >= x2 && x1 < x2+w2
  return false;
}
