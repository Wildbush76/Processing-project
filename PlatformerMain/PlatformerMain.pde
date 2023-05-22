//main thing

/*
REACH THE PURPLE DOT

WASD for movement
shift for grapple
*/
void setup() {
  size(700, 700);
  mainP = new Player(width/2, height/2, 20, 20);
  theWorld = new World("world.txt");
  mainP.setSpawnPoint(theWorld.spawnPoint);
  endScreen = loadImage("Winner.jpg");
  endScreen.resize(500,500);
}

boolean[] keys = new boolean[256];
boolean[] realKeys = new boolean[256];
boolean running  = true;
PImage endScreen;

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
  background(World.BACKGROUND_R, World.BACKGROUND_G, World.BACKGROUND_B, 255);
  theWorld.drawIt(mainP.getOffset());
  if(running) {
  mainP.run();
  } else {
    image(endScreen,width/2 - 250, height/2 - 250);
  }
}
