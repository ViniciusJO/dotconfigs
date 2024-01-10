octave:11> x=0:0.01:8*pi;
octave:12> plot(x, cos(x))
octave:13> hold on;
octave:14> plot(x, sin(x))
octave:15> close
octave:16> plot(x, cos(x))
octave:17> plot(x, cos(x+pi))
octave:17> hold on;
octave:18> plot(x, cos(x+pi))
octave:19> plot(x, 0.5*cos(x+pi))
octave:20> plot(x, 0.5*cos(x+pi)-0.5)
octave:21> hold off;
octave:22> plot(x, 0.5*cos(x+pi)-0.5)
octave:23> hold on;
octave:24> plot(x, cos(x))
octave:25> plot(x, 0.5*cos(x+pi)-0.5+cos(x))
octave:26> plot(x, 0.5*cos(x+pi)-0.5+cos(x))
octave:26> plot(x, 0.5*cos(x)-0.5)
octave:27> 

