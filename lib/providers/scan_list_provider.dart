import 'package:flutter/widgets.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = "http";

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      scans.add(nouScan);
      notifyListeners();
    }

    return nouScan;
  }

  Future<void> carregaScans() async {
    final scansDB = await DBProvider.db.getAllScans();
    scans = [...scansDB];
    notifyListeners();
  }

  // Metodes demanats al video 5
  Future<void> carregaScansPerTipus(String tipus) async {
    final scansDB = await DBProvider.db.getScansByType(tipus);
    tipusSeleccionat = tipus;
    scans = [...scansDB];
    notifyListeners();
  }

  Future<void> esborraTots() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  Future<void> esborraPerId(int id) async {
    await DBProvider.db.deleteScan(id);
    scans.removeWhere((scan) => scan.id == id);
    notifyListeners();
  }
}
