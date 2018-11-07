#include <stdio.h>
#include <libavutil/log.h>
#include <libavformat/avformat.h>

int main(int argc, char *argv[])
{
    int ret;
    //url
    ret = avpriv_io_delete("./mytestfile.txt"); // avpriv_io_move == change name
    if(ret<0){
        av_log(NULL, AV_LOG_ERROR, "failed to delete file mytestfile.txt\n");
        return -1;
    }
    av_log(NULL, AV_LOG_DEBUG, "Sucess to delete\n");
    return 0;
}
