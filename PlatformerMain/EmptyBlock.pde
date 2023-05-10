public class EmptyBlock extends Block {
  public EmptyBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }
  public void dont() {
    //nothing its just like nothing, its empty (i need or code will shit itself)
  }

  public boolean checkBasicHit(SquareHitBox box) {
    return false;// you just dont hit it
  }

  public byte advancedHit(SquareHitBox box) {
    return -1;// you can't hit it, its like air
  }
}
