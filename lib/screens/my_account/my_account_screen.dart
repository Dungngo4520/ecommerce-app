import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/my_account/info_field.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/services/storage.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:wemapgl/wemapgl.dart';

class MyAccountScreen extends StatefulWidget {
  static final String route = 'myaccoount';

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool isEdit = false;

  // List<WeMapPlace> wemapAddress = [];
  // WeMapSearchAPI searchAPI = WeMapSearchAPI();
  // LatLng latLng = new LatLng(20.037, 105.7876);

  TextEditingController displayNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode addressFocus = FocusNode();

  late final userData;
  late final firestore;
  late final storage;
  late SearchEngine searchEngine;
  List<Place> placeLists = [];
  // HereMapController hereMapController;

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
    userData = Provider.of<UserData>(context, listen: true);
    firestore = Provider.of<DatabaseMethods>(context, listen: false);
    storage = Provider.of<StorageMethods>(context, listen: false);
    displayNameController.text = userData.name;
    phoneController.text = userData.phone;
    addressController.text = userData.address;
    searchEngine = SearchEngine();
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
                  // wemapAddress = [];
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
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
                                    fit: BoxFit.cover,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      isEdit
                          ? Container(
                              width: SizeConfig.screenWidth * 0.6,
                              child: AutoSizeTextField(
                                controller: displayNameController,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: getProportionateScreenWidth(1)),
                                  isDense: true,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: cSecondaryColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: cPrimaryColor)),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                displayNameController.text,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      Spacer(),
                    ],
                  )
                ],
              ),
              SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoField(
                        isEdit: isEdit,
                        title: 'Email',
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5, horizontal: 5),
                        child: Text(
                          userData.email,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoField(
                        isEdit: isEdit,
                        title: 'Phone',
                      ),
                      Row(
                        children: [
                          isEdit
                              ? Container(
                                  width: SizeConfig.screenWidth * 0.4,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: AutoSizeTextField(
                                    enableSuggestions: true,
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: getProportionateScreenWidth(1)),
                                      isDense: true,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: cSecondaryColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: cPrimaryColor)),
                                    ),
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    phoneController.text,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoField(
                        isEdit: isEdit,
                        title: 'Address',
                      ),
                      isEdit
                          ? Container(
                              width: SizeConfig.screenWidth * 0.8,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: AutoSizeTextField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: getProportionateScreenWidth(1)),
                                  isDense: true,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: cSecondaryColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: cPrimaryColor)),
                                ),
                                focusNode: addressFocus,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                scrollController: scrollController,
                                onTap: () {
                                  scrollController.animateTo(
                                    0.0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOutQuart,
                                  );
                                },
                                onChanged: (value) {
                                  AddressQuery query = AddressQuery.withAreaCenter(
                                      value, GeoCoordinates(21.028511, 105.804817));

                                  searchEngine.searchByAddress(
                                    query,
                                    SearchOptions(LanguageCode.viVn, 20),
                                    (SearchError? searchError, List<Place>? list) {
                                      if (searchError != null) {
                                        setState(() {
                                          placeLists = [];
                                        });
                                      }
                                      setState(() {
                                        placeLists = list ?? [];
                                      });
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                addressController.text,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  ),
                  Container(
                    height: SizeConfig.screenHeight - getProportionateScreenHeight(500),
                    child: ListView.separated(
                      itemCount: placeLists.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(placeLists[index].address.addressText),
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          addressFocus.unfocus();
                          addressController.text = placeLists[index].address.addressText;
                          setState(() {
                            placeLists = [];
                          });
                        },
                      ),
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
