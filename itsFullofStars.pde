  ArrayList<PShape> rings = new ArrayList<PShape>();
ArrayList<PShape> stars = new ArrayList<PShape>();
float count=0;
PShape hole;

void setup(){
  size(600, 600, P3D);
  blendMode(ADD);
  
  //FLOATING STARS
  for(int starNum = 0 ; starNum < 3000 ; starNum++){
    PShape star = createShape();
    star.setStrokeWeight(random(2f,5f));
    star.beginShape(POINTS);
    star.stroke(255);
    float w=500;
    float xpos = random(-w,w);
    float ypos = random(-w,w);
    float zpos = random(-w,w);
    star.vertex(xpos,ypos,zpos);
    star.endShape();
    stars.add(star);
  }
  
  //ROTATING STARS
  float innerRad = 100f, outerRad = 109f, increment = 1f;
  for(int ringIndex = 0 ; ringIndex < 50 ; ringIndex++){
    PShape ring = createShape();
    float stroke = map(ringIndex,0,50,5f,2f);
    ring.setStrokeWeight(stroke);
    ring.beginShape(POINTS);
    //ring.stroke(0,0,0,ringIndex*5);
    for(int starIndex = 0 ; starIndex < 80 ; starIndex++){
      float a = random(0f, 1f) * TWO_PI;
      float r = sqrt(random(sq(innerRad), sq(outerRad)));
      ring.vertex(r*cos(a),random(-50,50),r*sin(a));
    }
    ring.endShape();
    rings.add(ring);
    innerRad += increment;
    outerRad += increment*1.5f;
    increment += .2;
  }
  
  //Black Hole
  hole = createShape(SPHERE,80);
  color c = color(0,0,0,255);
  //color c = color(255);
  hole.setFill(c);
  //hole.setStroke(color(255));
  //hole.setStrokeWeight(1);
  hole.endShape();

}

void draw(){ 
  background(0);  
  count+=.001;
  float r = width/2;
  camera(r*cos(count),-height/3,r*sin(count), 0f, 0f, 0f, 0f, 1f, 0f);
  
  shape(hole);
  
  for(int index = 0 ; index < 50 ; index++){
    pushMatrix();
    rotateY((TWO_PI/((index))*frameCount/800));
    shape(rings.get(index));
    popMatrix();
  }
  
  for(int index = 0 ; index < 2000 ; index++){
    shape(stars.get(index));
  }
    
  saveFrame();  
    
}
