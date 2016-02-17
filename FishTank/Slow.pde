class Slow extends Pellet {
  Slow() {
    super();
    fillColor = color(204, 30, 204);
  }
  void action(Fish fish) {
    fish.slow();
  }
}