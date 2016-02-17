class Bubble {
  float size;
  PVector position = new PVector();
  boolean gone;
  float speed;
  Bubble() {
    size = random(2, 13);
    position.x = random(0, width-sidebarLength);
    position.y = height+size;
    speed = size*2/5;
  }
  void update() {
    stroke(255);
    strokeWeight(1);
    fill(166, 223, 248, 100);
    ellipse(position.x, position.y, size, size);
    position.y-=speed;
    if (position.y<-2*size) {
      gone = true;
    }
  }
}