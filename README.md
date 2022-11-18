# passage_flutter

Written by [Daniel](https://www.linkedin.com/in/daniel-mccann-sayles/)

Designed by [Cinthya](https://www.linkedin.com/in/cinthyaejh/)


Process to install optimized build of the project on external device:

0. Connect the android device in debugging mode to the machine on which you will do these steps
1. Open project dir in cmdline
2. Run ```flutter build appbundle```
3. Go to a directory one level up
4. Run ```java -jar bundletool-all-1.13.1.jar build-apks --bundle=./LIFE-app/build/app/outputs/bundle/release/app-release.aab --output=./app.apks```
5. Run ```java -jar bundletool-all-1.13.1.jar install-apks --apks=./app.apks```
6. Repeat 5. for each new device provided the code doesn't change. Else start at 1.

This will ensure smooth working of the app on low spec devices.
Read documentation about bundletool to find out how to generate APKs for sharing externally instead of performing installation through a machine.


