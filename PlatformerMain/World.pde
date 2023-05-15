class World {
  public static final double gravity = 1;
  public static final int backgroundR = 162;
  public static final int backgroundG = 228;
  public static final int backgroundB = 184;
  public static final int blockSize = 20;

  public final int worldHeight;
  public final int worldLength;

  public Block[] world;

  World(String path) {
    worldHeight = height/blockSize;
    String[] data = loadStrings(path);
    worldLength = Integer.parseInt(data[0]);
    world = new Block[worldHeight * worldLength];

    for (int y = 0; y < worldHeight; y++) {
      String[] row = data[y + 1].split(",");
      for (int x = 0; x < worldLength; x++) {
        int type = Integer.parseInt(row[x]);
        Block theBlock;
        switch(type) {
        case 0://air
          theBlock = new EmptyBlock(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        case 1://block
          theBlock = new BasicBlock(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        case 2:
        theBlock = new SpawnPoint(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        default:
          theBlock =  new EmptyBlock(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        }
        world[y * worldLength + x] = theBlock;
      }
    }
  }

  public void drawIt(int xOffset) {
    translate(-xOffset, 0);
    for (Block i : world) {
      i.dont(xOffset);
    }
  }
  //idk man
}
