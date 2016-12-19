int ball;
void func test(){
	ball = ball + 1;
	printi(ball);
}
void func main() {
	ball = 3;
	startEnv {
		test();
	}
}
