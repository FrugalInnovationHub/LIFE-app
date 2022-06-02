import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class FilterResources extends StatefulWidget {
  const FilterResources({Key? key}) : super(key: key);

  @override
  State<FilterResources> createState() => FilterResourcesState();
}

class FilterResourcesState extends State<FilterResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'Filter Resources'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  Text('Filter Resources'),
                  Text('This will be the filter resources')
                ],
              ))),
    );
  }
}
