import 'package:appwrite/models.dart';

class MaintenanceSchedule {
  final String id;
  final String kebunId;
  final String jenisPemeliharaan;
  final String luasLahan;
  final String jenisPupuk;
  final String tanggalPemeliharaan;
  final String catatan;
  final String kegiatan;

  MaintenanceSchedule(
      {required this.id,
      required this.kebunId,
      required this.jenisPemeliharaan,
      required this.luasLahan,
      required this.jenisPupuk,
      required this.tanggalPemeliharaan,
      required this.catatan,
      required this.kegiatan});

  static MaintenanceSchedule toModel(Document document) => MaintenanceSchedule(
      id: document.$id,
      kebunId: document.data['kebunId'],
      jenisPemeliharaan: document.data['jenisPemeliharaan'],
      luasLahan: document.data['luasLahan'],
      jenisPupuk: document.data['jenisPupuk'],
      tanggalPemeliharaan: document.data['tanggal_pemeliharaan'],
      catatan: document.data['catatan'],
      kegiatan: document.data['kegiatan']);
}
