class Piranha extends Fish {
  Piranha() {
    super();
    fillColor = color(random(0, 150), random(100, 200), random(100, 200));
    weight = 15;
    maxWeight = 50;
    speed = 2;
    velocity = PVector.random2D().setMag(speed);
    maxAge = 10000;
    rank  = 2;
    position.x = random(weight, (width-sidebarLength-weight));
    position.y = random(weight, height-weight);
  }
  Piranha(float x, float y) {
    this();
    position = new PVector(x, y);
  }
  void move() {
    if (timeSinceFood>60) {
      Fish closest = null;
      float bigDist = 10000000;
      for (Fish fish : fishList) {
        if (dist(fish.position.x, fish.position.y, position.x, position.y)<bigDist&&fish.rank<rank&&!fish.isDead) {
          closest = fish;
          bigDist = dist(fish.position.x, fish.position.y, position.x, position.y);
        }
      }
      if (closest != null) {
        velocity = PVector.sub(closest.position, position).setMag(speed);
      }
    }
    super.move();
  }
}