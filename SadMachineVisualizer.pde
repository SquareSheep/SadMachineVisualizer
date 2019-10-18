static float bpm = 89.5;
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
ArrayList<Triangle> trisM = new ArrayList<Triangle>();
ArrayList<Triangle> trisR = new ArrayList<Triangle>();
ArrayList<Triangle> trisL = new ArrayList<Triangle>();


// GLOBAL ANIMATION VARIABLES -------------------
AColor mobStroke = new AColor(255,255,255,255,0.5,10);
AColor mobFill = new AColor(255,255,255,255,0.5,10);

static int de; //width of screen de*2
static int aw; //Animation depth
static int gridW;
static int gridX;
static int gridY;
static int gridZ;
static float defaultMass = 10;
static float defaultVMult = 0.25;


BeatTimer timer;
int currTime;
int offset;

// ---------------------------------------------


void setup() {
  frameRate(60);
  //fullScreen(P3D);
  size(600,600,P3D);

  de = (int)(min(width,height)*1);
  aw = (int)(2*de);
  gridW = 2*de/10;
  gridX = 2*de/gridW;
  gridY = 2*de/gridW;
  gridZ = 2*aw/gridW;

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

  offset = millis();
  timer = new BeatTimer(50,-offset,bpm);

  mobs.add(new Flower(new PVector(0,-de*0.7,-aw), new PVector(0,0,0), de*0.65,6));
  mobs.add(new Flower(new PVector(-de*0.6,0,0), new PVector(0,1,0), de*0.3,5));
  mobs.add(new Flower(new PVector(de*0.6,0,0), new PVector(0,-1,0), de*0.3,5));
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

  float wX = de*8;
  float wZ = de*7;
  float X = 0;
  float Z = -aw*1.5;
  int row = (int)20;
  for (int i = 0 ; i < row ; i ++) {
    for (int k = 0 ; k < row ; k++) {
      mobs.add(new Grass(new PVector(X + wX * ((float)i/row - 0.5),de*1.2,Z + wZ * ((float)k/row - 0.5)), de*0.2,de*0.1));
      //mobs.add(new Grass(new PVector(random(-1,1)*de, random(-1,1)*de, random(-1,1)*aw), de*0.2,de*0.1));
      grass.add((Grass) mobs.get(mobs.size() -1));
    }
  }
}

void draw() {
  update();

  cam.render();

  background(0);

  // drawBorders();
  // drawWidthBox(de);
  // drawPitches();

  for (Mob mob : mobs) {
    if (mob.draw) mob.render();
  }

  for (Event event : events) {
  	event.render();
  }
}

void update() {
  calcFFT();

  currTime = song.position();

  cam.update();
  //cam.ang.P.y = -(float)mouseX/width*2*PI;
  //cam.ang.P.x = -(float)mouseY/height*2*PI;
  mobFill.update();
  mobStroke.update();
  timer.update();

  updateEvents();
  updateMobs();
}

void updateEvents() {
  for (int i = 0 ; i < events.size() ; i ++) {
    Event event = events.get(i);
    if (currTime > event.time && currTime < event.timeEnd) {
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