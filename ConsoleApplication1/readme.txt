cin >> a; 
//返回输入 若a为int型，则在输入非int型时返回0 若a为string型 在windows中输入ctrl+z接换行输入时返回0
//若a为string 则只会从一串字符串的第一个字符处开始读入，到换行或第一个空格处停止
string a;
while(cin >> a);
//此时如果在一行中输入a b c d则会循环4次
string a;
getline(cin >> a);
//返回读入的所有字符，遇到换行符停止读入 在windows中输入ctrl+z接换行输入时返回0

//二维数组的动态内存申请和释放
//内存申请
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
//内存释放
for (i = 0;i < num1;i++)
{
	delete [] array[i];
}
delete[]array;
array = NULL;
//申请内存需要判断是否成功，释放内存需要设空指针

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
