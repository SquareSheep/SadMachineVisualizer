abstract class Mob {
	boolean finished = false;
	Point p;
	SpringValue sca = new SpringValue(1);
	Point ang = new Point();
	
	abstract void update();

	abstract void render();
}

class Grass extends Mob {
	Point w;
	AColor fillStyle = new AColor(0,0,0,0);
	AColor strokeStyle = new AColor(0,0,0,0);

	Grass(PVector p, float w, float h) {
		this.p = new Point(p);
		this.ang = new Point();
		this.w = new Point(w, h, w);
	}

	void update() {
		p.update();
		ang.update();
		w.update();
		sca.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		triangle(-w.p.x/2,0, w.p.x/2,0, 0,-w.p.y);
		rotateY(PI/2);
		triangle(-w.p.z/2,0, w.p.z/2,0, 0,-w.p.y);
		pop();
	}
}

class Flower extends Mob {

	float w;
	ArrayList<Ring> rings = new ArrayList<Ring>();

	Flower(PVector p, PVector ang, float w, int nofRings) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w;
		int sum1 = 1;
		int sum2 = 2;
		int temp;
		for (int i = 1 ; i <= nofRings ; i ++) {
			temp = sum2;
			sum2 += sum1;
			sum1 = temp;
			rings.add(new Ring(new PVector(0,0,(0.7-(float)i/nofRings)*w*0.5), new PVector(0,0,i*i*0.05), 
			w/nofRings*i, sum2, new PVector(PI*0.5-(float)i/nofRings*PI*0.4,0.4-(float)i/nofRings*0.15,0.1)));
		}
	}

	void update() {
		p.update();
		sca.update();
		ang.update();
		for (Ring ring : rings) {
			ring.update();
		}
	}

	void render() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		for (Ring ring : rings) {
			ring.render();
		}
		pop();
	}
}

class Ring extends Mob {
	float w;
	ArrayList<Triangle> tris = new ArrayList<Triangle>();

	Ring(PVector p, PVector ang, float w, int num, PVector angTilt) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w;
		for (int i = 0 ; i < num ; i ++) {
			tris.add(new Triangle(new PVector(0,w,0),angTilt.copy(),de*0.05+w/3));
		}
	}

	void update() {
		p.update();
		ang.update();
		sca.update();
		for (Triangle tri : tris) {
			tri.update();
		}
	}

	void render() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		float angle = 2*PI/tris.size();
		for (int i = 0 ; i < tris.size() ; i ++) {
			rotateZ(angle);
			tris.get(i).render();
		}
		pop();
	}
}

class Triangle extends Mob {
	
	float w;
	float h;
	AColor fillStyle = new AColor(0,0,0,0);
	AColor strokeStyle = new AColor(0,0,0,0);
	boolean draw = true;

	Triangle(PVector p, PVector ang, float w) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w;
		this.h = w/10;
	}

	void update() {
		p.update();
		sca.update();
		ang.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void render() {
		if (draw) {
			push();
			fillStyle.fillStyle();
			strokeStyle.strokeStyle();
			translate(p.p.x, p.p.y, p.p.z);
			rotateX(ang.p.x);
			rotateY(ang.p.y);
			rotateZ(ang.p.z-PI/2);
			beginShape();
			vertex(-w, 0, 0);
			vertex(cos60*w, sin60*w, 0);
			vertex(cos60*w, -sin60*w, 0);
			vertex(-w, 0, 0);
			endShape();
			// beginShape();
			// vertex(w, 0, -h);
			// vertex(-cos60*w, sin60*w, -h);
			// vertex(-cos60*w, -sin60*w, -h);
			// vertex(w, 0, -h);
			// endShape();
			rotateX(PI/2);
			pop();
		}
	}
}