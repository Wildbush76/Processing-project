//main thing

/*
To do list (no specific order) * is important
 * make good level
 * add coin things
 add enenimes
 add sword
 looking into better logic
 add sprites
 add sound
 
 */
void setup() {
  size(700, 700);
  mainP = new Player(width/2, height/2, 20, 20);
  theWorld = new World("world.txt");
  mainP.setSpawnPoint(theWorld.spawnPoint);
}

boolean[] keys = new boolean[256];
boolean[] realKeys = new boolean[256];
void keyPressed() {//hey guys time for the worst fix ever
  if (!realKeys[keyCode]) {
    keys[keyCode] = true;
    realKeys[keyCode] = true;
  }
}
void keyReleased() {
  keys[keyCode] = false;
  realKeys[keyCode] = false;
}

Player mainP;
World theWorld;
void draw() {
  background(World.backgroundR, World.backgroundG, World.backgroundB, 255);
  theWorld.drawIt(mainP.getOffset());
  mainP.run();
}
