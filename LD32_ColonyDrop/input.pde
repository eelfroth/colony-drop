
boolean key_thrust, key_left, key_right, key_shoot;

void keyPressed() {
    if(key == CODED) {
      if (keyCode == UP) key_thrust = true;
      if (keyCode == LEFT) key_left = true;
      if (keyCode == RIGHT) key_right = true;
    }else{
      if (key == ' ') {
        key_shoot = true; 
      }
    }
}

void keyReleased() {
  if(key == CODED) {
    if (keyCode == UP) key_thrust = false;
    if (keyCode == LEFT) key_left = false;
    if (keyCode == RIGHT) key_right = false;
  }else{
    if (key == ' ') key_shoot = false;     
        if(mode == "title") startIntro();
        else if(mode == "intro") introText.jumpAhead();
  }
}

