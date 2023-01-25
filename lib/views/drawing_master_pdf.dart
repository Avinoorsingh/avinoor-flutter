import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({Key? key, this.path}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    if(mounted){
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    }
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
        const SizedBox(height: 20,),
        SfPdfViewer.network(
        '${widget.path}',
        key: _pdfViewerKey,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          EasyLoading.dismiss();
        },
      ),
        ],
      ),
    );
  }
}