import ddf.minim.*;

Minim minim;

AudioSample sLaser01, sLaser02, sLaser03; 
AudioSample sNoise01, sNoise02, sNoise03, sNoise04;
AudioSample sDeath;

AudioPlayer sBgm, sIntro;

void initializeAudio() {
  minim  = new Minim(this);
  
  sLaser01 = minim.loadSample("laser01.wav");
  sLaser01.setGain(-20);
  sLaser02 = minim.loadSample("laser02.wav");
  sLaser02.setGain(-20);
  sLaser03 = minim.loadSample("laser03.wav");
  sLaser03.setGain(-20);
  
  sNoise01 = minim.loadSample("noise01.wav");
  sNoise01.setGain(-20);
  sNoise02 = minim.loadSample("noise02.wav");
  sNoise02.setGain(-20);
  sNoise03 = minim.loadSample("noise03.wav");
  sNoise03.setGain(-20);
  sNoise04 = minim.loadSample("noise04.wav");
  sNoise04.setGain(-20);
  
  sDeath = minim.loadSample("death.wav");
  
  sBgm = minim.loadFile("bgm.wav");
  sIntro = minim.loadFile("intro.wav");
  
  sIntro.loop();
}

