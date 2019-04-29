
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

    void trans(float d, float t, float s, float ts) {
		trans[i0] = new AffTrans(d, t, s, ts);
		i0++;
    }

    void render(float radius, float scale, int depth) {
		renderer.draw(depth, radius);
		if( depth > 0 ) {
	    	for( int i = 0; i < n; i++ ) {
				pushMatrix();
				trans[i].apply(radius, scale);
				this.render(radius * trans[i].scale, scale * trans[i].thscale, depth - 1);
				popMatrix();
	    	}
		} else {
	    	renderer.draw(depth, radius);
		}
    }

}
