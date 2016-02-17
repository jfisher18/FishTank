class Poison extends Pellet {
  Poison() {
    super();
    fillColor = color(255, 0, 0);
  }
  void action(Fish fish) {
    if (fish.timeSincePoison>60) {
      fish.weight-=2;
      fish.timeSincePoison=0;
    } else {
      gone = false;
    }
  }
}