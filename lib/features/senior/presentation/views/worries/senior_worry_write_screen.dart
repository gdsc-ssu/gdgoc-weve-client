import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SeniorWorryWriteScreen extends ConsumerStatefulWidget {
  const SeniorWorryWriteScreen({super.key});

  @override
  ConsumerState<SeniorWorryWriteScreen> createState() =>
      _SeniorWorryWriteScreenState();
}

class _SeniorWorryWriteScreenState
    extends ConsumerState<SeniorWorryWriteScreen> {
  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final headerViewModel = ref.read(headerProvider.notifier);
      headerViewModel.setHeader(HeaderType.backLogo2, title: "");

      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      _initializeControllerFuture = _cameraController!.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized &&
        !_cameraController!.value.isTakingPicture) {
      try {
        final image = await _cameraController!.takePicture();
        setState(() {
          _capturedImage = image;
        });
      } catch (e) {
        debugPrint("사진 촬영 오류: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(),
      backgroundColor: WeveColor.bg.bg1,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '청년의 고민을 해결해주세요',
                  style: WeveText.header2(color: WeveColor.gray.gray1),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: _capturedImage != null
                    ? Image.file(
                        File(_capturedImage!.path),
                        fit: BoxFit.cover,
                      )
                    : (_cameraController == null)
                        ? const Center(child: CircularProgressIndicator())
                        : FutureBuilder(
                            future: _initializeControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return CameraPreview(_cameraController!);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: WeveColor.main.orange2,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: WeveColor.main.orange1,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child:
                        CustomIcons.getIcon(CustomIcons.seniorCamera, size: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
