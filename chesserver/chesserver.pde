import processing.net.*;

Server myServer;

color lightbrown = #FFFFC3;
color darkbrown  = #D8864E;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
int r, c, i;
boolean firstclick=false;
int row1, col1, row2, col2;

char grid[][] = {
  {'R', 'B', 'N', 'Q', 'K', 'N', 'B', 'R'}, 
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'b', 'n', 'q', 'k', 'n', 'b', 'r'}
};

void setup() {
  size(800, 800);
  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
  myServer = new Server(this, 1234);
}

void draw() {
  drawBoard();
  drawPieces();
  recieveMove();
}
void recieveMove() {
  Client myClient = myServer.available();
  if (myClient!=null) {
    String incoming=myClient.readString();
    int r1 = int( incoming.substring(0, 1));
    int c1 = int(incoming.substring(2, 3));
    int r2 = int( incoming.substring(4, 5));
    int c2 = int(incoming.substring(6, 7));
    grid[r2][c2]=grid[r1][c1];
    grid[r1][c1]=' ';
  }
}
void drawBoard() {
  int x = 0;
  int y = 0;
  while (y < 8) {
    if ( (x%2) == (y%2) ) { 
      fill(lightbrown);
    } else { 
      fill(darkbrown);
    }
    rect(x*100, y*100, 100, 100);
    x++;
    if (x == 8) {
      x = 0;
      y++;
    }
  }
}

void drawPieces() {
  r=0;
  c=0;
  while (r<8) {
    while (c<8) {
      if (grid[c][r]=='p') image(wpawn, r*100, c*100, 100, 100);
      if (grid[c][r]=='P') image(bpawn, r*100, c*100, 100, 100);
      if (grid[c][r]=='r') image(wrook, r*100, c*100, 100, 100);
      if (grid[c][r]=='b') image(wbishop, r*100, c*100, 100, 100);
      if (grid[c][r]=='n') image(wknight, r*100, c*100, 100, 100);
      if (grid[c][r]=='q') image(wqueen, r*100, c*100, 100, 100);
      if (grid[c][r]=='k') image(wking, r*100, c*100, 100, 100);
      if (grid[c][r]=='R') image(brook, r*100, c*100, 100, 100);
      if (grid[c][r]=='B') image(bbishop, r*100, c*100, 100, 100);
      if (grid[c][r]=='N') image(bknight, r*100, c*100, 100, 100);
      if (grid[c][r]=='Q') image(bqueen, r*100, c*100, 100, 100);
      if (grid[c][r]=='K') image(bking, r*100, c*100, 100, 100);
      c++;
    }
    c=0;
    r++;
  }

  println(""+firstclick);
}

void mouseReleased() {
  if (firstclick==false) {
    row1=mouseX/100;
    col1=mouseY/100;
    firstclick=true;
  } else if (firstclick==true) {
    row2=mouseX/100;
    col2=mouseY/100;
    grid[col2][row2]=grid[col1][row1];
    grid[col1][row1]=' ';
    myServer.write(row1 + "," + col1 + "," + row2 + "," + col2);
    firstclick=false;
  }
}
