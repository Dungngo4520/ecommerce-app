import 'package:ecommerce/components/loading_screen.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/ChatRoom.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/messages/messages_screen.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isSeeMore = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final firestore = Provider.of<DatabaseMethods>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSeeMore = !isSeeMore;
              });
            },
            child: isSeeMore
                ? Text(widget.product.description)
                : Text(
                    widget.product.description,
                    maxLines: 3,
                  ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${NumberFormat(',###').format(widget.product.price)} ₫',
                style: TextStyle(
                  fontSize: 20,
                  color: cPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              StreamBuilder<UserData>(
                stream: Stream.fromFuture(firestore.getUserById(widget.product.ownerId)),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Column(
                            children: [
                              Text(
                                snapshot.data!.name,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 15),
                              Container(
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  snapshot.data!.photoURL,
                                  height: getProportionateScreenWidth(50),
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: cPrimaryColor,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Email: ${snapshot.data!.email.isEmpty ? 'none' : snapshot.data!.email}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Phone: ${snapshot.data!.phone.isEmpty ? 'none' : snapshot.data!.phone}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Address: ${snapshot.data!.address.isEmpty ? 'none' : snapshot.data!.address}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          actions: [
                            MaterialButton(
                              child: Text("Message"),
                              textColor: cPrimaryColor,
                              onPressed: () async {
                                if (user.uid != widget.product.ownerId) {
                                  String chatroomId =
                                      await firestore.createChatroom(widget.product.ownerId);
                                  ChatRoom chatRoom = await firestore.getChatRoomById(chatroomId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessagesScreen(
                                          userData: snapshot.data!, chatRoom: chatRoom),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(msg: 'It\'s you');
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              snapshot.data!.photoURL,
                              height: getProportionateScreenWidth(50),
                              errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: cPrimaryColor,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return LoadingScreen();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
