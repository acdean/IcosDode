class Tets extends ArrayList<Tet> {
  int COUNT = 50;

  Tets() {
    for (int i = 0 ; i < COUNT ; i++) {
      add(new Tet());
    }
  }
  
  void draw() {
    for (int i = 0 ; i < COUNT ; i++) {
      get(i).draw();
    }
  }
}

class Tet {
  float gx, gy, gz;  // global rotation, ie position
  float gdx, gdy, gdz;  // global delta
  float rx, ry, rz;  // local rotation
  float dx, dy, dz;
  color c;
  float r;
  float sz;
  float MAX_ROT = .05;
  float A = 0.70710678118654752440084436210485f;

  PVector[] points = new PVector[] {
    new PVector(1 + r(), 0 + r(), -A + r()),
    new PVector(-1 + r(), 0 + r(), -A + r()),
    new PVector(0 + r(), 1 + r(), A + r()),
    new PVector(0 + r(), -1 + r(), A + r()),
  };
  float r() {
    return random(.02, .02);
  }

  Tet() {
    gx = random(TWO_PI);
    gy = random(TWO_PI);
    gz = random(TWO_PI);
    gdx = random(-MAX_ROT, MAX_ROT);
    gdy = random(-MAX_ROT, MAX_ROT);
    gdz = random(-MAX_ROT, MAX_ROT);
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    dx = random(-MAX_ROT, MAX_ROT);
    dy = random(-MAX_ROT, MAX_ROT);
    dz = random(-MAX_ROT, MAX_ROT);
    r = random(200, 500);  // distance from centre
    sz = random(20, 30);   // size
    c = color((int)random(64, 128), (int)random(64, 128), (int)random(64, 128));
  }
  
  void draw() {
    colorMode(RGB);
    //gx += gdx;
    //gy += gdy;
    gz += gdz;
    rx += dx;
    ry += dy;
    rz += dz;
    pushMatrix();
    rotateX(gx);
    rotateY(gy);
    rotateZ(gz);
    translate(r, 0, 0);
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    stroke(c);
    drawTet(sz);
    popMatrix();
  }
  
  void drawTet(float sz) {
    beginShape(LINES);
    vertex(sz * points[0].x, sz * points[0].y, sz * points[0].z);
    vertex(sz * points[1].x, sz * points[1].y, sz * points[1].z);

    vertex(sz * points[0].x, sz * points[0].y, sz * points[0].z);
    vertex(sz * points[2].x, sz * points[2].y, sz * points[2].z);

    vertex(sz * points[0].x, sz * points[0].y, sz * points[0].z);
    vertex(sz * points[3].x, sz * points[3].y, sz * points[3].z);

    vertex(sz * points[1].x, sz * points[1].y, sz * points[1].z);
    vertex(sz * points[2].x, sz * points[2].y, sz * points[2].z);

    vertex(sz * points[1].x, sz * points[1].y, sz * points[1].z);
    vertex(sz * points[3].x, sz * points[3].y, sz * points[3].z);

    vertex(sz * points[2].x, sz * points[2].y, sz * points[2].z);
    vertex(sz * points[3].x, sz * points[3].y, sz * points[3].z);
    endShape();
  }
}