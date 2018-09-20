#include "pch.h"
#include "EMP.h"

using namespace std;


EMP::EMP()
{
}

EMP::~EMP()
{
}
void EMP::emp3_6()//将输入的字符全部用x替换
{
	string a;
	cout << "请输入一串字符" << endl;
	while (a.size() == 0 || a[0] == ' ')
	{
		getline(cin, a);
		cout << "请输入一串字符" << endl;
	}
	for (auto &c : a)
	{
		if (isalnum(c))
		{
			c = 'x';
		}
	}
	cout << a << endl;
}

void EMP::emp3_8()//将输入的字符全部用x替换
{
	string a;
	cout << "请输入一串字符" << endl;
	getline(cin, a);
	decltype(a.size()) index = 0;
	if (!a.empty())
	{
		while (index < a.size())
		{
			if (isalnum(a[index]))
			{
				a[index] = 'x';
			}
			index++;
		}
		cout << a << endl;
	}
}

void EMP::emp3_10()//去掉输入字符的标点符号
{
	string a;
	cout << "请输入一串字符" << endl;
	getline(cin, a);
	for (auto &c : a)
	{
		if (!ispunct(c))
		{
			cout << c;
		}
	}
	cout << endl;
}

void EMP::emp_91_1()
{
	int a(0);
	vector<int> array_a;
	while (cin >> a)
	{
		array_a.push_back(a);
	}
	cout << "cout the vector:" << endl;
	for (int i = 0;i < array_a.size();i++)
	{
		cout << array_a[i] << endl;
	}
}
void EMP::emp_91_2()
{
	string a;
	vector<string> array_a;
	while (getline(cin,a))
	{
		array_a.push_back(a);
	}
	cout << "cout the "<< array_a.size()<<" vector:" << endl;
	for (auto i:array_a)
	{
		cout << i << endl;
	}
}
void EMP::emp_94_2()
{
	string a;
	vector<string> string_a;
	while(cin >> a)
	{
		string_a.push_back(a);
	}
	for (auto &i : string_a)
	{
		for (auto &j : i)
		{
			if (islower(j))
			{
				j = toupper(j);
			}
		}
		cout << i << endl;
	}
}
void EMP::emp_94_4()
{
	vector<int> a(10,42);
	vector<int> b{42,42,42,42,42,42,42,42,42,42};
	vector<int> c;
	for (int i = 0; i < 10; i++)
	{
		c.push_back(42);
	}
	for (int i = 0; i < 10; i++)
	{
		cout << "a: " << a[i] << " b: " << b[i] << " c: " << c[i] << endl;
	}

}
void EMP::emp_94_5()
{
	vector<int> c;
	for (int i = 0; i < 10; i++)
	{
		c.push_back(i);
	}
	for (int i = 0; i < c.size()/2; i++)
	{	
		cout << c[i] + c[c.size() - i - 1] << endl;
		if (i+1 == c.size()-i-1-1)
		{
			cout << c[i+1] << endl;
		}
	}
}