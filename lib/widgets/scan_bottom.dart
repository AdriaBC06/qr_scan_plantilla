import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () {
        print('Botó polsat!');
        String barcodeScanRes = "geo:39.7259555,2.9110725";
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchURL(context, nouScan);
      },
    );
  }
}
