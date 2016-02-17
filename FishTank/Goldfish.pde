class Goldfish extends Fish {
  Goldfish() {
    super();
    fillColor = color(random(200, 255), random(0, 100), random(0, 40));
    weight = 10;
    maxWeight = 30;
    speed = 3;
    velocity = PVector.random2D().setMag(speed);
    maxAge = 20000;
    rank  = 1;
    position.x = random(weight, (width-sidebarLength-weight));
    position.y = random(weight, height-weight);
  }
  Goldfish(float x, float y) {
    this();
    position = new PVector(x, y);
  }
}