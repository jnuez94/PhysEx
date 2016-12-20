int i;

void func test2(){
	i = i - 1;
}

void func test(){
	if (i == 1){
		print ("passed test");
	}
	else{
		test2();
	}
}

void func simulation() {
	i = 3;
	while(i > 0) {
		test();
		i = i - 1;
	}
}
