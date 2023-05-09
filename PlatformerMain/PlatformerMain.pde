//main thing
void setup() {
  size(700,700);
  mainP = new Player(width/2,height/2,20,20);
}

boolean[] keys = new boolean[256];
void keyPressed() {
  keys[keyCode] = true;
  println(keyCode);
}
void keyReleased() {
  keys[keyCode] = false;
}

Player mainP;
void draw() {
  background(World.backgroundR, World.backgroundG, World.backgroundB);
  mainP.run();
}
