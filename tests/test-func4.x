int func RecTest(int i){
	int result;
	result = 0;
	if (i == 1){
       return 1;
	}
    else{
       result = RecTest(i - 1);
       printi(result);
       result = result + 1;
    }
    return result;
}

void func simulation () {
	int i;
	i = 11;
	RecTest(i);
}
