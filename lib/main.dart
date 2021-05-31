import 'package:ecommerce/auth_widget.dart';
import 'package:ecommerce/auth_widget_builder.dart';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wemapgl/wemapgl.dart' as WEMAP;

void main() async {
  WEMAP.Configuration.setWeMapKey('WEMAP_API_KEY');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthMethods>(
      create: (context) => AuthMethods(),
      child: AuthWidgetBuilder(
        builder: (context, userSnapshot) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EMO Shopping',
          theme: theme(),
          routes: routes,
          home: AuthWidget(userSnapshot: userSnapshot),
        ),
      ),
    );
  }
}
