import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:cuaca_kebun_ku/app_config.dart';
import 'package:cuaca_kebun_ku/models/maintenance_schedule.dart';

class ScheduleRepository {
  final Databases db = Databases(Client()
      .setEndpoint("https://sgp.cloud.appwrite.io/v1")
      .setProject(AppConfig.projectId));

  Future<List<Document>> getListSchedule(String kebunId) async {
    try {
      final response = await db.listDocuments(
          databaseId: AppConfig.databaseId,
          collectionId: AppConfig.tableJadwalId,
          queries: [
            Query.equal('kebunId', kebunId)
          ]);
      return response.documents;
    } on AppwriteException catch (e) {
      e.toString();
      return [];
    }
  }

  Future<Document> createSchedule(
      String kebunId, MaintenanceSchedule data) async {
    try {
      final newNotes = await db.createDocument(
        databaseId: AppConfig.databaseId,
        collectionId: AppConfig.tableJadwalId,
        documentId: ID.unique(),
        data: {
          'kebunId': kebunId,
          'jenisPemeliharaan': data.jenisPemeliharaan,
          'luasLahan': data.luasLahan,
          'jenisPupuk': data.jenisPupuk,
          'tanggal_pemeliharaan': data.tanggalPemeliharaan,
          'catatan': data.catatan,
          'kegiatan': data.kegiatan,
        },
      );
      return newNotes;
    } on AppwriteException catch (e) {
      e.toString();
      rethrow;
    }
  }

  Future<bool> deleteSchedule(String id) async {
    try {
      await db.deleteDocument(
        databaseId: AppConfig.databaseId,
        collectionId: AppConfig.tableJadwalId,
        documentId: id,
      );
      return true;
    } on AppwriteException catch (e) {
      e.toString();
      return false;
    }
  }
}
