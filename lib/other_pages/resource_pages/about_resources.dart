import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class AboutResources extends StatefulWidget {
  const AboutResources({Key? key}) : super(key: key);

  @override
  State<AboutResources> createState() => AboutResourcesState();
}

class AboutResourcesState extends State<AboutResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'About LIFE'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  Text('About Life'),
                  Text('This will be the about resources')
                ],
              ))),
    );
  }
}
