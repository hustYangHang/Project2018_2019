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
	getline(cin, a);
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