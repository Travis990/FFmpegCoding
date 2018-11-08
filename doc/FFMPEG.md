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

### 多媒体文件的基本概念  
* 多媒体文件其实是个容器
* 在容器里有很多流（Stream/Track）
* 每种流是由不同的编码器编码的
* 从流中读出的数据成为包
* 在一个包中包含着一个或多个帧


### FFmpeg操作目录重要结构体
* AVIOContext 操作目录的上下文  
* AVIODirEntry 目录项。用于存放文件名、文件大小等信息。
* AVStream
* AVPacket

实现 ls 功能：

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

### FFmpeg操作流数据的基本步骤  
解复用--> 获取流 --> 读数据包 --> 释放资源  



### [实战]打印音/视频信息  
```
 av_register_all()
 avformat_open_input()/avformat_close_input
 av_dump_format()
```
  
实例见 mediainfo.c  
运行：

```
clang -g -o mediainfo mediainfo.c -lavformat -lavutil  

./mediainfo +文件名

```

### [实战]抽取音频数据  
```
 av_init_packet()
 av_find_best_stream()
 av_read_frame() / av_packet_unref()
``` 

实例见 extra_audio.c  
运行：

```
clang -g -o extra_audio extra_audio.c -lavformat -lavutil  

./extra_audio +文件名 +输出文件名

```


### [实战]抽取音频数据   
```
Start code  
SPS/PPS  
codec --> extradata 
```

实例见 extra_video.c  
运行：

```
clang -g -o extra_video extra_video.c -lavformat -lavutil  

./extra_video +文件名 +输出文件名

```

### [实战]将MP4转成FLV格式  
```
avformat_alloc_output_context2() /avformat_free_context()

avformat_new_stream()  

avcodec_parameters_copy()

avformat_write_header()

av_write_frame() / av_interleaved_write_frame()  
```

实例见 remuxing.c   

 运行：

```
clang -g -o remuxing remuxing.c -lavformat -lavutil  

./remuxing  in.pm4  out.flv

```


### [实战]从MP4截取一段视频  
```
av_seek_frame()  

```
实例见 cutvideo.c   

 运行：

```
clang -g -o cutvideo cutvideo.c -lavformat -lavutil  

./cutvideo  startime endtime srcfile outfile

```

### [实战]一个简单的小咖秀
（将其他人的声音与视频相结合）

* 将两个媒体文件中分别抽取音频和视频轨  
* 将音频与视频轨合并成一个新文件  
* 对音频与视频轨进行裁剪  


### FFmpeg H264解码  
#### 添加头文件  

```
libavcodec/avcodec.h  
```
#### 常用的数据结构  
AVCodec 编解码结构体  
AVCodecContext 编码器上下文  
AVFrame 解码后的帧  


#### 结构体内存的分配与释放  
```
av_frame_alloc/av_frame_free()  
avcodec_alloc_context3()  
avcodec_free_context()  
```

#### 解码步骤  
查找解码器：  

```
avcodec_find_decoder
```
打卡解码器：

```
avcodec_open2
```  

解码：  

```
avcodec_decode_video2
```


### FFmpeg 编码流程  
查找编码器：  

```
avcodec_find_encoder_by_name
```

设置编码参数，并打开编码器：  

```
avcodec_open2
```

编码：  

```
avcodec_encode_video2
```

示例见：encode_video.c


 运行：

```
clang -g -o encode_video encode_video.c -lavcodec -lavformat -lavutil  

 ./encode_video <output file> <codec name>
 
 eg.  ./encode_video 1.h264 libx264

```


### FFmpeg 视频转图片  

示例见：decode_video.c


### FFmpeg AAC 编码
编码流程与视频相同  
编码函数：  

```
avcodec_encodec_audio2
```

示例见：encode_audio.c

运行：  

```
clang -g -o encode_audio encode_audio.c -lavcodec -lavformat -lavutil 

./encode_audio <output file>   

```


