import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/*
source : https://flutter.dev/docs/cookbook/plugins/picture-using-camera
*/
class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  //untuk mengatasi camera, maka gunakan controller package:camera/camera.dart
  CameraController _controller;

  List<CameraDescription> cameras = [];

  //buat tampung hasil jepret camera
  XFile imageFile;

  //PERLU DISPOSE UNTUK TUTUP CAMERA CONTROLLER KETIKA PAGE DITUTUP
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // https://pub.dev/packages/camera/example
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_controller == null || !_controller.value.isInitialized) {
      return;
    }
    //jika aplikasi tidak aktif maka controller di dispose
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      //jika aplikasi kembali aktif maka re-inisialisasi
      if (_controller != null) {
        _controller = CameraController(cameras[0], ResolutionPreset.medium);
      }
    }
  }

  //fungsi inisialisasi kamera
  Future<void> initializeCamera() async {
    //pastikan widget di inisial
    WidgetsFlutterBinding.ensureInitialized();

    //dapatkan daftar kamera yg ada di smartphone
    cameras = await availableCameras();

    //pasangkan ke controller, dan pasangkan ke camera menurut index (belakang=0, depan=1 )
    _controller = CameraController(cameras[0], ResolutionPreset.medium);

    //eksekusi inisialisasi camera
    await _controller.initialize();
  }

  //fungsi untuk ambil photo, returnnya adalah File
  Future<File> takePicture() async {
    //ambil root direktori nya untuk simpan sementara photo hasil shoot
    //getTemporaryDirectory adalah tempat tampungan sementara, tidak akan dibackup/disimpan
    Directory root = await getTemporaryDirectory();

    //set folder temporer nya
    String directoryPath = '${root.path}/Guided_Camera';

    //eksekusi buat direktory dan rekursif artinya sampai dalam nya
    await Directory(directoryPath).create(recursive: true);

    //buat file path nya untuk penamaan file hasil jepret photo
    String filePath = '${directoryPath}/${DateTime.now()}.jpg';

    //jika belum inisialisasi maka katakan error select camera
    if (!_controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    //jika kagak jadi/sedang ambil photo maka kembalikan null aje
    if (_controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      imageFile = await _controller.takePicture();
      //merubah XFile menjadi File
      return File(imageFile.path);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  /* void onTakePictureButtonPressed() {
    takePicture().then((XFile file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) showInSnackBar('Picture saved to ${file.path}');
      }
    });
  }
 */
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (_, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.width / controller.value.aspectRatio,
                            // If the Future is complete, display the preview.
                            child: CameraPreview(_controller),
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.only(top: 50),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (!_controller.value.isTakingPicture) {
                                  File result = await takePicture();
                                  Navigator.pop(context, result);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        /*  width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width /
                            controller.value.aspectRatio, */
                        child: Image.asset('assets/layer_photo.png',
                            fit: BoxFit.cover),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
