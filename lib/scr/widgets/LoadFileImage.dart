import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Widget loadImageStorage(BuildContext context, String image ) => FutureBuilder(
  future: _getImage(context, image),
  builder: (context, snapshot) {
    if (snapshot.connectionState ==
        ConnectionState.done)
      return Container(
        height:
        MediaQuery
            .of(context)
            .size
            .height / 1.25,
        width:
        MediaQuery
            .of(context)
            .size
            .width / 1.25,
        child: snapshot.data,
      );

    if (snapshot.connectionState ==
        ConnectionState.waiting)
      return Container(
          height: MediaQuery
              .of(context)
              .size
              .height /
              1.25,
          width: MediaQuery
              .of(context)
              .size
              .width /
              1.25,
          child: CircularProgressIndicator());

    return Container();
  },
);

Future<Widget> _getImage(BuildContext context, String image) async {
  Image m;
  await FireStorageServiceImage.loadImage(context, image).then((downloadUrl) {
    m = Image.network(
      downloadUrl.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return m;
}

class FireStorageServiceImage extends ChangeNotifier {
  FireStorageServiceImage();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}