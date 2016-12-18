int i;
int j;
function main() {
	j = 0;
	for(i = 0; i < 5; i=i+1){
		printi(j);
		j = i;
	}
	printi(10);
}
