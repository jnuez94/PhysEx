void func finishing_move(int i){
	if(i == 0){
		print("Kaahhh..meehhhhh...");
		return;
	}
	if(i == 1){
		print("haa..meehhhhh...");
	}
	else{
		print("HAAAAAAAAAAAAA!");
	}

}
void func simulation () {
	int i;
	for(i = 0; i < 3; i = i + 1){
		finishing_move(i);
	}
}
