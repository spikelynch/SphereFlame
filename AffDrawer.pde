

class AffDrawer {

    int w;
    Colours col; 
    int radius;
    int style;

    AffDrawer(int w0, int r0, Colours c0) {
		w = w0;
		col = c0;
		radius = r0;
    }

    void draw(int depth, float size) {
	 	dot(depth, size);
    }

    void dot(int depth, float size) {
		pushMatrix();
		translate(0, 0, radius);
		strokeWeight(w);
		stroke(col.nextlerp());
		stroke(col.lerp(depth));
	//println("depth" + depth);
		point(0, 0, 0);
		popMatrix();
    }

    void ball(int depth, float size) {
		pushMatrix();
		translate(0, 0, radius);
		strokeWeight(3);
		fill(col.nextlerp());
		sphere(w);
		popMatrix();
    }
    


}
