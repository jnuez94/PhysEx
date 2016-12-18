int func RecTest(int i){
	if (i == 1){
       return 1;
	}
    else{
       int result = RecTest(i - 1);
       printi(result);
    }
    return 0;
}

void func main() {
	int i = 11;
	RecTest(i);
}
