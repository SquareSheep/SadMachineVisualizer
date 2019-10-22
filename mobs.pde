abstract class Mob {
	boolean finished = false;
	boolean draw = true;
	Point p;
	SpringValue sca = new SpringValue(1);
	Point ang = new Point();
	
	void updatePoints() {
		p.update();
		ang.update();
		sca.update();
	}

	void setDraw() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
	}

	abstract void update();

	abstract void render();
}

abstract class MobF extends Mob {
	AColor fillStyle = new AColor(0,0,0,0);
	AColor strokeStyle = new AColor(0,0,0,0);

	void updatePoints() {
		p.update();
		ang.update();
		sca.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void setDraw() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
	}
}

class TextBox extends MobF {
	String string = "";

	TextBox() {
	}

	void update() {
		updatePoints();
	}

	void render() {
		setDraw();
		text(string, 0,0);
		pop();
	}
}

class StarField extends Mob {
	ArrayList<Star> stars;
	Point v = new Point();
	StarField(ArrayList<Star> stars) {
		this.stars = stars;
	}

	void update() {
		v.update();
		for (Star gr : stars) {
			gr.p.P.add(v.p);
			if (gr.p.p.x > back.x) {
				gr.p.p.x = front.x;
				gr.p.P.x = front.x;
			} else if (gr.p.p.x < front.x) {
				gr.p.p.x = back.x;
				gr.p.P.x = back.x;
			} else if (gr.p.p.y < back.y) {
				gr.p.p.y = front.y;
				gr.p.P.y = front.y;
			} else if (gr.p.p.y > front.y) {
				gr.p.p.y = back.y;
				gr.p.P.y = back.y;
			} else if (gr.p.p.z < back.z) {
				gr.p.p.z = front.z;
				gr.p.P.z = front.z;
			} else if (gr.p.p.z > front.z) {
				gr.p.p.z = back.z;
				gr.p.P.z = back.z;
			}
		}
	}

	void render() {
		for (Star gr : stars) {
			gr.render();
		}
	}
}

class Field extends Mob {
	ArrayList<Grass> grass;
	Point v = new Point();
	Field(ArrayList<Grass> grass) {
		this.grass = grass;
	}

	void update() {
		v.update();
		for (Grass gr : grass) {
			gr.p.P.add(v.p);
			if (gr.p.p.x > back.x) {
				gr.p.p.x = front.x;
				gr.p.P.x = front.x;
			} else if (gr.p.p.x < front.x) {
				gr.p.p.x = back.x;
				gr.p.P.x = back.x;
			} else if (gr.p.p.z < back.z) {
				gr.p.p.z = front.z;
				gr.p.P.z = front.z;
			} else if (gr.p.p.z > front.z) {
				gr.p.p.z = back.z;
				gr.p.P.z = back.z;
			}
		}
	}

	void render() {
		for (Grass gr : grass) {
			gr.render();
		}
	}
}

class Grass extends MobF {
	Point w;

	Grass(PVector p, float w, float h) {
		this.p = new Point(p);
		this.ang = new Point();
		this.w = new Point(w, h, w);
	}

	void update() {
		updatePoints();
	}

	void render() {
		setDraw();
		quad(-w.p.x/2,0, 0,w.p.y, w.p.x/2,0, 0,-w.p.y);
		rotateY(PI/2);
		quad(-w.p.z/2,0, 0,w.p.y, w.p.z/2,0, 0,-w.p.y);
		pop();
	}
}

class Star extends MobF {

	SpringValue r = new SpringValue(0.25);
	Point w;

	Star(PVector p, float w, float h) {
		this.p = new Point(p);
		this.ang = new Point();
		this.w = new Point(w, h, w);
	}

	void update() {
		updatePoints();
		r.update();
	}

	void render() {
		setDraw();
		beginShape();
		vertex(0,-w.p.y);
		vertex(-w.p.x*r.x, -w.p.y*r.x);
		vertex(-w.p.x,0);
		vertex(-w.p.x*r.x, w.p.y*r.x);
		vertex(0,w.p.y);
		vertex(w.p.x*r.x, w.p.y*r.x);
		vertex(w.p.x,0);
		vertex(w.p.x*r.x, -w.p.y*r.x);
		vertex(0,-w.p.y);
		endShape();
		rotateY(PI/2);
		beginShape();
		vertex(0,-w.p.y);
		vertex(-w.p.z*r.x, -w.p.y*r.x);
		vertex(-w.p.z,0);
		vertex(-w.p.z*r.x, w.p.y*r.x);
		vertex(0,w.p.y);
		vertex(w.p.z*r.x, w.p.y*r.x);
		vertex(w.p.z,0);
		vertex(w.p.z*r.x, -w.p.y*r.x);
		vertex(0,-w.p.y);
		endShape();
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
		updatePoints();
		for (Ring ring : rings) {
			ring.update();
		}
	}

	void render() {
		setDraw();
		for (Ring ring : rings) {
			ring.render();
		}
		pop();
	}

	void setFillX(float r, float g, float b, float a) {
		for (Ring ring : rings) {
			for (Triangle tri : ring.tris) {
				tri.fillStyle.setX(r, g, b, a);
			}
		}
	}

	void setStrokeX(float r, float g, float b, float a) {
		for (Ring ring : rings) {
			for (Triangle tri : ring.tris) {
				tri.strokeStyle.setX(r, g, b, a);
			}
		}
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
		updatePoints();
		for (Triangle tri : tris) {
			tri.update();
		}
	}

	void render() {
		setDraw();
		float angle = 2*PI/tris.size();
		for (int i = 0 ; i < tris.size() ; i ++) {
			rotateZ(angle);
			tris.get(i).render();
		}
		pop();
	}
}

class Triangle extends MobF {
	
	float w;
	float h;

	Triangle(PVector p, PVector ang, float w) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w;
		this.h = w/10;
	}

	void update() {
		updatePoints();
	}

	void render() {
		if (draw) {
			setDraw();
			beginShape();
			vertex(-w, 0, 0);
			vertex(cos60*w, sin60*w, 0);
			vertex(cos60*w, -sin60*w, 0);
			vertex(-w, 0, 0);
			endShape();
			rotateX(PI/2);
			pop();
		}
	}
}