class Whale extends Fish {
  float deltaV = 0;
  Whale(float x, float y) {
    this();
    position = new PVector(x, y);
  }
  Whale() {
    super();
    fillColor = color(random(50, 200));
    weight = 35;
    maxWeight = 100;
    speed = 1;
    velocity = PVector.random2D().setMag(speed);
    maxAge = 30000;
    rank  = 3;
    position.x = random(weight, (width-sidebarLength-weight));
    position.y = random(weight, height-weight);
  }
  void move() {
    super.move();
    deltaV+=random(-.001, .001);
    deltaV= constrain(deltaV, -.02, .02);
    velocity.rotate(deltaV);
  }
}