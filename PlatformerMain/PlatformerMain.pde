//main thing
void setup() {
  size(700, 700);
  mainP = new Player(width/2, height/2, 20, 20);
  theWorld = new World("world.txt");
  mainP.setSpawnPoint(theWorld.spawnPoint);
}

boolean[] keys = new boolean[256];
void keyPressed() {
  keys[keyCode] = true;
}
void keyReleased() {
  keys[keyCode] = false;
}

Player mainP;
World theWorld;
void draw() {
  background(World.backgroundR, World.backgroundG, World.backgroundB, 255);
  theWorld.drawIt(mainP.getOffset());
  mainP.run();
}
