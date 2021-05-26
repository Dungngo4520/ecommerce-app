import 'dart:io';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/services/storage.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  static final String route = 'myaccoount';

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool isEdit = false;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  dynamic imageFile;
  final picker = ImagePicker();
  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null)
        imageFile = File(pickedFile.path);
      else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected.')));
    });
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    final firestore = Provider.of<DatabaseMethods>(context);
    final storage = Provider.of<StorageMethods>(context);
    displayNameController.text = userData.name;
    phoneController.text = userData.phone;
    addressController.text = userData.address;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account Information'),
        actions: [
          MaterialButton(
            onPressed: () async {
              if (isEdit) {
                if (displayNameController.text == "" ||
                    displayNameController.text == "" ||
                    addressController.text == "") {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Please fill all the fields")));
                } else {
                  await firestore.updateUser(
                      displayName: displayNameController.text,
                      phone: phoneController.text,
                      address: addressController.text);
                }
                if (imageFile != null) {
                  String photoURL = await storage.uploadFile(imageFile);
                  await firestore.updateUser(photoURL: photoURL);
                }
                setState(() {
                  imageFile = null;
                });
              }
              setState(() {
                isEdit = !isEdit;
              });
            },
            shape: CircleBorder(),
            minWidth: 0,
            child: isEdit ? Icon(Icons.check) : Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black.withAlpha(20),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.antiAlias,
                        child: imageFile == null
                            ? Image.network(
                                userData.photoURL,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 110,
                                ),
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
                              )
                            : Image.file(imageFile),
                      ),
                    ),
                    if (isEdit)
                      Positioned(
                        bottom: 0,
                        right: -12,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          // ignore: deprecated_member_use
                          child: PopupMenuButton(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xfff5f6f9),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/Camera Icon.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Gallery'),
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Camera'),
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Email:'),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(userData.email),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Name:'),
                      ),
                      isEdit
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: displayNameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(getProportionateScreenWidth(5)),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(getProportionateScreenHeight(10)),
                                  ),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Text(displayNameController.text),
                            ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Phone:'),
                      ),
                      isEdit
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(getProportionateScreenWidth(5)),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(getProportionateScreenHeight(10)),
                                  ),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Text(phoneController.text),
                            ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Address:'),
                      ),
                      isEdit
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(getProportionateScreenWidth(5)),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(getProportionateScreenHeight(10)),
                                  ),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Text(addressController.text),
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
