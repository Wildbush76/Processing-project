class BasicBlock extends Block {
  protected int[] blockColor = {200, 200, 200};

  public BasicBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }

  public void dont() {
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(x, y, sizeX, sizeY);
  }
}
