#include "pch.h"
#include "Solution.h"

using namespace std;

int Solution::digitCount(int k, int n)//Count the number of k's between 0 and n. k can be 0 - 9.
{
	if (k < 0 || k > 9) return -1;

	int low = 0, cur = 0, high = 0;
	int count = 0, factor = 1;

	while (n / factor > 0)
	{
		low = n - (n / factor) * factor;
		high = n / (factor * 10);
		cur = (n / factor) % 10;

		if (cur < k)
			count += high * factor;
		else if (cur == k)
			count += high * factor + low + 1;
		else
			count += (high + 1) * factor;

		factor *= 10;
	}
	if (n == 0 && k == 0) return 1;
	else return k == 0 && n > 9 ? count - factor / 10 : count;
}