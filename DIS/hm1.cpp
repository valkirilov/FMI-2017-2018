#include <iostream>
using namespace std;

long double rec(long double x, int index) {
	if(index > 1)	{
		index--;
		return rec((long double)(2*x*x - 13*x + 6) / (long double)(x - 8), index);
	}

	return (long double)x;
}

int main() {
	long double a1;
	long index1;
	long index2;
	long index3;
	long index4;
	long index5;

	cout << "An+1 = F(An)" << endl;
	cout << "F(x) = (2*x^2 -13*x + 6)/(x - 8)" << endl;
	cout << "Enter the first element of the sequence. " << endl;

	cin >> a1;
	while(a1 == 8) {
		cout << "This cannot be an initial term. Please enter a number again" << endl;
		cin >> a1;
	}

	if((a1 < 2) || (a1 > 5 && (double)a1 < 5.5) || ((double)a1 > 5.5 && a1 < 8)) {
		cout << "The limit is negative infinity." << endl;
	}
	else if(a1 == 2 || (double)a1 == 5.5) {
		cout << "The limit is 2." << endl;
	} else if (a1 > 2 && a1 <= 5) {
		cout << "The limit is 3." << endl;
	} else if(a1 > 8) {
		cout << "The limit is positive infinity." << endl;
	}

	cout << "Enter five indices to see their corresponding values from the sequence" << endl;

	if(a1!=20) {
		cin >> index1 >> index2 >> index3 >> index4 >> index5;
		cout << "The value of term number " << index1 <<" equals " << rec(a1, index1) << endl;
		cout << "The value of term number " << index2 <<" equals " << rec(a1, index2) << endl;
		cout << "The value of term number " << index3 <<" equals " << rec(a1, index3) << endl;
		cout << "The value of term number " << index4 <<" equals " << rec(a1, index4) << endl;
		cout << "The value of term number " << index5 <<" equals " << rec(a1, index5) << endl;
	}

    return 0;
}
