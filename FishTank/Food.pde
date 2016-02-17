class Food extends Pellet {
  Food() {
    super();
    fillColor = color(0, 255, 0);
  }
  void action(Fish fish) {
    if (fish.timeSinceFood>60) {
      fish.weight+=2;
      fish.timeSinceFood=0;
    } else {
      gone = false;
    }
  }
}