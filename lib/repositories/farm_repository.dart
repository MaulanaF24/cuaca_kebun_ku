import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:cuaca_kebun_ku/app_config.dart';
import 'package:flutter/foundation.dart';

class FarmRepository {
  final Databases db = Databases(Client().setEndpoint("https://sgp.cloud.appwrite.io/v1").setProject(AppConfig.projectId));

  Future<List<Document>> fetchListFarm() async {
    final listNotes = await getListFarm();
    return listNotes;
  }

  Future<List<Document>> getListFarm() async {
    try {
      final response = await db.listDocuments(
        databaseId: AppConfig.databaseId,
        collectionId: AppConfig.tableFarmId,
      );
      return response.documents;
    } on AppwriteException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return [];
    }
  }

  Future<Document> createFarm(String namaKebun, String alamat, double latitude, double longitude) async {
    try {
      final newNotes = await db.createDocument(
        databaseId: AppConfig.databaseId,
        collectionId: AppConfig.tableFarmId,
        documentId: ID.unique(),
        data: {
          'nama_kebun': namaKebun,
          'alamat': alamat,
          'latitude': latitude,
          'longitude' : longitude,
        },
      );
      return newNotes;
    } on AppwriteException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  Future<bool> deleteFarm(String taskId) async {
    try {
      await db.deleteDocument(
        databaseId: AppConfig.databaseId,
        collectionId: AppConfig.tableFarmId,
        documentId: taskId,
      );
      return true;
    } on AppwriteException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return false;
    }
  }

  Future<Document> updateFarm(String id, bool completed) async {
    try {
      final updatedNotes = await db.updateDocument(
          databaseId: AppConfig.databaseId,
          collectionId: AppConfig.tableFarmId,
          documentId: id,
          data: {
            'completed': completed,
          });

      return updatedNotes;
    } on AppwriteException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }
}