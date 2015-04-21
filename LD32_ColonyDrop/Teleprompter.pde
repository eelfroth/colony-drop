class Teleprompter {
  String[] text, lines;
  String myString;
  PVector location;
  int width;
  int counter, timer, frequency,  no_lines;
  
  Teleprompter(String filename, int _no_lines , float x, float y, int _width, int _frequency) {
    no_lines = _no_lines;
    lines = new String[no_lines];
    for (int i=0; i<no_lines; i++) {
        lines[i] = "";
      }    
    text = loadStrings("story.txt");
    location = new PVector(x, y);
    width = _width;
    counter = 0;
    timer = 0;
    frequency = _frequency;
    myString= "";
  }
  
  void update(int delta) {
    timer += delta;
    if(timer >= frequency) {
      timer -= frequency;
      
      updateString();
    }
  }
  
  void updateString() {
    if( counter == text.length )
      startGame();
    else if (text[counter].length() == 0) {
      counter++;
      if(counter >= no_lines) {
        for (int i=0; i<no_lines-1; i++) {
          lines[i] = lines[i+1];
        }  
        lines[no_lines-1] = "";
      }
      if(counter == 8 || counter == 24 ) {
        introImageCounter++;
      }
      //myString += "\n";
     }
    else {
      if(counter < no_lines)
        lines[counter] += text[counter].charAt(0);
      else
        lines[no_lines-1] += text[counter].charAt(0);
      
      /*if(text[counter].charAt(0) == ' ') {
        timer -= frequency/2;          
      }*/
      
      text[counter] = text[counter].substring(1);
    }
    
    myString = "";
    for (int i=0; i<no_lines; i++) {
      myString += lines[i] + "\n";
    }
  }
  
  void jumpAhead() {
    int c = counter;
    while(counter == c){
      updateString();
    }
    while(counter%4 != 0 && counter < text.length) {
      updateString();
    }
  }
  
  void display() {
    pushMatrix();
      
      translate(location.x, location.y);
      
      fill(0, 200);
      //noFill();
      stroke(#629D67);
      rect(0, 0, width, 24*no_lines);
      fill(#629D67);
      textAlign(LEFT);
      text(myString, 8, 20);
      
    popMatrix();
  }
  
}
