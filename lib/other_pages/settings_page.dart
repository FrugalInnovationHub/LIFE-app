import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';

class SettingsPage extends StatefulWidget {
  final Function changeLocale;

  const SettingsPage({Key? key, required this.changeLocale}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  bool _isSelected = false;
  late Locale _myLocale;
  //false is english, true is spanish

  @override
  void initState() {
    super.initState();
    //delayed to avoid crashing. reference: https://stackoverflow.com/questions/56395081/unhandled-exception-inheritfromwidgetofexacttype-localizationsscope-or-inheri
    Future.delayed(Duration.zero, () {
      _myLocale = Localizations.localeOf(context);
      if (_myLocale.languageCode == 'es') {
        _isSelected = true;
      }
    });
  }

  void onChanged(bool newValue) {
    setState(() {
      _isSelected = newValue;
    });
    //true set to spanish
    if (_isSelected) {
      widget.changeLocale(const Locale.fromSubtags(languageCode: 'es'));
    } else {
      widget.changeLocale(const Locale.fromSubtags(languageCode: 'en'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: secondaryAppBar(context, 'Profile Settings'),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Profile Settings',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () {
                      onChanged(!_isSelected);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Expanded(child: Text('Language:')),
                          const Text('English'),
                          Switch(
                            value: _isSelected,
                            onChanged: (bool newValue) {
                              onChanged(newValue);
                            },
                          ),
                          const Text('Spanish'),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
