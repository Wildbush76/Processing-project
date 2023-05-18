// but i don't wanna make a level editor
final int sizeY = 35;
final int blockSize = 20;
int xOffset = 0;
void setup() {
  size(700, 750);
}

boolean[] keys = new boolean[256];
void keyPressed() {//hey guys time for the worst fix ever
  keys[keyCode] = true;
}
void keyReleased() {
  keys[keyCode] = false;
}

void mouseWheel(MouseEvent event) {
  xOffset+= event.getCount() * 5;
  if(xOffset < 0) {
    xOffset = 0;
  }
}
void draw() {
  translate(0, 50);
  background(255, 255, 255);
  if (keys[65] && xOffset > 0) {
    xOffset--;
  } else if(keys[68]) {
    xOffset++;
  }

  for (int y = 0; y <= height; y+= blockSize) {
    line(0, y, width, y);
  }
  for (int x = -xOffset%blockSize; x <= width; x += blockSize) {
    line(x, 0, x, height);
  }
  
  
}
