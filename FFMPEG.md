# FFmpeg




### FFmpeg 下载、目录
```
git clone https://git.ffmpeg.org/ffmpeg.git
```
libavcodec:       存放各个encode/decoder模块，用于各种类型的声音/图像的编解码；  
libavdevice:      用于对输入/输出设备的支持；  
libavfilter:         滤镜，可用于裁剪视频，添加log等；  
libformat:          存放muxer/demuxer模块，用于各种音视频封装格式的生成和解析；  
libavresample:  混音和重采样；  
libavutil:            存放公共工具函数，包括CRC校验，整数开放，整数取对数，大小端格式转换，内存分配等功能；  
libavpostproc:   用于后期效果处理；  
libswscale:    实现了色彩转换和缩放功能；  




### C 语言基础
clang -g -o testfunc testfunc.c  
./testfunc  

### FFmpeg打印日志  
打印日志关键代码：  

```
av_log_set_level(AV_LOG_DEBUG);

av_log(NULL, AV_LOG_DEBUG, "hello world!\n");
```
终端操作：

```
➜  FFmpegCoding git:(master) ✗ clang -g -o ffmpeg_log ffmpeg_log.c -lavutil
➜  FFmpegCoding git:(master) ✗ ./ffmpeg_log
hello world!  
```


### FFmpeg删除文件
clang -g -o ffmpeg_delfile ffmpeg_delfile.c `pkg-config --libs libavformat`  

clang -g -o ffmpeg_delfile ffmpeg_delfile.c -lavformat -lavutil

```
➜  FFmpegCoding git:(master) ✗ clang -g -o ffmpeg_delfile ffmpeg_delfile.c -lavformat -lavutil
➜  FFmpegCoding git:(master) ✗ ./ffmpeg_delfile
failed to delete file mytestfile.txt
```  

### FFmpeg操作目录重要结构体
* AVIOContext 操作目录的上下文  
* AVIODirEntry 目录项。用于存放文件名、文件大小等信息。

```
➜  FFmpegCoding git:(master) ✗ clang -g -o list ffmpeg_list.c -lavformat -lavutil
➜  FFmpegCoding git:(master) ✗ ./list
         186 ffmpeg_log.c
        2462 build_ffmpeg_for_android.sh
        4433 list.c
         826 ffmpeg_list.c
          96 list.dSYM
        8196 .DS_Store
        5209 encode_audio.c
        1051 read_file.c
       11151 extr_video.c
          96 ffmpeg_delfile.dSYM
       11027 avmerge.c
        9532 decode_video.c
        5747 cutvideo.c
        1604 README.md
        4265 encode_video.c
          96 asserts
        8760 ffmpeg_log
         408 ffmpeg_delfile.c
        6500 extr_audio.c
        9436 list
         128 android
        1073 mediainfo.c
        7020 decode_audio.c
        1666 FFMPEG.md
        8768 ffmpeg_delfile
        5132 remuxing.c
         416 .git
          96 .vscode
          96 ffmpeg_log.dSYM
         803 write_file.c
        5066 extra_audio_ffapi.c
         288 player
```

