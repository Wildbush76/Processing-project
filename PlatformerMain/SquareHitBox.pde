class SquareHitBox {
  protected int x, y, sizeX, sizeY;
  protected boolean hitBox;

  SquareHitBox(int x, int y, int sizeX, int sizeY) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    hitBox = true;
  }

  public boolean checkHit(SquareHitBox box) {
    return hitBox && (x + sizeX > box.x && x < box.x + box.sizeX) && (y + sizeY > box.y && y < box.y + box.sizeY);
  }
  public boolean checkHit(int xPos, int yPos, int blockWidth, int blockHeight) {
    return hitBox && (x + sizeX > xPos && x < xPos + blockWidth) && (y + sizeY > yPos && y < yPos + blockHeight);
  }
}
