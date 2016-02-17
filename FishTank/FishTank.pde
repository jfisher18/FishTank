/*
Fish Tank
by Jake Fisher
 Requires Processing 3
 Notes
 -all extensions/challenges (and more!) except for babies
 -click on fish to see their infos
 */
final float sidebarLength = 300;
ArrayList<Fish> fishList = new ArrayList<Fish>();
ArrayList<Bubble> bubbles1 = new ArrayList<Bubble>();
ArrayList<Bubble> bubbles2 = new ArrayList<Bubble>();
ArrayList<Pellet> pelletList = new ArrayList<Pellet>();
ArrayList<Button> buttonList = new ArrayList<Button>();
Class ref;
Fish currentFish;
float ammonia = 0;
float textSpace = 175;
void setup() {
  //size(1300, 800);
  fullScreen();
  ellipseMode(RADIUS);
  buttonList.add(new Button(1, "New Goldfish"));
  buttonList.add(new Button(2, "New Pirahna"));
  buttonList.add(new Button(3, "New Whale"));
  buttonList.add(new Button(4, "New Toroidalfin"));
  buttonList.add(new Button(5, "Sprinkle Food"));
  buttonList.add(new Button(6, "Sprinkle Poison"));
  buttonList.add(new Button(7, "Sprinkle Slowness"));
  buttonList.add(new Button(8, "Sprinkle Speed"));
  buttonList.add(new Button(9, "Clean the Tank"));
  buttonList.add(new Button(10, "Tap the Tank"));
  buttonList.add(new Button(11, "Kill all Fish"));
  ref = new Toroidalfin().getClass();
}
void draw() {
  background(0, 185, 209);
  textAlign(CENTER, CENTER);
  //bubbles1
  int random = int(random(0, 20));
  if (random ==2) {
    bubbles1.add(new Bubble());
  }
  for (Bubble bubble : bubbles1) {
    bubble.update();
  }
  for (int i=0; i< bubbles1.size(); i++) {
    if (bubbles1.get(i).gone) {
      bubbles1.remove(i);
      i--;
    }
  };
  //fish
  noStroke();
  for (Fish fish : fishList) {
    fish.update();
  }
  for (int i=0; i< fishList.size(); i++) {
    if (fishList.get(i).gone) {
      fishList.remove(i);
      i--;
    }
  };

  //pellets
  for (Pellet pellet : pelletList) {
    pellet.update();
  }
  for (int i=0; i< pelletList.size(); i++) {
    if (pelletList.get(i).gone||pelletList.get(i).offScreen()) {
      pelletList.remove(i);
      i--;
    }
  }
  //bubbles2
  random = int(random(0, 20));
  if (random ==2) {
    bubbles2.add(new Bubble());
  }
  for (Bubble bubble : bubbles2) {
    bubble.update();
  }
  for (int i=0; i< bubbles2.size(); i++) {
    if (bubbles2.get(i).gone) {
      bubbles2.remove(i);
      i--;
    }
  };
  //ammonia
  noStroke();
  fill(139, 234, 148, constrain(ammonia, 0, 200));
  rect(0, 0, width-sidebarLength, height);
  //buttons
  noStroke();
  fill(52, 152, 219);
  rect(width-sidebarLength, 0, sidebarLength, height);
  //Fish Data
  if (currentFish != null) {
    textAlign(LEFT, CENTER);
    textSize(16);
    fill(255);
    float textY = height - (textSpace-20);
    for (String line : currentFish.toString().split(",")) {
      text(line, width-sidebarLength+25, textY);
      textY+=18;
    }
    currentFish.show(new PVector(width-75, height-textSpace+50), constrain(currentFish.weight/1.5, 0, 45));
    if (currentFish.gone) {
      currentFish= null;
    }
  }
  for (Button button : buttonList) {
    button.update();
  }
}
void mouseClicked() {
  for (Button button : buttonList) {
    if (button.isOver()) {
      button.action();
    }
  }
  if (mouseX<width-sidebarLength) {
    boolean none = true;
    for (Fish fish : fishList) {
      if (fish.isOver()) {
        none = false;
        currentFish = fish;
      }
    }
    if (none) {
      currentFish = null;
    }
  }
}