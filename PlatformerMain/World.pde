class World {
  public static final double gravity = 1;
  public static final int BACKGROUND_R = 162;
  public static final int BACKGROUND_G = 228;
  public static final int BACKGROUND_B = 184;
  public static final int BLOCK_SIZE = 20;

  public final int WORLD_HEIGHT;
  public final int WORLD_LENGTH;
  public int[] spawnPoint = new int[2];
  public Block[] world;

  World(String path) {
    WORLD_HEIGHT = height/BLOCK_SIZE;
    String[] data = loadStrings(path);
    WORLD_LENGTH = Integer.parseInt(data[0]);
    world = new Block[WORLD_HEIGHT * WORLD_LENGTH];

    for (int y = 0; y < WORLD_HEIGHT; y++) {
      String[] row = data[y + 1].split(",");
      for (int x = 0; x < WORLD_LENGTH; x++) {
        int type = Integer.parseInt(row[x]);
        Block theBlock;
        switch(type) {
        case 0://air
          theBlock = new EmptyBlock(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
          break;
        case 1://block
          theBlock = new BasicBlock(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
          break;
        case 2://spawn Point
          theBlock = new SpawnPoint(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
          spawnPoint[0] = x * BLOCK_SIZE;
          spawnPoint[1] = y * BLOCK_SIZE;
          break;
        case 3: // damage block
          theBlock = new DamageBlock(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
          break;
        case 4:// grapple node
          theBlock = new GrappleNode(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
          break;
        case 5:
        theBlock = new Goal(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
        break;
        default:
          theBlock =  new EmptyBlock(x * BLOCK_SIZE, y * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
          break;
        }
        world[y * WORLD_LENGTH + x] = theBlock;
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
      int index = ((int)currentX / BLOCK_SIZE) + ((int)currentY / BLOCK_SIZE) * WORLD_LENGTH;
      if (world[index].getHitBoxStatus()) {
        return false;
      }
    } while (distance > BLOCK_SIZE);
    return true;
  }
  //idk man
}
