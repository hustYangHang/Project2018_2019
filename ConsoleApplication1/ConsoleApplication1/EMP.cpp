#include "pch.h"
#include "EMP.h"

using namespace std;


EMP::EMP()
{
}

EMP::~EMP()
{
}
void EMP::emp3_6()//��������ַ�ȫ����x�滻
{
	string a;
	cout << "������һ���ַ�" << endl;
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

void EMP::emp3_8()//��������ַ�ȫ����x�滻
{
	string a;
	cout << "������һ���ַ�" << endl;
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

void EMP::emp3_10()//ȥ�������ַ��ı�����
{
	string a;
	cout << "������һ���ַ�" << endl;
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