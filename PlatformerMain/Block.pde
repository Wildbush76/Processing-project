abstract class Block extends SquareHitBox {//just your very basic dumb block
  protected int[] blockColor;

  public Block(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }
  public abstract void dont();
  
}
