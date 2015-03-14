import ddf.minim.*;
import ddf.minim.analysis.*; 
Minim minim;
AudioPlayer song;
FFT fft;

int logx = 10;
int logy = 195;
float volThreshold = 2.2;
float volMax = 0.5;


void setup() {
  size(1200, 400);
  minim = new Minim(this);
  song = minim.loadFile("08 Soul Lam Plearn.mp3");
  fft = new FFT(song.bufferSize(), song.sampleRate());
  song.loop();
}
void draw() {
  translate(-340,0); // Moves the visualizer lazily
  background(0);

  fft.forward(song.left);
  for (int i = 0; i < fft.specSize (); i++)
  {
    int x1 = (int) (log(i+logx)*logy);
    if (fft.getBand(i) > volThreshold)
    {
      stroke(map(fft.getBand(i), 0, 70, 0, 255), 0, 100);
      line(x1, height/2, x1, height/2 - fft.getBand(i)*volMax );
    }
  }   

  fft.forward( song.right );
  for (int i = 0; i < fft.specSize (); i++)
  {
    int x1 = (int) (log(i+logx)*logy);
    if (fft.getBand(i) > volThreshold)
    {
      stroke(map(fft.getBand(i), 0, 70, 0, 255), 0, 100);
      line(x1, height/2, x1, height/2 + fft.getBand(i)*volMax );
    }  
  }
}

