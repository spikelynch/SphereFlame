
class Afflower {

    AffTrans[] trans;
    AffDrawer renderer;
    int n;
    int i0 = 0;

    Afflower(int n0, AffDrawer r) {
		n = n0;
		trans = new AffTrans[n];
		renderer = r;
    }

    void trans(float d, float t, float s) {
		trans[i0] = new AffTrans(d, t, s);
		i0++;
    }

    void render(float radius, int depth) {
		renderer.draw(depth, radius);
		if( depth > 0 ) {
	    	for( int i = 0; i < n; i++ ) {
				pushMatrix();
				trans[i].apply(radius);
				this.render(radius * trans[i].scale, depth - 1);
				popMatrix();
	    	}
		} else {
	    	renderer.draw(depth, radius);
		}
    }

}
