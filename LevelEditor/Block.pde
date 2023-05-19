class Block {
  private int x = 0;
  private int y = 0;
  private int[] bColor = new int[3];
  private int type;

  public Block(int x, int y) {
    this.x = x;
    this.y = y;
    this.type = 0;
    this.bColor[0] = 255;
    this.bColor[1] = 255;
    this.bColor[2] = 255;
  }

  public void dont() {
    fill(bColor[0], bColor[1], bColor[2]);
    rect(x, y, blockSize, blockSize, 5, 5, 5, 5);
  }

  public void setType(int type) {
    this.type = type;
    switch(type) {
    case 0://air
      this.bColor[0] = 255;
      this.bColor[1] = 255;
      this.bColor[2] = 255;
      break;
    case 1://basic
      this.bColor[0] = 200;
      this.bColor[1] = 200;
      this.bColor[2] = 200;
      break;
    case 2://spawnPoint 62, 196, 247
      this.bColor[0] = 62;
      this.bColor[1] = 196;
      this.bColor[2] = 247;
      break;
    case 3://damage 162, 240, 19
      this.bColor[0] = 162;
      this.bColor[1] = 240;
      this.bColor[2] = 19;
      break;
    case 4://grapple node 126, 126, 126
      this.bColor[0] = 126;
      this.bColor[1] = 126;
      this.bColor[2] = 126;
      break;
    }
  }

  public int getType() {
    return type;
  }
}
