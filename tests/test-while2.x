int i;
int j;
int k;
void func simulation() {
	i = 0;
	k = 0;
	while(i < 3) {
		for (j = 0; j < 3; j = j + 1) {
			while (k < 3){
				print("slam\n");
				k = k + 1;
			}
			print("dank\n");
			k = 0;
		}
		print ("memes\n");
		i=i+1;
	}
}
