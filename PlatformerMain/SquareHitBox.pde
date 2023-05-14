class SquareHitBox {
  protected int x, y, sizeX, sizeY;

  SquareHitBox(int x, int y, int sizeX, int sizeY) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }

  public boolean checkHit(SquareHitBox box) {
    return (x + sizeX >= box.x && x <= box.x + box.sizeX) && (y + sizeY >= box.y && y <= box.y + box.sizeY);
  }
}
