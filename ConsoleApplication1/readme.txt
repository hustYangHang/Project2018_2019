cin >> a; 
//�������� ��aΪint�ͣ����������int��ʱ����0 ��aΪstring�� ��windows������ctrl+z�ӻ�������ʱ����0
//��aΪstring ��ֻ���һ���ַ����ĵ�һ���ַ�����ʼ���룬�����л��һ���ո�ֹͣ
string a;
while(cin >> a);
//��ʱ�����һ��������a b c d���ѭ��4��
string a;
getline(cin >> a);
//���ض���������ַ����������з�ֹͣ���� ��windows������ctrl+z�ӻ�������ʱ����0

//��ά����Ķ�̬�ڴ�������ͷ�
//�ڴ�����
int num1 = num1;
int num2 = num2;
int **array = new int *[num1]
for (i = 0;i < num1;i++)
{
	array[i] = new int[num2];
	if(array[i]==NULL)
	{
		cout<<"allocate memory failed!"<<endl;
		return 0;
	}
}
//�ڴ��ͷ�
for (i = 0;i < num1;i++)
{
	delete [] array[i];
}
delete[]array;
array = NULL;
//�����ڴ���Ҫ�ж��Ƿ�ɹ����ͷ��ڴ���Ҫ���ָ��

int a = 105;
int retCnt = 0;
int tmp5 = 5;
while (tmp5 <= a)
{
	retCnt += a / tmp5;
	tmp5 *= 5;
	if (tmp5 % 5 != 0)   break;
}

int arr[6] = { 0, 1, 2, 3, 4, 5 };
cout << getMaxOrMin(arr,6,1) << endl;
int a = 10;
int *p = &a;
int *&q = p;
*q = 20;
cout << a << endl;
int a = 6;
int b = 7;
int x[3] = {1,2,3};
cout << getMax(x,3) << endl;
cout << getMax(a,b) << endl;
double a(3.14);
double b(0);
double *c = new double [2];
b = modf(a, c);
c[1] = 1;
cout << "a = "<< a <<" modf(a) = "<<b<<" int(a) = "<<c[0]<< endl;
//c[0] = 1;
//c[1] = 2;
//cout << c[0] << " " << c[1] << endl;
delete []c;
