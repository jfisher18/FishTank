class Fast extends Pellet {
  Fast() {
    super();
    fillColor = color(255);
  }
  void action(Fish fish) {
    fish.fast();
  }
}