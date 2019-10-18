class Event {
	boolean finished = false;
	boolean spawned = false;
	int time;
	int timeEnd;

	void update() {

	}

	void render() {
		
	}

	void spawn() {

	}
}
// 3700, 14600, 25500, 47200, 57600
class Although682 {
	Although682() {
		time = 68200;
		timeEnd = 100000;
	}

	void spawn() {
		for (Grass gr : grass) {
			gr.fillStyle.setx(255,255,255,255);
			gr.fillStyle.setx(0,0,0,255);
			gr.fillStyle.setMass(5);
		}
		for (Triangle tri : trisR) {
			tri.fillStyle.setMass(15);
			tri.fillStyle.setX(0,0,0,255);
		}
		for (Triangle tri : trisL) {
			tri.fillStyle.setMass(15);
			tri.fillStyle.setX(0,0,0,255);
		}
	}

	void update() {
		int k;
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.r.X = av[k]*15;
			gr.fillStyle.g.X = av[k]*3;
			gr.fillStyle.b.X = av[k]*15;
			gr.w.v.y += av[k]*1.5;
	  	}
	}
}

class Survived472s682 extends Event {
	Survived472s682() {
		time = 47200;
		timeEnd = 68200;
	}

	void spawn() {
		for (Grass gr : grass) {
			gr.fillStyle.setx(255,255,255,255);
			gr.fillStyle.setx(0,0,0,255);
			gr.fillStyle.setMass(5);
		}
		flowerM.ang.P.set(-0.2,0,0);
		flowerM.sca.X = 1;
		flowerM.sca.mass = 10;
		for (Triangle tri : trisM) {
			tri.fillStyle.setMass(15);
			tri.fillStyle.setX(0,0,0,255);
		}
	}

	void update() {
		int k;
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.r.X = av[k]*15;
			gr.fillStyle.g.X = av[k]*3;
			gr.fillStyle.b.X = av[k]*15;
			gr.w.v.y += av[k]*1.5;
	  	}
	}
}
class Drop255s472 extends Event {
	Drop255s472() {
		time = 25500;
		timeEnd = 47200;
	}

	void spawn() {
		for (Grass gr : grass) {
			gr.w.mass = 5;
			gr.fillStyle.setx(255,255,255,255);
			gr.fillStyle.setMass(2);
		}
		flowerM.ang.P.set(0,0,0);
		flowerM.sca.X = 1.3;
		flowerM.sca.mass = 2;
		flowerM.p.P.set(0,0,-de*0.3);
		for (Triangle tri : trisM) {
			tri.fillStyle.setMass(2);
		}
	}

	void update() {
		for (int i = 0 ; i < flowerM.rings.size() ; i ++) {
			Ring ring = flowerM.rings.get(i);
			if (i % 2 == 0) {
				ring.ang.P.z += 0.01;
			} else {
				ring.ang.P.z -= 0.01;
			}
		}
		int k;
		for (int i = 0 ; i < trisM.size() ; i ++) {
			Triangle tri = trisM.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.fillStyle.r.X = av[k]*5;
			tri.fillStyle.g.X = av[k]*3;
			tri.fillStyle.b.X = av[k]*15;
		}
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.r.X = av[k]*5;
			gr.fillStyle.g.X = av[k]*3;
			gr.fillStyle.b.X = av[k]*15;
			gr.w.v.y += av[k]*1.5;
	  	}
	}
}

class Build146s255 extends Event {
	Build146s255() {
		time = 14600;
		timeEnd = 25500;
	}

	void spawn() {
		for (Grass gr : grass) {
			gr.draw = true;
			gr.fillStyle.setx(0,0,0,0);
		}
	}

	void update() {
		flowerM.p.P.y -= width*0.001;
		flowerM.ang.P.x -= 0.0025;
		for (int i = 0 ; i < flowerM.rings.size() ; i ++) {
			Ring ring = flowerM.rings.get(i);
			if (i % 2 == 0) {
				ring.ang.P.z += 0.007;
			} else {
				ring.ang.P.z -= 0.007;
			}
		}
		int k;
		for (int i = 0 ; i < trisM.size() ; i ++) {
			Triangle tri = trisM.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.ang.v.x += av[k]*0.003;
			tri.fillStyle.g.X = av[k]*5 + k;
			tri.fillStyle.b.X = av[k]*5 + 255 - k;
			tri.fillStyle.r.X = av[k]*9;
		}
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.g.X = av[k]*5 + k;
			gr.fillStyle.b.X = av[k]*5 + 255 - k;
			gr.fillStyle.r.X = av[k]*9;
			gr.w.v.y += av[k]*0.5;
	  	}
	}
}

class Play37s146 extends Event {
	Play37s146() {
		time = 3700;
		timeEnd = 14600;
	}

	void spawn() {
		for (Grass gr : grass) {
			gr.draw = false;
			gr.fillStyle.setX(0,0,0,200);
		}
		flowerM.sca.X = 1;
		flowerM.sca.x = 1;
		flowerM.p.P.set(0,de,-de*0.5);
		flowerM.p.p.set(0,de,-de*0.5);
		flowerM.ang.P.set(PI/2,0,0);
		flowerM.ang.p.set(PI/2,0,0);
	}

	void update() {
		flowerM.p.P.y -= width*0.0007;
		int k;
		for (int i = 0 ; i < trisM.size() ; i ++) {
			Triangle tri = trisM.get(i);
			k = (int)((float)i/trisM.size()*binCount);
			tri.ang.v.x += av[k]*0.003;
			tri.fillStyle.g.X = av[k]*5 + k;
			tri.fillStyle.b.X = av[k]*5 + 255 - k;
			tri.fillStyle.r.X = av[k]*9;
		}
	}
}

// Is anyone there?
class Anyone0s37 extends Event {
	Anyone0s37() {
		time = 0;
		timeEnd = 3610;
	}

	void spawn() {
		flowerR.draw = false;
		flowerL.draw = false;
		for (Triangle tri : trisM) {
			tri.fillStyle.setX(0,0,0,255);
			tri.strokeStyle.setX(0,0,0,255);
		}
		for (Grass gr : grass) {
			gr.fillStyle.setX(0,0,0,200);
			gr.strokeStyle.setX(0,0,0,255);
		}
		flowerM.sca.X = 1.5;
		flowerM.sca.x = 1.5;
		flowerM.p.P.set(0,0,0);
		flowerM.p.p.set(0,0,0);
	}

	void update() {
		int k;
		for (int i = 0 ; i < tris.size() ; i ++) {
			Triangle tri = tris.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.ang.v.x += pow(av[k],1.2)*0.003;
			tri.fillStyle.g.X = pow(av[k],1.6)*10;
			tri.fillStyle.b.X = pow(av[k],1.6)*10;
			tri.fillStyle.r.X = pow(av[k],1.6)*10;
		}
	}
}

class RestartSong extends Event {
	RestartSong(int time) {
		this.time = time;
		this.timeEnd = time + 200;
	}

	void spawn() {
		println("RESTART");
		seekTo(0);
		mobs.clear();
		flowers.clear();
		rings.clear();
		tris.clear();
		grass.clear();
		for (Event event : events) {
			event.spawned = false;
			event.finished = false;
		}
	}
}