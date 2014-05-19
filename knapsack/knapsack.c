#include <stdlib.h>
#include <stdio.h>

int *w, *p, *x, *y;
int dummy, counter, m, n, fp, fw, fe;
int mybool;

int myrand, a, b, modulo;

int Bound(int cp, int cw, int k) {
	int b, c, counter;
	b = cp;
	c = cw;
	counter = k+1;
	while (counter < n) {
		c = c+w[counter];
		if(c < m) {
			b = b+p[counter];
		} else {
			return b+(1-(c-m)/w[counter])*p[counter];
		}
		counter = counter+1;
	}
	return b;
}

int BKnap(int k, int cp, int cw) {
	int dummy, counter;
	if(cw+w[k] <= m) {
		y[k] = 1;
		if(k < n-1) dummy = BKnap(k+1, cp+p[k], cw+w[k]);
		if((cp+p[k] > fp) && (k == n-1)) {
			fp = cp+p[k];
			fw = cw+w[k];
			counter = 0;
			while(counter <= k) {
				x[counter] = y[counter];
				counter = counter+1;
			}
		}
	}
	if(Bound(cp, cw, k) >= fp) {
		y[k] = 0;
		if(k < n-1) dummy = BKnap(k+1, cp, cw);
		if((cp > fp) && (k == n-1)) {
			fp = cp;
			fw = cw;
			counter = 0;
			while(counter <= k) {
				x[counter] = y[counter];
				counter = counter+1;
			}
		}
	}
	return 0;
}

int NextRand(int number, int mult, int incr, int modulo) {
	int temp;
	temp = number*mult+incr;
	return temp - (temp/modulo)*modulo;
}

int exchange(int i, int j) {
	int p_temp, w_temp;
	p_temp = p[i];
	p[i] = p[j];
	p[j] = p_temp;
	w_temp = w[i];
	w[i] = w[j];
	w[j] = w_temp;
	return 1;
}

int partition(int f, int l) {
	int p_elem, w_elem, i, j, dummy;

	p_elem = p[l];
	w_elem = w[l];  
	i = f-1;
	j = f;
	while (j <= l-1) {
		if (p[j]*w_elem >= p_elem*w[j]) {
			i = i+1;
			dummy = exchange(i,j);
		}
		j = j+1;
	}
	dummy = exchange(i+1,l);
	return i+1;
}

int quicksort(int f, int l) {
	int q, dummy;
	if(f < l) {
		q = partition(f,l);
		dummy = quicksort(f,q-1);
		dummy = quicksort(q+1,l);
	}
	return 1;
}

int main(int argc, const char **argv) {
	w = malloc(sizeof(int)*1000);
	p = malloc(sizeof(int)*1000);
	x = malloc(sizeof(int)*1000);
	y = malloc(sizeof(int)*1000);

	n = 1000;
	m = 600;
	fp = 0-1;
	fw = 0;
	fe = 0;

	myrand = 1;
	a = 40;
	b = 3641;
	modulo = 729;

	counter = 0;
	while(counter < n) {
		myrand = NextRand(myrand, a, b, modulo);
		w[counter] = myrand/20+10;
		myrand = NextRand(myrand, a, b, modulo);
		p[counter] = myrand/90+1; 
		x[counter] = 0;
		y[counter] = 0;
		counter = counter+1;
	}

	mybool = quicksort(0, n-1);

	dummy = BKnap(0,0,0);

	counter = 0;
	while(counter < n) {
		if(x[counter] == 1) fe = fe+1;
		counter = counter+1;
	}

	printf("%d\n", fe);
	printf("%d\n", fp);
	printf("%d\n", fw);

	return 0;
}
