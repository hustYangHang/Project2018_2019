cin >> a; 
//返回输入 若a为int型，则在输入非int型时返回0 若a为string型 在windows中输入ctrl+z接换行输入时返回0
//若a为string 则只会从一串字符串的第一个字符处开始读入，到换行或第一个空格处停止
string a;
while(cin >> a);
//此时如果在一行中输入a b c d则会循环4次
string a;
getline(cin >> a);
//返回读入的所有字符，遇到换行符停止读入 在windows中输入ctrl+z接换行输入时返回0
