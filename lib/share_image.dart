import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: share1(),
    ));
}
class share1 extends StatefulWidget {
  const share1({super.key});

  @override
  State<share1> createState() => _share1State();
}

class _share1State extends State<share1> {

  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  //permission
  get()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied)
    {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SHARE IMAGE"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          Center(
              child: WidgetsToImage(
                controller: controller,
                child: Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  color: Colors.purple.shade200,
                  child: Text("Hello"),
                ),
              )
          ),
          Center(
            child: ElevatedButton(onPressed: () async {
              final bytes = await controller.capture();

              var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/photo";
              print(path);

              Directory dir=Directory(path);
              if(! await dir.exists())
                {
                  dir.create();
                }

              int random=Random().nextInt(100);
              String imag_name="${random}.png";
              File f = File("${dir.path}/${imag_name}");
              await f.writeAsBytes(bytes!);

              Share.shareXFiles([XFile('${f.path}')], text: 'Great picture');

            }, child: Text("SUBMIT")),
          )
        ],
      )
    );
  }
}
