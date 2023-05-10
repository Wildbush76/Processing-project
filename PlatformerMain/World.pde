class World {
  public static final double gravity = 0.8;///waaa waa i dont wanna do quadric formula;
  public static final int backgroundR = 162;
  public static final int backgroundG = 228;
  public static final int backgroundB = 184;
  public static final int blockSize = 20;

  public Block[] world;

  World(String path) {
    String[] data = loadStrings(path);
    int worldLength = Integer.parseInt(data[0]);
    world = new Block[height/blockSize * worldLength];
    for (int y = 1; y < data.length; y++) {
      String[] row = data[y].split(",");
      for (int x = 0; x < row.length; x++) {
        int type = Integer.parseInt(row[x]);
        switch(type) {
        case 0:
          world[(y-1) * worldLength + x] = new EmptyBlock(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        case 1:
          world[(y-1) * worldLength + x] = new BasicBlock(x * blockSize, y * blockSize, blockSize, blockSize);
          break;
        }
      }
    }
  }

  public void drawIt() {
    for(Block b : world) {
      b.dont();
    }
  }
  //idk man
}
