Invoke-WebRequest -Uri "https://sourceforge.net/projects/opencvlibrary/files/4.5.4/opencv-4.5.4-vc14_vc15.exe" -OutFile ".\download\opencv-4.5.4-vc14_vc15.exe" -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
.\download\opencv-4.5.4-vc14_vc15.exe | Out-Null
$pathToOpenCV = Read-Host 'Type path to opencv build folder (like D:\src\opencv\build)'
[System.Environment]::SetEnvironmentVariable('OpenCV_DIR',$pathToOpenCV)
New-Item -ItemType HardLink -Name .\..\native_opencv_windows\windows\native_opencv.cpp -Target .\..\native_opencv\ios\Classes\native_opencv.cpp
Write-Host 'Done'
Read-Host 'Press any key to continue'