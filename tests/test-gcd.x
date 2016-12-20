int func gcd(int x, int y)
{
  	while (x != y) {
	    	if (x > y){
	    		x = x - y;
		}
	    	else {
	    		y = y - x;
		}
  	}
  	return x;
}


void func main()
{
	printi(gcd(8,12));
}
