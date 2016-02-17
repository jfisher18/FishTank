class Pellet {
  color fillColor;
  boolean gone;
  PVector position = new PVector();
  PVector velocity = new PVector(0, 0.5);
  PVector acceleration = new PVector(0, .001);
  Pellet() {
    fillColor = color(0, 0, 0);
    position.x = random(0, (width-sidebarLength));
    position.y = random(-3, -10);
    ;
  }
  void update() {
    noStroke();
    fill(fillColor);
    ellipse(position.x, position.y, 5, 5);
    for (Fish fish : fishList) {
      if (dist(fish.position.x, fish.position.y, position.x, position.y)<5+fish.weight&&!fish.isDead) {
        gone = true;
        action(fish);
        break;
      }
    }
    if (position.y>=height-5) {
      position.y=height-5;
    } else {
      position.add(velocity);
      velocity.add(acceleration);
    }
  }
  void action(Fish fish) {
  }
  boolean offScreen() {
    return(position.y>height+5);
  }
}