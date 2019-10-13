abstract class Mob {
	boolean finished = false;
	Point p;
	SpringValue sca = new SpringValue(1);
	Point ang = new Point();
	
	abstract void update();

	abstract void render();
}

class Grass extends Mob {
	float w;
	int index;
	AColor fillStyle = new AColor(100,255,100,200);
	AColor strokeStyle = new AColor(255,255,255,255);

	Grass(PVector p, float w) {
		this.p = new Point(p);
		this.ang = new Point();
		this.w = w;
	}

	void update() {
		p.update();
		ang.update();
		scale.update();
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
		triangle(-w/2,0, w/2,0, 0,w);
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
			rings.add(new Ring(new PVector(0,0,-(float)i/nofRings*w/5), new PVector(0,0,0), w/nofRings*i, sum2, new PVector(PI*0.5-(float)i/nofRings*PI*0.4,0.3,0.1)));
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
		rect(0,0,25,25);
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
			tris.add(new Triangle(new PVector(0,w,0),angTilt,de*0.05+w/3));
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
		for (int i = 0 ; i < tris.size() ; i ++) {
			rotateZ((float)2*PI/tris.size());
			tris.get(i).render();
		}
		pop();
	}
}

class Triangle extends Mob {
	
	float w;
	float h;
	AColor fillStyle = new AColor(100,100,100,0);
	AColor strokeStyle = new AColor(255,255,255,255);

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
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z+PI/2);
		beginShape();
		vertex(w, 0, h);
		vertex(-cos60*w, sin60*w, h);
		vertex(-cos60*w, -sin60*w, h);
		vertex(w, 0, h);
		endShape();
		beginShape();
		vertex(w, 0, -h);
		vertex(-cos60*w, sin60*w, -h);
		vertex(-cos60*w, -sin60*w, -h);
		vertex(w, 0, -h);
		endShape();
		rotateX(PI/2);
		pop();
	}
}