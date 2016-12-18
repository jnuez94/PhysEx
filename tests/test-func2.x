int i;
void func finishing_move(int i){
	if(i == 0){
		print("Kaahhh..meehhhhh...");
	}
	if(i == 1){
		print("haa..meehhhhh...");
	}
	else{
		print("HAAAAAAAAAAAAA!");
	}

}
void func main() {
	for(i = 0; i < 3; i = i + 1){
		finishing_move(i);
	}
}
