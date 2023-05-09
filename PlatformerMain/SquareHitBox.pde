class SquareHitBox {
  protected int x,y;
  protected int sizeX, sizeY;
  
  SquareHitBox(int x, int y,int sizeX, int sizeY) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  public boolean checkBasicHit(SquareHitBox box) {
      return (x + sizeX > box.x && x < box.x + box.sizeX) && (y + sizeY > box.y && y < box.y + box.sizeY);
  }
  
  public byte advancedHit(SquareHitBox box) {
    if(checkBasicHit(box)) {
      Math.atan2(x - box.x, y - box.y);
      return 0;
    } else {
      return -1;
    }
  }
}
