// but i don't wanna make a level editor
final int sizeY = 35;
final int blockSize = 20;
int xOffset = 0;
int currentType = 1;
boolean[] keys = new boolean[256];
ArrayList<ArrayList<Block>> world = new ArrayList<ArrayList<Block>>(35);


void setup() {
  size(700, 750);
  for (int y = 0; y < height/blockSize; y++) {
    ArrayList<Block> row = new ArrayList<Block>(35);
    for (int x = 0; x < width/blockSize; x++) {
      row.add(new Block(x * blockSize, y * blockSize));
    }
    world.add(row);
  }
  //empty block - 255, 255, 255
  blockColors[0][0] = 255;
  blockColors[0][1] = 255;
  blockColors[0][2] = 255;
  //basic block - 200, 200, 200
  blockColors[1][0] = 200;
  blockColors[1][1] = 200;
  blockColors[1][2] = 200;
  //spawnPoint block - 62, 196, 247
  blockColors[2][0] = 62;
  blockColors[2][1] = 196;
  blockColors[2][2] = 247;
  //damage block - 162, 240, 19
  blockColors[3][0] = 162;
  blockColors[3][1] = 240;
  blockColors[3][2] = 19;
  //grapple node - 126, 126, 126
  blockColors[4][0] = 126;
  blockColors[4][1] = 126;
  blockColors[4][2] = 126;
}


void keyPressed() {
  keys[keyCode] = true;
}
void keyReleased() {
  keys[keyCode] = false;
}

void mousePressed() {
  if (mouseY > 50) {
    mouseDragged();
  } else {
    if (mouseX < blockColors.length * blockSize) {
      currentType = mouseX/blockSize;
    }
  }
}

void mouseDragged() {
  int x = (mouseX + xOffset)/blockSize;
  int y = (mouseY - 50)/blockSize;
  world.get(y).get(x).setType(currentType);
}

void mouseWheel(MouseEvent event) {
  xOffset+= event.getCount() * 5;
  if (xOffset < 0) {
    xOffset = 0;
  }
}

int[][] blockColors = new int[5][3];
void draw() {
  background(255, 255, 255);
  for (int i = 0; i < blockColors.length; i++) {
    int[] c = blockColors[i];
    fill(c[0], c[1], c[2]);
    rect(i * blockSize, 0, blockSize, blockSize, 5, 5, 5, 5);
  }

  translate(-xOffset, 50);

  if (keys[65] && xOffset > 0) {
    xOffset--;
  } else if (keys[68]) {
    xOffset++;
  }

  if (keys[32]) {
    keys[32] = false;
    String[] output = new String[height/blockSize + 1];
    output[0] = "" + world.get(0).size();

    for (int i = 0; i < world.size(); i ++) {
      String row = "";
      for (int b = 0; b < world.get(i).size(); b++) {
        row += world.get(i).get(b).getType() + ",";
      }

      output[i + 1] = row.substring(0, row.length()-1) ;
    }
    saveStrings("word.txt", output);
  }

  if ((xOffset +width)/blockSize >= world.get(0).size()) {
    int x = world.get(0).size();
    x *= blockSize;
    for (int y = 0; y < height/blockSize; y++) {
      world.get(y).add(new Block(x , y*blockSize));
    }
  }

  for (ArrayList<Block> row : world) {
    for (Block b : row) {
      b.dont();
    }
  }
}
