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
import 'package:wemapgl/wemapgl.dart';

class MyAccountScreen extends StatefulWidget {
  static final String route = 'myaccoount';

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool isEdit = false;

  List<WeMapPlace> wemapAddress = [];
  WeMapSearchAPI searchAPI = WeMapSearchAPI();
  LatLng latLng = new LatLng(20.037, 105.7876);

  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode addressFocus = FocusNode();

  late final userData;
  late final firestore;
  late final storage;

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
  void didChangeDependencies() {
    userData = Provider.of<UserData>(context, listen: false);
    firestore = Provider.of<DatabaseMethods>(context, listen: false);
    storage = Provider.of<StorageMethods>(context, listen: false);
    displayNameController.text = userData.name;
    phoneController.text = userData.phone;
    addressController.text = userData.address;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please properly fill all the field'),
                    ),
                  );
                } else {
                  await firestore.updateUser(
                      displayName: displayNameController.text,
                      phone: phoneController.text,
                      address: addressController.text);
                  setState(() {
                    isEdit = false;
                  });
                }
                if (imageFile != null) {
                  String photoURL = await storage.uploadFile(imageFile);
                  await firestore.updateUser(photoURL: photoURL);
                }
                setState(() {
                  imageFile = null;
                });
              } else
                setState(() {
                  isEdit = true;
                  wemapAddress = [];
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5),
                        child: Text('Email:'),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5),
                        child: Text('Name:'),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5),
                        child: Text('Phone:'),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5),
                        child: Text('Address:'),
                      ),
                    ],
                  ),
                  Container(
                    width: getProportionateScreenWidth(
                        SizeConfig.screenWidth - getProportionateScreenWidth(150)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5, horizontal: 5),
                          child: Text(userData.email),
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
                                  focusNode: addressFocus,
                                  style: TextStyle(fontSize: 14),
                                  onTap: () => addressController.selection = TextSelection(
                                      baseOffset: 0, extentOffset: addressController.text.length),
                                  onChanged: (value) async {
                                    List<WeMapPlace> places = await searchAPI.getSearchResult(
                                        value, latLng, WeMapGeocoder.Pelias);
                                    setState(() {
                                      wemapAddress = places;
                                    });
                                  },
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(5),
                                child: Text(addressController.text),
                              ),
                        Container(
                          height: SizeConfig.screenHeight - getProportionateScreenHeight(500),
                          child: ListView.builder(
                            itemCount: wemapAddress.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(wemapAddress[index].placeName.toString()),
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                addressFocus.unfocus();
                                addressController.text = wemapAddress[index].placeName.toString();
                                setState(() {
                                  wemapAddress = [];
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
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
