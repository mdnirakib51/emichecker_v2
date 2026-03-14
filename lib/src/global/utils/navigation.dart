import 'package:flutter/material.dart';

goScreen(BuildContext context, Widget screenName) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return screenName;
  }));
}

goScreenWithName(BuildContext context, String screenName) {
  Navigator.of(context).pushNamed(screenName);
}

goScreenAndRemoveAll(BuildContext context, String screenName) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    screenName,
        (route) => false,
  );
}

goScreenWidgetRemoveAll(BuildContext context, Widget screenName) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screenName), (route) => false);
}

goBack(BuildContext context) {
  Navigator.pop(context);
}