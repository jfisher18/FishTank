class Toroidalfin extends Goldfish {
  void edges() {
    if (position.x<-weight) {
      position.x = width-sidebarLength+weight;
    }
    if (position.x>width-sidebarLength+weight) {
      position.x = -weight;
    }
    if (position.y<-weight) {
      position.y = height+weight;
    }
    if (position.y> height+weight) {
      position.y = -weight;
    }
  }
}