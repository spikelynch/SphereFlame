import processing.opengl.*;
import processing.video.*;

Afflower aff;
AffDrawer ad;


color fg;
color bg;

Colours cbar;

float xrot = 0.002;
float yrot = 0.002;
float l_rot = 0.02;
int tick = 0;
float astep = 2;

float MOUSE_FACTOR = 15 * PI;

float d1;
float t1;
float d2;
float t2;
float s1;
float s2;
float a1;
float a2;

int x_m[] = new int[2];
int y_m[] = new int[2];
int x_s[] = new int[2];
int y_s[] = new int[2];
boolean track_m[] = new boolean[2];

int amb_r = 64;
int amb_g = 64;
int amb_b = 64;
int dir_r = 255;
int dir_g = 255;
int dir_b = 255;
int dir_x = 0;
int dir_y = 0;
int dir_z = -5;

int W = 720;
int H = 640;
float xoff;
float yoff;
float zoff;
float radius;

int depth = 15;
int colours = 15;
int settingsn = 0;
boolean fullscreen = false;
boolean mousing = true;

void setup() {

  size(720, 640, OPENGL);

  fg = color(55,55,55, 128);
  bg = color(128, 128, 128);

  //cbar = new Colours(colours, color(255, 128, 128, 128), color(192, 255, 192, 128));
  //cbar = new Colours(colours, color(255, 255, 255, 80), color(0, 0, 0, 20));

  cbar = new Colours(colours, color(40, 40, 120, 120), color(255, 255, 255, 120));
  //recolour();

  ad = new AffDrawer(3, int(H * 0.8), cbar);
  
  aff = new Afflower(2, ad);

  aff.trans(0, 0, 0.8);
  aff.trans(0, 0, 0.8);

  x_s[0] = 0;
  x_s[1] = 0;
  y_s[0] = 0;
  y_s[1] = 0;
  
  track_m[0] = false;
  track_m[1] = false;

  xoff = W * 0.5;
  yoff = H * 0.5;
  zoff = W * 0.7;
  radius = H * 0.40;
  background(bg);
  randomise();

}

void draw() {
  lights();
  pushMatrix();
  translate(xoff, yoff, -zoff); 
  rotateX(PI * tick * xrot);
  rotateY(PI * tick * yrot);
  axes();
  aff.render(radius, depth);
  popMatrix();
  tick++;
  if( mousing ) {
      if( mousePressed ) {
	  mouse_trans(); 
      }
  } else {
      aff.trans[0].dip = t1 * tick;
      aff.trans[0].twist = d1 * tick;
      aff.trans[1].dip = d2 * tick;
      aff.trans[1].twist = t2 * tick;
  }
}


void mousePressed() {
    int w = mb_w();
    if( w > -1 ) {
	track_m[w] = true;
	x_m[w] = mouseX;
	y_m[w] = mouseY;
    }
}


void mouseReleased() {
    int w = mb_w();
    track_m[w] = false;
    x_s[w] += mouseX - x_m[w];
    y_s[w] += mouseY - y_m[w];
}


void mouse_trans() {
    int w = mb_w();
    if( w == -1 ) {
	return;
    }
    
    int x = x_s[w] + mouseX - x_m[w];
    int y = y_s[w] + mouseY - y_m[w];

    //    println(x + ", " + y + "; " + x_s[w] + ", " + y_s[w]);
    
    aff.trans[w].twist = (((float)x / (float)W) - 0.5) * 2 * MOUSE_FACTOR;
    aff.trans[w].dip = (float)y / (float)H * MOUSE_FACTOR;

}


int mb_w() {
    int w;
    if( mouseButton == LEFT  ) {
        return 0;
    } else if ( mouseButton == RIGHT ) {
	return 1;
    } else {
	return -1;
    }
}
    

void lights() {
    ambientLight(amb_r, amb_g, amb_b);

    dir_x = int(100 * cos(tick * l_rot));
    dir_z = int(100 * sin(tick * l_rot));
    dir_y = 40;

    directionalLight(dir_r, dir_g, dir_b, dir_x, dir_y, dir_z);
    background(bg);
}

void keyPressed() {
    if( key == ' ' ) {
	saveFrame("frame-####.png");
    } else if( key == 's' ) {
	saveSettings();
    } else if( key >= '0' && key <= '9' ) {
	loadSettings(key);
    } else if( key == 'a' ) {
	if( depth > 1 ) {
	    depth--;
	}
    } else if( key == 'z' ) {
	depth++;
    } else if( key == 'd' ) {
	if( colours > 2 ) {
	    colours--;
	    recolour();
	}
    } else if( key == 'c' ) {
	colours++;
	recolour();
    }

}


void axes() {
    strokeWeight(1);
    stroke(255, 255, 255, 128);
    line(0, 0, radius, 0, 0, -radius);
    line(0, radius, 0, 0, -radius, 0);
    line(radius, 0, 0, -radius, 0, 0);


}

void randomise() {

    d1 = random(-.5, .5);
    t1 = random(-.5, .5);
    d2 = random(-.5, .5);
    t2 = random(-.5, .5);
    s1 = .1;
    s2 = .1;
    a1 = PI * random(0.001, 0.01);
    a2 = PI * random(0.001, 0.01);

}


void recolour() {
  cbar = new Colours(colours, color(255, 255, 255, 40), color(0, 0, 80, 20));
  println("recolour " + colours);
}

void saveSettings() {
    String[] lines = new String[4];
    lines[0] = str(d1);
    lines[1] = str(t1);
    lines[2] = str(d2);
    lines[3] = str(t2);
    
    saveStrings("settings" + str(settingsn) + ".txt", lines);
    println("saved to " + settingsn);
    settingsn++;
    if( settingsn > 9 ) {
	settingsn = 0;
    }
}


void loadSettings(char n) {
    println("Loading " + n);
    String file = "settings" + n + ".txt";
    String lines[] = loadStrings(file);

    if( lines.length == 4 ) {
	d1 = Float.valueOf(lines[0]).floatValue();
	t1 = Float.valueOf(lines[1]).floatValue();
	d2 = Float.valueOf(lines[2]).floatValue();
	t2 = Float.valueOf(lines[3]).floatValue();
   }
}
