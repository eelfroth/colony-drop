
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
