static float bpm = 88.5;
static float mspb = 1;
static float framesPerBeat = 1;
static float cos60 = cos(PI/3);
static float sin60 = sin(PI/3);

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim mim;
AudioPlayer song;
ddf.minim.analysis.FFT fft;
static int binCount = 144;
float[] av = new float[binCount];
float max;
float avg;

ArrayList<Event> events = new ArrayList<Event>();
ArrayList<Mob> mobs = new ArrayList<Mob>();
Camera cam;

ArrayList<Flower> flowers = new ArrayList<Flower>();
ArrayList<Ring> rings = new ArrayList<Ring>();
ArrayList<Triangle> tris = new ArrayList<Triangle>();
ArrayList<Grass> grass = new ArrayList<Grass>();

Flower flowerM;
Flower flowerR;
Flower flowerL;
Field field;
ArrayList<Triangle> trisM = new ArrayList<Triangle>();
ArrayList<Triangle> trisR = new ArrayList<Triangle>();
ArrayList<Triangle> trisL = new ArrayList<Triangle>();


// GLOBAL ANIMATION VARIABLES -------------------
AColor mobStroke = new AColor(255,255,255,255,0.5,10);
AColor mobFill = new AColor(255,255,255,255,0.5,10);

static int de; //width of screen de*2
static int aw; //Animation depth
static PVector front;
static PVector back;
static float defaultMass = 10;
static float defaultVMult = 0.25;


BeatTimer timer;
int currTime;
int currBeat;

// ---------------------------------------------


void setup() {
  frameRate(60);
  //fullScreen(P3D);
  size(1000,1000,P3D);

  de = (int)(min(width,height)*1);
  aw = (int)(4*de);
  front = new PVector(-de*2,de*1.2,de*0.4);
  back = new PVector(de*2,-de,-aw);

  cam = new Camera(de/2, de*0.2, -de);
  cam.ang.P.set(0.3,0,0);

  textSize(de/10);

  rectMode(CENTER);
  textAlign(CENTER);

  mim = new Minim(this);
  song = mim.loadFile("sadmachine.mp3", 1024);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  addEvents();

  song.loop();

  timer = new BeatTimer(50,600,bpm);

  mobs.add(new Flower(new PVector(0,-de*0.7,-aw), new PVector(0,0,0), de*0.65,6));
  mobs.add(new Flower(new PVector(-de*0.6,-de*0.4,0), new PVector(-PI/2,0,0), de*0.3,5));
  mobs.add(new Flower(new PVector(de*0.6,-de*0.4,0), new PVector(-PI/2,0,0), de*0.3,5));
  flowerM = (Flower) mobs.get(0);
  flowerR = (Flower) mobs.get(1);
  flowerL = (Flower) mobs.get(2);
  for (Ring ring : flowerM.rings) {
	  for (Triangle tri : ring.tris) {
	    trisM.add(tri);
	  }
	}
	for (Ring ring : flowerR.rings) {
	  for (Triangle tri : ring.tris) {
	    trisR.add(tri);
	  }
	}
	for (Ring ring : flowerL.rings) {
	  for (Triangle tri : ring.tris) {
	    trisL.add(tri);
	  }
	}

  for (int i = 0 ; i < mobs.size() ; i ++) {
    Flower flower = (Flower) mobs.get(i);
    flowers.add(flower);
    for (Ring ring : flower.rings) {
      rings.add(ring);
      for (Triangle tri : ring.tris) {
        tris.add(tri);
      }
    }
  }

  int row = 20;
  for (int i = 0 ; i < row ; i ++) {
    for (int k = 0 ; k < row ; k++) {
      mobs.add(new Grass(new PVector(front.x - (float)i/row*(float)(front.x - back.x), 
      	front.y, front.z - (float)k/row*(float)(front.z - back.z)), de*0.2,de*0.1));
      grass.add((Grass) mobs.get(mobs.size() -1));
    }
  }
  mobs.add(new Field(grass));
  field = (Field) mobs.get(mobs.size() - 1);
}

void draw() {
  update();

  cam.render();

  background(0);

  // drawBorders();
  // drawWidthBox(de);
  // drawPitches();
  // push();
  // translate(0,0,0);
  // text(currBeat,0,0);
  // pop();

  for (Mob mob : mobs) {
    if (mob.draw) mob.render();
  }
}

void update() {
  calcFFT();

  currTime = song.position();
  if (timer.beat) currBeat ++;

  cam.update();
  // cam.ang.P.y = -(float)mouseX/width*2*PI;
  // cam.ang.P.x = -(float)mouseY/height*2*PI;
  mobFill.update();
  mobStroke.update();
  timer.update();

  updateEvents();
  updateMobs();
}

void updateEvents() {
  for (int i = 0 ; i < events.size() ; i ++) {
    Event event = events.get(i);
    if (currBeat >= event.time && currBeat < event.timeEnd) {
      if (!event.spawned) {
        event.spawned = true;
        event.spawn();
      }
      event.update();
    }
  }
}

void updateMobs() {
  for (Mob mob : mobs) {
    mob.update();
  }

  for (int i = 0 ; i < mobs.size() ; i ++) {
    if (mobs.get(i).finished) mobs.remove(i);
  }
}