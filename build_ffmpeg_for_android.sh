PREFIX=android-build

#设置你自己的NDK位置
NDK_HOME=/Users/hugo/Documents/git/android-ndk-r10d/ndk-build
#设置你自己的平台，这上Mac上的，linux换成linux-x86_64
NDK_HOST_PLATFORM=darwin-x86_64

COMMON_OPTIONS="\
    --target-os=android \
    --disable-static \
    --enable-shared \
    --enable-small \
    --disable-programs \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-doc \
    --disable-symver \
    --disable-asm \
    "

function build_android {
    ./configure \
    --libdir=${PREFIX}/libs/armeabi-v7a \
    --incdir=${PREFIX}/includes/armeabi-v7a \
    --pkgconfigdir=${PREFIX}/pkgconfig/armeabi-v7a \
    --arch=arm \
    --cpu=armv7-a \
    --cross-prefix="${NDK_HOME}/toolchains/arm-linux-androideabi-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/arm-linux-androideabi-" \
    --sysroot="${NDK_HOME}/platforms/android-19/arch-arm/" \
    --extra-cflags="-march=armv7-a -mfloat-abi=softfp -mfpu=neon" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS}
    make clean
    make -j8 && make install

    ./configure \
    --libdir=${PREFIX}/libs/arm64-v8a \
    --incdir=${PREFIX}/includes/arm64-v8a \
    --pkgconfigdir=${PREFIX}/pkgconfig/arm64-v8a \
    --arch=aarch64 \
    --cpu=armv8-a \
    --cross-prefix="${NDK_HOME}/toolchains/aarch64-linux-android-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/aarch64-linux-android-" \
    --sysroot="${NDK_HOME}/platforms/android-21/arch-arm64/" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS} 
    make clean
    make -j8 && make install

    ./configure \
    --libdir=${PREFIX}/libs/x86 \
    --incdir=${PREFIX}/includes/x86 \
    --pkgconfigdir=${PREFIX}/pkgconfig/x86 \
    --arch=x86 \
    --cpu=i686 \
    --cross-prefix="${NDK_HOME}/toolchains/x86-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/i686-linux-android-" \
    --sysroot="${NDK_HOME}/platforms/android-19/arch-x86/" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS} 
    make clean
    make -j8 && make install

    ./configure \
    --libdir=${PREFIX}/libs/x86_64 \
    --incdir=${PREFIX}/includes/x86_64 \
    --pkgconfigdir=${PREFIX}/pkgconfig/x86_64 \
    --arch=x86_64 \
    --cpu=x86_64 \
    --cross-prefix="${NDK_HOME}/toolchains/x86_64-4.9/prebuilt/${NDK_HOST_PLATFORM}/bin/x86_64-linux-android-" \
    --sysroot="${NDK_HOME}/platforms/android-21/arch-x86_64/" \
    --extra-ldexeflags=-pie \
    ${COMMON_OPTIONS}
    make clean
    make -j8 && make install

};

build_android
