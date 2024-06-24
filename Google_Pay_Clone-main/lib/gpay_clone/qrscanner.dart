
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scan_result_page.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  MobileScannerController cameraController = MobileScannerController();
  final ValueNotifier<bool> torchState = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: torchState,
              builder: (context, state, child) {
                return Icon(
                  state ? Icons.flashlight_on_rounded : Icons.flashlight_off_rounded,
                  color: state ? Colors.white : Colors.white,
                );
              },
            ),
            iconSize: 32.0,
            onPressed: () {
              cameraController.toggleTorch();
              torchState.value = !torchState.value;
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {
              // Implement upload from gallery functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined, color: Colors.white),
            onPressed: () {
              // Implement upload from gallery functionality
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final String code = barcode.rawValue ?? "Unknown";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanResultPage(scannedData: code),
                  ),
                );
                break;
              }
            },
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: DarkOverlayPainter(),
            ),
          ),
          Center(
            child: CustomPaint(
              size: const Size(250, 250),
              painter: QRCodeBorderPainter(),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement upload from gallery functionality
                },
                icon: const Icon(
                    Icons.photo_library,
                  color: Colors.black,

                ),
                label: const Text(
                    'Upload from gallery',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.7),
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Scan any QR code to pay',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Google Pay • PhonePe • PayTM • UPI',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DarkOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Rect hole = Rect.fromLTWH((size.width - 240) / 2, (size.height - 240) / 2, 240, 240);

    final Path path = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()..addRRect(RRect.fromRectAndRadius(hole, const Radius.circular(20))),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class QRCodeBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    const double cornerRadius = 20.0;
    const double cornerLength = 50.0;

    // Colors for each corner
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
    ];

    // Paths for each corner
    final paths = [
      Path()
        ..moveTo(0, cornerRadius)
        ..arcToPoint(const Offset(cornerRadius, 0), radius: const Radius.circular(cornerRadius))
        ..lineTo(cornerLength, 0)
        ..moveTo(0, cornerRadius)
        ..lineTo(0, cornerLength),
      Path()
        ..moveTo(size.width, cornerRadius)
        ..arcToPoint(Offset(size.width - cornerRadius, 0), radius: const Radius.circular(cornerRadius), clockwise: false)
        ..lineTo(size.width - cornerLength, 0)
        ..moveTo(size.width, cornerRadius)
        ..lineTo(size.width, cornerLength),
      Path()
        ..moveTo(size.width, size.height - cornerRadius)
        ..arcToPoint(Offset(size.width - cornerRadius, size.height), radius: const Radius.circular(cornerRadius))
        ..lineTo(size.width - cornerLength, size.height)
        ..moveTo(size.width, size.height - cornerRadius)
        ..lineTo(size.width, size.height - cornerLength),
      Path()
        ..moveTo(0, size.height - cornerRadius)
        ..arcToPoint(Offset(cornerRadius, size.height), radius: const Radius.circular(cornerRadius), clockwise: false)
        ..lineTo(cornerLength, size.height)
        ..moveTo(0, size.height - cornerRadius)
        ..lineTo(0, size.height - cornerLength),
    ];
    for (int i = 0; i < paths.length; i++) {
      paint.color = colors[i];
      canvas.drawPath(paths[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
