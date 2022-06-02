import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';
import 'package:passage_flutter/theme/components/outlined_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class ImageInfo {
  String title;
  String type;
  String description;
  Image image;

  ImageInfo(this.title, this.type, this.description, this.image);
}

class _WelcomePageState extends State<WelcomePage> {
  final List<ImageInfo> _imagesList = [
    ImageInfo(
        'Intelligent Filter',
        'Intelligent Filter',
        'Click through to see the different components of the filter!',
        Image.asset('assets/welcomePictures/fullview.jpg',
            width: 290, height: 240)),
    ImageInfo(
        'Gravel',
        'Filter Section',
        'The gravel is used to filter out large particles such as twigs, rocks, or leaves',
        Image.asset('assets/welcomePictures/gravel.jpg',
            width: 290, height: 240)),
    ImageInfo(
        'Sand',
        'Filter Section',
        'The sand is used to filter out small particles such as dirt, algae, or other organic matter',
        Image.asset('assets/welcomePictures/sand.jpg',
            width: 290, height: 240)),
    ImageInfo(
        'Activated Charcoal',
        'Filter Section',
        'The activated charcoal is used to filter out harmful chemicals. It latches onto them and doesn\'t let go!',
        Image.asset('assets/welcomePictures/charcoal.jpg',
            width: 290, height: 240)),
    ImageInfo(
        'Reservoirs',
        'Container',
        'The reservoirs hold excess water since the pump can only pump so much at a time! The right one holds filtered water, while the left one holds unfiltered water',
        Image.asset('assets/welcomePictures/reservoirs.jpg',
            width: 290, height: 240)),
  ];
  int currentImage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //first .image is to select the Image asset. second .image is used to refer to the
    //image from the image asset. Weird.
    for (int i = 0; i < _imagesList.length; i++) {
      precacheImage(_imagesList[i].image.image, context);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text("Welcome!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: const AppColors().textBlue,
                  fontSize: 20)),
          const SizedBox(height: 20),
          Expanded(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [
              outlinedButton(
                context,
                text: 'Why a Filter',
                path: '/teacherResources',
              ),
              const SizedBox(height: 20),
              outlinedButton(context,
                  text: 'How to Use', path: '/teacherResources')
            ]),
            const SizedBox(
              width: 20,
            ),
            _imagesList[currentImage].image,
            const SizedBox(
              width: 20,
            ),
            Column(children: [
              SizedBox(
                  width: 290,
                  height: 264,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const AppColors().lightBlue,
                          width: 3,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _imagesList[currentImage].title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 20),
                          Text('Type: ' + _imagesList[currentImage].type),
                          const SizedBox(height: 20),
                          Text('What it does: ' +
                              _imagesList[currentImage].description)
                        ]),
                  )),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentImage > 0) {
                        setState(() {
                          currentImage--;
                        });
                      } else {
                        null;
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Stack(children: [
                      Icon(
                        Icons.circle_outlined,
                        color: (currentImage == 0)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                        size: 30,
                      ),
                      Icon(
                        Icons.chevron_left,
                        color: (currentImage == 0)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                        size: 30,
                      )
                    ]),
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentImage < _imagesList.length - 1) {
                        setState(() {
                          currentImage++;
                        });
                      } else {
                        null;
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Stack(children: [
                      Icon(
                        Icons.circle_outlined,
                        color: (currentImage == _imagesList.length - 1)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                        size: 30,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: (currentImage == _imagesList.length - 1)
                            ? const AppColors().lightBlue
                            : const AppColors().buttonBlue,
                        size: 30,
                      )
                    ]),
                  ),
                ],
              )
            ])
          ]))
        ],
      ),
    );
  }
}
