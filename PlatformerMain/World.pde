class World {
  public static final double gravity = 1;
  public static final int backgroundR = 162;
  public static final int backgroundG = 228;
  public static final int backgroundB = 184;
  public static final int blockSize = 20;

  public final int worldHeight;
  public final int worldLength;
  public int[] spawnPoint = new int[2];
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
        case 2://spawn Point
          theBlock = new SpawnPoint(x * blockSize, y * blockSize, blockSize, blockSize);
          spawnPoint[0] = x * blockSize;
          spawnPoint[1] = y * blockSize;
          break;
        case 3: // damage block
          theBlock = new DamageBlock(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        case 4:// grapple node
          theBlock = new GrappleNode(x * blockSize, y * blockSize, blockSize, blockSize);
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

  public boolean checkLineOfSight(int x1, int y1, int x2, int y2) {
    double angle = Math.atan2(x2 - x1, y2 - y1);
    double currentX = x1;
    double currentY = y1;
    double dX = Math.sin(angle);
    double dY = Math.cos(angle);
    double distance;
    do {
      distance = Math.sqrt(Math.pow(currentX - x2, 2) + Math.pow(currentY - y2, 2));
      currentX += dX;
      currentY += dY;
      int index = ((int)currentX / blockSize) + ((int)currentY / blockSize) * worldLength;
      if (world[index].getHitBoxStatus()) {
        return false;
      }
    } while (distance > blockSize);
    return true;
  }
  //idk man
}
