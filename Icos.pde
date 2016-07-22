class Icos {
  final float ICOS_SZ = 75;
  final float PHI = ICOS_SZ * ((1 + sqrt(5)) / 2);
  final float MAX_SPEED = .02;

  float rx, ry, rz;
  float dx, dy, dz;

  Icos() {
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    dx = random(-MAX_SPEED, MAX_SPEED);
    dy = random(-MAX_SPEED, MAX_SPEED);
    dz = random(-MAX_SPEED, MAX_SPEED);
    centres = new PVector[faces.length];
    for (int i = 0 ; i < faces.length ; i++) {
      // centres is the average of the points
      centres[i] = points[(int)faces[i].x].copy();
      centres[i].add(points[(int)faces[i].y]);
      centres[i].add(points[(int)faces[i].z]);
      centres[i].div(6);
    }
  }

  //static final
  PVector[] points = {
    new PVector(0, ICOS_SZ, PHI),    // 0
    new PVector(0, ICOS_SZ, -PHI),   // 1
    new PVector(0, -ICOS_SZ, PHI),   // 2
    new PVector(0, -ICOS_SZ, -PHI),  // 3
    new PVector(PHI, 0, ICOS_SZ),    // 4
    new PVector(-PHI, 0, ICOS_SZ),   // 5
    new PVector(PHI, 0, -ICOS_SZ),   // 6
    new PVector(-PHI, 0, -ICOS_SZ),  // 7
    new PVector(ICOS_SZ, PHI, 0),    // 8
    new PVector(ICOS_SZ, -PHI, 0),   // 9
    new PVector(-ICOS_SZ, PHI, 0),   // 10
    new PVector(-ICOS_SZ, -PHI, 0)   // 11
  };

  // faces are triples so use a pvector
  // TODO winding
  PVector[] faces = {
    new PVector(0, 2, 5),
    new PVector(0, 2, 4),
    new PVector(3, 1, 6),
    new PVector(1, 3, 7),
    new PVector(1, 6, 8),
    new PVector(4, 6, 8),
    new PVector(4, 0, 8),
    new PVector(3, 6, 9),
    new PVector(9, 4, 6),
    new PVector(9, 4, 2),
    new PVector(1, 7, 10),
    new PVector(1, 8, 10),
    new PVector(0, 8, 10),
    new PVector(0, 10, 5),
    new PVector(10, 7, 5),
    new PVector(11, 7, 5),
    new PVector(11, 5, 2),
    new PVector(11, 2, 9),
    new PVector(11, 9, 3),
    new PVector(11, 3, 7),
  };

  PVector[] centres;
  PShape s;

  void draw(float[] data) {
    rx += dx;
    ry += dy;
    rz += dz;
    pushMatrix();
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    if (s == null) {
      s = createShape();
      s.beginShape(TRIANGLES);
      s.noStroke();
      
      for (int i = 0 ; i < faces.length ; i++) {
        PVector tmp = centres[i];
        triangle(s, points[(int)faces[i].x], points[(int)faces[i].y], tmp);
        triangle(s, points[(int)faces[i].y], points[(int)faces[i].z], tmp);
        triangle(s, points[(int)faces[i].z], points[(int)faces[i].x], tmp);
      }
      s.endShape();
    }
    // modify the points (2, 5, 8 are first point, 11, 14, 17 are the second...)
    colorMode(HSB, 500, 100, 100);
    for (int i = 0 ; i < centres.length ; i++) {
      s.setFill(color(frameCount % 500, 60, 60));
      float v = constrain(sqrt(data[i]), 0, 10);
      //println("V: " + v);
      PVector t = PVector.mult(centres[i], v);
      s.setVertex(i * 9 + 2, t);
      s.setVertex(i * 9 + 5, t);
      s.setVertex(i * 9 + 8, t);
    }
    shape(s);
    colorMode(RGB);
    for (int i = 0 ; i < 0 ; i++) {  // disabled
      strokeWeight(10);
      point(points[i]);
    }
    popMatrix();
  }
}