int time;
int accel;
int init_y;

int func distance() {
	int curr_y;
	curr_y  = (accel*time*time)/2 + init_y;
	if (curr_y > 0)
		return curr_y;
	print("Splat... ");
	return 0;
}

void func simulation() {
	time = 0;
	accel = -10;
	init_y = 100;

	start(6) {
		sleep(1);
		printi(distance());
		time = time + 1;
	}
}
