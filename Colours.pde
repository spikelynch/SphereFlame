class Colours {
    color c1;
    color c2;
    int n;
    int i = 0;

    Colours(int n0, color c10, color c20) {
		c1 = c10;
		c2 = c20;
		n = n0;
    }

    color lerp(int k) {
		if( k > n ) {
	    	k = n;
		}
		float kk = (float)k / (float)n;
		return lerpColor(c1, c2, kk);
    }

    color nextlerp() {
		color ncol = lerp(i);
		i++;
		if( i > n ) {
	    	i = 0;
		}
		return ncol;
    }
}
