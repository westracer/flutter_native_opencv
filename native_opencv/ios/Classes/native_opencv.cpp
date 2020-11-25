#include <opencv2/opencv.hpp>
#include <chrono>

#ifdef __ANDROID__
#include <android/log.h>
#endif

using namespace cv;
using namespace std;

long long int get_now() {
    return chrono::duration_cast<std::chrono::milliseconds>(
            chrono::system_clock::now().time_since_epoch()
    ).count();
}

void platform_log(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
#ifdef __ANDROID__
    __android_log_vprint(ANDROID_LOG_VERBOSE, "ndk", fmt, args);
#else
    vprintf(fmt, args);
#endif
    va_end(args);
}

// Avoiding name mangling
extern "C" {
    // Attributes to prevent 'unused' function from being removed and to make it visible
    __attribute__((visibility("default"))) __attribute__((used))
    const char* version() {
        return CV_VERSION;
    }

    __attribute__((visibility("default"))) __attribute__((used))
    void process_image(char* inputImagePath, char* outputImagePath) {
        long long start = get_now();
        
        Mat input = imread(inputImagePath, IMREAD_GRAYSCALE);
        Mat threshed, withContours;

        vector<vector<Point>> contours;
        vector<Vec4i> hierarchy;
        
        adaptiveThreshold(input, threshed, 255, ADAPTIVE_THRESH_GAUSSIAN_C, THRESH_BINARY_INV, 77, 6);
        findContours(threshed, contours, hierarchy, RETR_TREE, CHAIN_APPROX_TC89_L1);
        
        cvtColor(threshed, withContours, COLOR_GRAY2BGR);
        drawContours(withContours, contours, -1, Scalar(0, 255, 0), 4);
        
        imwrite(outputImagePath, withContours);
        
        int evalInMillis = static_cast<int>(get_now() - start);
        platform_log("Processing done in %dms\n", evalInMillis);
    }
}
