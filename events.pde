class Event {
	boolean finished = false;
	boolean spawned = false;
	int time;
	int timeEnd;

	Event(int time, int timeEnd) {
		this.time = time;
		this.timeEnd = timeEnd;
	}

	void update() {

	}

	void spawn() {

	}
}

class Alone extends Event {
	Alone(int time, int timeEnd) {
		super(time, timeEnd);
	}

	void spawn() {
		field.v.P.mult(2);
	}

	void update() {

	}

}

class Although2 extends Event {

	Although2(int time, int timeEnd) {
		super(time, timeEnd);
	}

	void spawn() {
		flowerR.draw = true;
		flowerL.draw = true;
		flowerM.draw = false;
		for (Triangle tri : trisR) {
			tri.fillStyle.setMass(2);
			tri.fillStyle.setX(0,0,0,255);
			tri.strokeStyle.setX(0,0,0,255);
		}
		for (Triangle tri : trisL) {
			tri.fillStyle.setMass(2);
			tri.fillStyle.setX(0,0,0,255);
			tri.strokeStyle.setX(0,0,0,255);
		}
	}

	void update() {
		for (int i = 0 ; i < flowerR.rings.size() ; i ++) {
			Ring ring = flowerR.rings.get(i);
			Ring ring2 = flowerL.rings.get(i);
			if (i % 2 == 0) {
				ring.ang.P.z += 0.01;
				ring2.ang.P.z -= 0.01;
			} else {
				ring.ang.P.z -= 0.01;
				ring2.ang.P.z += 0.01;
			}
		}
		int k;
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.r.X = av[k]*15;
			gr.fillStyle.g.X = av[k]*5;
			gr.fillStyle.b.X = av[k]*5;
			gr.w.v.y += av[k]*1.5;
	  	}
		for (int i = 0 ; i < trisR.size() ; i ++) {
			Triangle tri = trisR.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.fillStyle.r.X = av[k]*5;
			tri.fillStyle.g.X = av[k]*3;
			tri.fillStyle.b.X = av[k]*15;
		}
		for (int i = 0 ; i < trisL.size() ; i ++) {
			Triangle tri = trisL.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.fillStyle.b.X = av[k]*5;
			tri.fillStyle.r.X = av[k]*3;
			tri.fillStyle.g.X = av[k]*15;
		}
	}
}

class Although extends Event {

	Although(int time, int timeEnd) {
		super(time, timeEnd);
	}

	void spawn() {
		flowerR.draw = true;
		flowerM.draw = false;
		for (Triangle tri : trisR) {
			tri.fillStyle.setMass(2);
			tri.fillStyle.setX(0,0,0,255);
			tri.strokeStyle.setX(0,0,0,255);
		}
		for (Triangle tri : trisL) {
			tri.fillStyle.setMass(2);
			tri.fillStyle.setX(0,0,0,255);
			tri.strokeStyle.setX(0,0,0,255);
		}
		field.v.P.set(0,0,de*0.01);
	}

	void update() {
		for (int i = 0 ; i < flowerR.rings.size() ; i ++) {
			Ring ring = flowerR.rings.get(i);
			if (i % 2 == 0) {
				ring.ang.P.z += 0.01;
			} else {
				ring.ang.P.z -= 0.01;
			}
		}
		int k;
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.r.X = av[k]*15;
			gr.fillStyle.g.X = av[k]*5;
			gr.fillStyle.b.X = av[k]*5;
			gr.w.v.y += av[k]*1.5;
	  	}
		for (int i = 0 ; i < trisR.size() ; i ++) {
			Triangle tri = trisR.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.fillStyle.r.X = av[k]*5;
			tri.fillStyle.g.X = av[k]*3;
			tri.fillStyle.b.X = av[k]*15;
		}
	}
}

class Survived extends Event {

	Survived(int time, int timeEnd) {
		super(time, timeEnd);
	}

	void spawn() {
		field.v.P.set(de*0.003,0,0);
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
			tri.fillStyle.setX(0,0,0,0);
		}
	}

	void update() {
		int k;
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = i%binCount;
			gr.fillStyle.b.X = av[k]*5;
			gr.fillStyle.r.X = av[k]*3;
			gr.fillStyle.g.X = av[k]*15;
			gr.w.v.y += av[k]*1.5;
	  	}
	}
}
class Drop1 extends Event {

	Drop1(int time, int timeEnd) {
		super(time, timeEnd);
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
		flowerM.p.P.set(0,0,-de*0.7);
		for (Triangle tri : trisM) {
			tri.fillStyle.setMass(2);
		}
		field.v.P.z = de*0.03;
	}

	void update() {
		flowerM.p.P.z += de*0.0005;
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

class Main1 extends Event {

	Main1(int time, int timeEnd) {
		super(time, timeEnd);
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

class Intro extends Event {

	Intro(int time, int timeEnd) {
		super(time, timeEnd);
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

class Anyone extends Event {

	Anyone(int time, int timeEnd) {
		super(time, timeEnd);
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