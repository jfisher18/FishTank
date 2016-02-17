class Fish {
  float weight, maxWeight, speed;
  int age, maxAge;
  boolean isDead, gone;
  float mult = 1;
  PVector position = new PVector();
  PVector velocity = new PVector();
  float alphaValue;
  String cause;
  float theta, deltaTheta;
  float timeSinceFood = 300;
  float timeSincePoison = 300;
  float tailLength;
  float deltaTailLength = -.01;
  color fillColor;
  char gender;
  int rank;
  IntList fastEffect = new IntList();
  IntList slowEffect= new IntList();
  String name;
  boolean noNeed = false;
  boolean isToroidalfin = (this.getClass() == ref);
  Fish(float x, float y) {
    this();
    position = new PVector(x, y);
  }
  Fish() {
    fillColor = color(random(200, 255), random(0, 100), random(0, 40));
    age = 0;
    maxAge = 20000;
    speed = 3;
    weight = 10;
    position.x = random(weight, (width-sidebarLength-weight));
    position.y = random(weight, height-weight);
    for (Fish fish : fishList) {
      while (dist(fish.position.x, fish.position.y, position.x, position.y)<=(fish.weight+weight)&&fish!=this&&!fish.isDead) {
        position.x = random(0, (width-sidebarLength));
        position.y = random(0, height);
      }
    }
    maxWeight = 30;
    alphaValue  = 255;
    deltaTheta = .002;
    tailLength=1;
    int rand = round(random(0, 1));
    if (rand==0) {
      gender = 'f';
      String[] names = loadStrings("data/Girl Names.txt");
      name = names[floor(random(0, names.length))];
    } else {
      gender = 'm';
      String[] names = loadStrings("data/Boy Names.txt");
      name = names[floor(random(0, names.length))];
    }
    if (name.trim().equals("Jake")) {
      println("A great fish has been born");
    }
  }
  void update() {
    show(position, weight);
    if (isDead) {
      if (position.y>=weight) {
        position.y-=2;
      }
      alphaValue-=.5;
      if (alphaValue<0) {
        gone = true;
      }
    } else {
      /*
      if (mouseX>0&&mouseX<width-sidebarLength&&mouseY>0&&mouseY<height) {
       velocity = new PVector(mouseX-position.x, mouseY-position.y).setMag(speed);
       }
       */
      age++;
      weight+=.002;
      ammonia+=.001;
      timeSinceFood++;
      timeSincePoison++;
      mult = 1;
      for (int i = 0; i < fastEffect.size(); i++) {
        fastEffect.increment(i);
        mult*=2;
        if (fastEffect.get(i)>300) {
          fastEffect.remove(i);
          i--;
        }
      }
      for (int i = 0; i < slowEffect.size(); i++) {
        slowEffect.increment(i);
        mult/=2;
        if (slowEffect.get(i)>300) {
          slowEffect.remove(i);
          i--;
        }
      }
      move();
      if (age>maxAge) {
        isDead = true;
        cause = "Too old";
      }
      if (weight>maxWeight) {
        isDead = true;
        cause = "Too big";
      }
      if (weight<.1*maxWeight) {
        isDead = true;
        cause = "Too small";
      }
      if (ammonia>100) {
        int rand = int(random(0, 600000.0/ammonia));
        if (rand<1) {
          isDead= true;
          cause = "Ammonia";
        }
      }
    }
  }
  void show(PVector position, float weight) {
    if (isToroidalfin) {
      stroke(fillColor, alphaValue);
      fill(0, 0, 0, 0);
    } else {
      fill(fillColor, alphaValue);
      stroke(0, 0, 0, 0);
    }
    ellipse(position.x, position.y, weight, weight);
    if (!isDead) {
      theta+=deltaTheta*mult;
      if (abs(theta)>PI/40) {
        deltaTheta*=-1;
      }
      tailLength+=deltaTailLength*mult;
      if (tailLength>=1||tailLength<=.75) {
        deltaTailLength*=-1;
      }
    }
    PVector v1 = PVector.mult(velocity, -1).rotate(PI/8+theta).setMag(weight/.6);
    PVector v2 = PVector.mult(velocity, -1).rotate(-PI/8-theta).setMag(weight/.6);
    triangle(position.x, position.y, position.x+v1.x, position.y+v1.y, position.x+v2.x, position.y+v2.y);
    v1 = velocity.copy().mult(-1).setMag(weight*tailLength);
    v2 = velocity.copy().mult(-1).rotate(PI/4).setMag(weight/2);
    PVector v3 = velocity.copy().mult(-1).rotate(-PI/4).setMag(weight/2);
    if (isToroidalfin) {
      stroke(red(fillColor)-50, green(fillColor)-50, blue(fillColor)-50, alphaValue);
      fill(0, 0, 0, 0);
    } else {
      fill(red(fillColor)-50, green(fillColor)-50, blue(fillColor)-50, alphaValue);
      stroke(0, 0, 0, 0);
    }
    triangle(position.x+v1.x, position.y+v1.y, position.x+v2.x, position.y+v2.y, position.x+v3.x, position.y+v3.y);
    stroke(0, 0, 0, 0);
    fill(255, alphaValue);
    ellipse(position.x+weight*velocity.x/(speed*6), position.y+weight*velocity.y/(speed*6), weight/3, weight/3);
    fill(0, alphaValue);
    ellipse(position.x+weight*velocity.x/(speed*6), position.y+weight*velocity.y/(speed*6), weight/7, weight/7);
    if (this==currentFish) {
      fill(255, 255, 0);
      triangle(position.x, position.y-weight-5, position.x-10, position.y-weight-15, position.x+10, position.y-weight-15);
    }
  }
  void move() {
    position.add(PVector.mult(velocity,mult));
    edges();
    for (Fish fish : fishList) {
      if (dist(fish.position.x, fish.position.y, position.x, position.y)<=(fish.weight+weight)&&fish!=this&&!fish.isDead&&!fish.gone) {
        if (rank>fish.rank&&timeSinceFood>0) {
          timeSinceFood = 0;
          weight+=fish.weight/4;
          fish.gone = true;
        } else if (fish.rank>rank&&fish.timeSinceFood>60) {
          fish.timeSinceFood = 0;
          fish.weight+=weight/4;
          gone = true;
        } else {
          PVector reflect = PVector.sub(position, fish.position).normalize();
          velocity.sub(reflect.mult(2*reflect.dot(velocity))).setMag(speed);
          fish.position = PVector.add(position, reflect.setMag(fish.weight+weight));
          if (this.getClass() == fish.getClass()) {
            if (gender!=fish.gender) {
              if (!noNeed) {
                fish.noNeed = true;
                //fishList.add(new Fish((position.x+fish.position.x)/2, (position.y+fish.position.y)/2));
              } else {
                noNeed = false;
              }
            }
          }
        }
      }
    }
  }
  void edges() {
    if (position.x<=weight) {
      position.x = weight;
      velocity.x*=-1;
    }
    if (position.x>=width-sidebarLength-weight) {
      position.x=width-sidebarLength-weight;
      velocity.x*=-1;
    }
    if (position.y<=weight) {
      position.y = weight;
      velocity.y*=-1;
    }
    if (position.y>=height-weight) {
      position.y=height-weight;
      velocity.y*=-1;
    }
  }
  void slow() {
    slowEffect.append(0);
  }
  void fast() {
    if (fastEffect.size()<=2) {
      fastEffect.append(0);
    }
  }
  boolean isOver() {
    return(dist(mouseX, mouseY, position.x, position.y)<=weight);
  }
  String toString() {
    String genName;
    if (gender == 'm') {
      genName="Male";
    } else {
      genName="Female";
    }
    String info = ("Name: "+name+",Gender: "+genName+",Species: "+split(this.getClass().toString(), "$")[1]+",Weight: "+nfc(weight, 3)+",Age: "+age+" frames,Maximum Weight: "+maxWeight+",Maximum Age: "+maxAge+" frames");
    if (isDead) {
      info+=",Cause of Death: "+cause;
    } else {
      info+=",Speed: "+(nfc(velocity.mag()*mult, 1))+" pixels per frame";
    }
    return info;
  }
}