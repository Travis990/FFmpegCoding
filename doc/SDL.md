# SDL 

SDL (Simple DirectMedia Layer)  
由C语言实现的跨平台的媒体开源库  
多用于开发游戏、模拟器、媒体播放器等多媒体应用领域  

### SDL 编译与安装  

[下载SDL源码](http://www.libsdl.org/download-2.0.php)  
解压源码： tar -zvxf SDL2-2.0.9.tar.gz  
生成 Makefile： configure -- prefix=/usr/local  
安装： sudo make -j 8 && make install  

### 使用SDL基本步骤  
添加头文件 

```
#include<SDL.h>  
```
初始化 SDL  
退出 SDL  


### SDL 渲染窗口  
```
SDL_Init/SDL_Quit()  
SDL_CreateWindow()/SDL_DestroyWindow()  
SDL_CreateRender()/SDL_DestroyRender()
SDL_RenderClear
SDL_RenderPresent    
```

运行：

```
clang -g -o SDL SDL.c -lsdl2
SDL.c:1:10: fatal error: 'SDL.h' file not found
#include <SDL.h>
         ^~~~~~~
1 error generated.
```
结果报错找不到SDL的库；  

[pkg-config命令](https://www.jianshu.com/p/7eee92d8ad7b) 
 
mac 安装 pkg-config  
1，下载mac最新版[pkg-config](https://pkg-config.freedesktop.org/releases/)  
2，解压:tar -zvxf pkg-config-0.29.2.tar.gz  
   终端cd到解压文件夹下  
3，运行配置文件进行系统配置：./configure --with-internal-glib  
4，编译pkgconfig：make  
5，安装包自检测： make check  
6，安装： make install   


```
➜  FFmpegCoding git:(master) ✗ pkg-config --libs sdl2
-L/usr/local/lib -lSDL2

➜  FFmpegCoding git:(master) ✗ pkg-config --cflags --libs sdl2
-D_THREAD_SAFE -I/usr/local/include/SDL2 -L/usr/local/lib -lSDL2

FFmpegCoding git:(master) ✗ clang -g -o SDL SDL.c `pkg-config --cflags --libs sdl2`

```

### SDL 事件基本原理  

```
SDL_PollEvent
SDL_WaitEvent
``` 

示例见：sdl_event.c  

运行：

```
➜  FFmpegCoding git:(master) ✗ clang -g -o sdl_event sdl_event.c `pkg-config --cflags --libs sdl2`
➜  FFmpegCoding git:(master) ✗ ./sdl_event
```



### 纹理渲染-SDL渲染基本原理  
内存图像-->渲染器--> 纹理 --> 交换到显卡 --> 窗口展示  

#### SDL纹理相关API
```
SDL_CreateTexture()
   format: YUV, RGB  
   access: Texture类型，Target，Stream
   
SDL_DestroyTexture()
```
 
#### SDL渲染相关API
```
SDL_SetRenderTarget()  
SDL_RenderClear()
SDL_RenderCopy()  
SDL_RenderPresent()
```
示例见： texture.c

运行：

```
➜  FFmpegCoding git:(master) ✗ clang -g -o texture texture.c `pkg-config --cflags --libs sdl2`
➜  FFmpegCoding git:(master) ✗ ./texture
```


### [实战]YUV视频播放器  
#### SDL创建线程  
```
SDL_CreateThread
    fn:线程执行函数  
    name:线程名  
    data:执行函数参数  
```
#### SDL更新纹理  
```
SDL_UpdateTexture()

SDL_UpdateYUVTexture()
```

示例见: yuv_player.c  

```
clang -g -o yuv_player yuv_player.c `pkg-config --cflags --libs sdl2`
```
TODO dubug yuv_player.c 

### SDL播放音频 
#### 播放音频基本流程  
打开音频设备--> 设置音频参数 --> 向声卡喂数据 --> 播放音频 --> 关闭设备  

#### 播放音频的基本原则  
* 声卡向你要数据而不是你主动推给声卡  
* 数据的多少由音频参数决定的  

#### SDL 音频API  
```
SDL_OpenAudio/SDL_CloseAudio  
SDL_PauseAudio  
SDL_MixAudio  
``` 

### [实战]PCM音频播放器  

