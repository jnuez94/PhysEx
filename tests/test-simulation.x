int ball;
void func test(){
	ball = ball + 1;
	printi(ball);
}
void func simulation() {
	ball = 0;
	start (5) {
		test();
	}
}
