class World {

  public static final double gravity = 0.8;///waaa waa i dont wanna do quadric formula;
  public static final int backgroundR = 162;
  public static final int backgroundG = 228;
  public static final int backgroundB = 184;
  public static final int blockSize = 20;

  public int[][] world;
  World(String path) {
    String[] data = loadStrings(path);
    int worldLength = Integer.parseInt(data[0]);
    world = new int[height/blockSize][worldLength];
      for (int y = 1; y < data.length; y++) {
      String[] row = data[y].split(",");
        for (int x = 0; x < row.length; x++) {
        world[y-1][x] = Integer.parseInt(row[x]);
      }
    }
  }
  //idk man
}
