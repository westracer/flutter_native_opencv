mkdir -p download
cd download

wget -O opencv-4.5.4-android-sdk.zip https://sourceforge.net/projects/opencvlibrary/files/4.5.4/opencv-4.5.4-android-sdk.zip/download
wget -O opencv-4.5.4-ios-framework.zip https://sourceforge.net/projects/opencvlibrary/files/4.5.4/opencv-4.5.4-ios-framework.zip/download

unzip opencv-4.5.4-android-sdk.zip
unzip opencv-4.5.4-ios-framework.zip

cp -r opencv2.framework ../../native_opencv/ios
cp -r OpenCV-android-sdk/sdk/native/jni/include ../../native_opencv
mkdir -p ../../native_opencv/android/src/main/jniLibs/
cp -r OpenCV-android-sdk/sdk/native/libs/* ../../native_opencv/android/src/main/jniLibs/

echo "Done"