# C


### GCC/CLANG

gcc/clang -g -O2 -o test test.c -I... -L... -l  
-g: 输出文件中的调试信息  
-O: 对输出文件做指令优化  
-o: 输出文件  
-I：指定头文件  
-L：指定库文件位置  
-l: 指定使用哪个库  

```
clang -g -o testfunc testfunc.c  
./testfunc 
```

### 编译过程  
* 预编译
* 编译
* 链接、动态链接/静态链接  




### 调试器原理  
* 编译输出带调试信息的程序
* 调试信息包含：指令地址、对应源代码及行号
* 指令完成后，回调


gdb/lldb 
