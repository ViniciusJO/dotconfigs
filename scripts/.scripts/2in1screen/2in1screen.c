// gcc -O2 -o 2in1screen 2in1screen.c

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>

#define __USE_POSIX
#include <signal.h>
#include <stdarg.h>

static void signal_handler(int);
static void cleanup(void);
void init_signals(void);
void panic(const char *, ...);

struct sigaction sigact;
char *progname;

void init_signals(void){
    sigact.sa_handler = signal_handler;
    sigemptyset(&sigact.sa_mask);
    sigact.sa_flags = 0;
    sigaction(SIGINT, &sigact, (struct sigaction *)NULL);
    sigaction(SIGUSR1, &sigact, (struct sigaction *)NULL);
}







bool auto_rotate;
bool auto_save;

extern FILE *popen(const char *__command, const char *__modes);
extern int pclose (FILE *__stream) __nonnull ((1));

/*#define STATE_BASEDIR "~/.local/state/2in1"*/
#define STATE_BASEDIR "."
#define STATE_FILENAME "state"
#define STATE_FILEPATH (STATE_BASEDIR "/" STATE_FILENAME)

#define DATA_SIZE 256
#define N_STATE 4
char basedir[DATA_SIZE];
char *basedir_end = NULL;
char content[DATA_SIZE];
char command[DATA_SIZE*4];

char *RES[]   = {"1920x1080",			"1920x1080", 			"1920x1080", 				"1920x1080"};
char *ROT[]   = {"normal", 				"inverted", 			"left", 				"right"};
char *COOR[]  = {"1 0 0 0 1 0 0 0 1",	"-1 0 1 0 -1 1 0 0 1", 	"0 -1 1 1 0 0 0 0 1", 	"0 1 0 -1 0 1 0 0 1"};
// char *TOUCH[] = {"enable", 				"disable", 				"disable", 				"disable"};

double accel_y = 0.0,
#if N_STATE == 4
	   accel_x = 0.0,
#endif
	   accel_g = 7.0;

int current_state = 0;

int rotation_changed(){
	int state = 0;

	if(accel_y < -accel_g) state = 0;
	else if(accel_y > accel_g) state = 1;
#if N_STATE == 4
	else if(accel_x > accel_g) state = 2;
	else if(accel_x < -accel_g) state = 3;
#endif

	if(current_state!=state){
		current_state = state;
		return 1;
	}
	else return 0;
}

FILE* bdopen(char const *fname, char leave_open){
	*basedir_end = '/';
	strcpy(basedir_end+1, fname);
	FILE *fin = fopen(basedir, "r");
	setvbuf(fin, NULL, _IONBF, 0);
	fgets(content, DATA_SIZE, fin);
	*basedir_end = '\0';
	if(leave_open==0){
		fclose(fin);
		return NULL;
	}
	else return fin;
}

bool save_state() {
  FILE *state_fd = fopen(STATE_FILEPATH, "w");
	if(state_fd == NULL){
		fprintf(stderr, "Could not open state file.\n");
		return false;
}

  char c = (current_state & (auto_rotate<<4)) + '0';
  printf("Saved %c on file %s\n", c, STATE_FILEPATH);
  fprintf(state_fd, "%c", c);

  
  printf("[CHANGE]: auto_rotate: %d\ncstate: %d\n", auto_rotate, current_state);

  fclose(state_fd);
  return true;
}

void rotate_screen(){
  //try to explicitly set the resolution to prevent screen going black for long interval whein rotating left or right
	sprintf(command, "xrandr -o %s -s %s", ROT[current_state], RES[current_state]);
	system(command);
	sprintf(command, "xinput set-prop \"%s\" \"Coordinate Transformation Matrix\" %s", "GXTP7936:00 27C6:0123", COOR[current_state]);
	system(command);
	sprintf(command, "pkill -USR1 polybar");
	system(command);
  if(auto_save && !save_state()) exit(3);
}

void refresh_state_dependants() {
  char cmd[255];
  sprintf(cmd, "ps -A | grep 2in1screen | awk '{print $1}' | grep -v \"^%d$\" | while read -r TARGET_PID; do kill -USR1 $TARGET_PID; done", getpid());
  /*printf("\n\nPID: %d\n\n", getpid());*/
  system(cmd);
  system("polybar-msg action \"#rotate.hook.0\" &> /dev/null");
}

void get_state() {
  FILE *state_fd_r = fopen(STATE_FILEPATH, "r");

  if(state_fd_r == NULL){
    fprintf(stderr, "Could not open previous state.\n");
  } else {
    char buff;
    if(fscanf(state_fd_r, "%c", &buff) == 1){
      auto_rotate = (buff - '0') & 4;
      current_state = (buff - '0') & 3;
      //{"normal", "inverted", "left", "right"};
    }; 
  }

  fclose(state_fd_r);
}

static void signal_handler(int sig){
    if (sig == SIGINT) panic("\n\nCaught signal for Ctrl+C\n");
    else if (sig == SIGUSR1) {
      get_state();
      rotate_screen();
      puts("usr signal\n");      
    }
}

void panic(const char *fmt, ...){
    char buf[50];
    va_list argptr;
    va_start(argptr, fmt);
    vsprintf(buf, fmt, argptr);
    va_end(argptr);
    fprintf(stderr, "%s", buf);
    exit(-1);
}

void cleanup(void){
    sigemptyset(&sigact.sa_mask);
    /* Do any cleaning up chores here */
}

void get_accell(FILE *dev_accel_x, FILE* dev_accel_y, int scale) {
		fseek(dev_accel_y, 0, SEEK_SET);
		fgets(content, DATA_SIZE, dev_accel_y);
		accel_y = atof(content) * scale;
#if N_STATE == 4
		fseek(dev_accel_x, 0, SEEK_SET);
		fgets(content, DATA_SIZE, dev_accel_x);
		accel_x = atof(content) * scale;
#endif
}

int main(int argc, char *argv[]) {
  
  system("mkdir -p " STATE_BASEDIR);

  get_state();

  if(argc > 1) {

    if(!strcmp("polybar_icon", argv[1])) {
      if(auto_rotate) puts("%{B-}%{F#0771ed} 󰢆  %{B- F-}");
      else puts("%{B-}%{F#73d0ff} 󰢆  %{B- F-}");
      return 0;
    }

    if(!strcmp("auto_on", argv[1])) {
      puts("auto_on");
      auto_rotate = !auto_rotate;
      save_state();
      refresh_state_dependants();
      return 0;
    }

    if(!strcmp("get_state", argv[1])) {
      printf("auto_rotate: %s\ncstate: %s\n", auto_rotate ? "true" : "false", ROT[current_state]);
      return 0;
    }
  }

	FILE *pf = popen("ls /sys/bus/iio/devices/iio:device*/in_accel*", "r");
	if(!pf){
		fprintf(stderr, "IO Error.\n");
		return 2;
	}

	if(fgets(basedir, DATA_SIZE , pf)!=NULL){
		basedir_end = strrchr(basedir, '/');
		if(basedir_end) *basedir_end = '\0';
		/*fprintf(stderr, "Accelerometer: %s\n", basedir);*/
	} else{
		fprintf(stderr, "Unable to find any accelerometer.\n");
		return 1;
	}
	fclose(pf);

	bdopen("in_accel_scale", 0);
	double scale = atof(content);

	FILE *dev_accel_y = bdopen("in_accel_y_raw", 1);
#if N_STATE == 4
	FILE *dev_accel_x = bdopen("in_accel_x_raw", 1);
#endif


    if(argc > 1 && !strcmp("set_position", argv[1])) {
      puts("set_position");
      auto_rotate = false;
      get_accell(dev_accel_x, dev_accel_y, scale);
      rotation_changed();
      rotate_screen();
      save_state();
      refresh_state_dependants();
      /*system("play ~/Music/Effects/peeeiing.mp3");*/
      return 0;
    }



  /*printf("ARGC: %d\n", argc);*/
  /*for(int i = 0; i<argc; i++) {*/
  /*  printf("%s\n", argv[i]);*/
  /*}*/

  progname = *(argv);
  atexit(cleanup);
  init_signals();

	while(1){
    get_accell(dev_accel_x, dev_accel_y, scale);
		if(auto_rotate && rotation_changed())
			rotate_screen();
		sleep(2);
	}
	
	return 0;
}
