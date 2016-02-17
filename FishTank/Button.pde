class Button {
  float size = 50;
  int numRow = 6;
  int numColumn = 2;
  float pad;
  float xPos, yPos;
  String text;
  Button(int number, String text_) {
    text = text_;
    pad = sidebarLength/(numColumn)/2;
    int column = (number-1)%(numColumn)+1;
    int row = (number-1)/(numColumn)+1;
    float xSpace = ((sidebarLength-pad*2)/(numColumn-1));
    float ySpace = (((height-textSpace)-pad*2)/(numRow-1));
    xPos = (width-sidebarLength)+pad+((column-1)*xSpace);
    yPos = pad+ySpace*(row-1);
  }
  void update() {
    textAlign(CENTER, CENTER);
    noStroke();
    fill(231, 76, 60);
    if (isOver()) {
      fill(211, 56, 40);
    }
    if (isOver()&& mousePressed) {
      fill(191, 36, 20);
    }
    ellipse(xPos, yPos, size, size);
    textSize(12);
    textSize(12*(size*2-15)/textWidth(text));
    fill(255);
    text(text, xPos, yPos);
  }
  boolean isOver() {
    return(dist(mouseX, mouseY, xPos, yPos)<=size);
  }
  void action() {
    if (text=="New Goldfish") {
      for(int i = 0; i<20; i++)
      fishList.add(new Goldfish());
    } else if (text=="New Pirahna") {
      for(int i = 0; i<20; i++)
      fishList.add(new Piranha());
    } else if (text=="New Whale") {
      for(int i = 0; i<20; i++)
      fishList.add(new Whale());
    } else if (text=="New Toroidalfin") {
      for(int i = 0; i<20; i++)
      fishList.add(new Toroidalfin());
    } else if (text=="Sprinkle Food") {
      for (int i = 0; i <8; i++) {
        pelletList.add(new Food());
      }
    } else if (text=="Sprinkle Poison") {
      for (int i = 0; i <8; i++) {
        pelletList.add(new Poison());
      }
    } else if (text=="Sprinkle Speed") {
      for (int i = 0; i <8; i++) {
        pelletList.add(new Fast());
      }
    } else if (text=="Sprinkle Slowness") {
      for (int i = 0; i <8; i++) {
        pelletList.add(new Slow());
      }
    } else if (text=="Tap the Tank") {
      for (Fish fish : fishList) {
        if (!fish.isDead) {
          fish.velocity.mult(-1);
          fish.velocity = PVector.random2D().setMag(fish.speed);
          int rand = int(random(0, 2000000.0/fish.age));
          if (rand<=1) {
            fish.isDead = true;
            fish.cause="Tank tapping";
          }
        }
      }
    } else if (text=="Clean the Tank") {
      ammonia = 0;
      pelletList = new ArrayList<Pellet>();
      for (Fish fish : fishList) {
        if (fish.isDead) {
          fish.gone = true;
        }
      }
    } else if (text=="Kill all Fish") {
      for (Fish fish : fishList) {
        if (!fish.isDead) {
          fish.isDead = true;
          fish.cause = "Murdered";
        }
      }
    }
  }
}