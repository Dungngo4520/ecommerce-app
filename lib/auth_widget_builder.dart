import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/Cart.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, AsyncSnapshot<User?>) builder;

  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthMethods>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.getOnAuthStateChange(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              StreamProvider<List<Cart>>.value(
                value: DatabaseMethods(uid: user.uid).getCart(),
                initialData: [],
                catchError: (context, error) => [],
              ),
              Provider<DatabaseMethods>(
                  create: (context) => DatabaseMethods(uid: user.uid)),
              Provider<User>.value(value: user),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
