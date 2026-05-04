import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';

class DownloadService {
  // 参拝カード保存
  static Future<File?> saveWorshipCardImage(
      Uint8List imageBytes, String eventCode, String historicSpotId) async {
    try {
      // Get the temporary directory of the device
      final directory = await getApplicationDocumentsDirectory();

      // Create the directory path
      final dirPath =
          '${directory.path}/$eventCode/$historicSpotId/worship_card';
      final dir = Directory(dirPath);

      // Ensure the directory exists
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // Create the file path
      final filePath = '$dirPath/${DateTime.now()}_worship_card.png';

      // Write the image bytes to the file
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      return file;
    } catch (e) {
      logger.e('Error saving image: $e');
      return null;
    }
  }

  // 参拝カード一覧取得
  static Future<List<File>> getWorshipCardImages(
      String eventCode, String historicSpotId) async {
    try {
      logger.i('Retrieving files for historic spot ID: $historicSpotId');
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();
      final historicSpotDirectory = Directory(
          '${directory.path}/$eventCode/$historicSpotId/worship_card');
      if (!await historicSpotDirectory.exists()) {
        logger.i('not exist');
        return [];
      }

      // List all files in the directory
      final files = historicSpotDirectory.listSync().whereType<File>().toList();
      return files;
    } catch (e) {
      logger.e('Error retrieving files: $e');
      return [];
    }
  }

  // 完了カード保存
  static Future<File?> saveCompleteCardImage(
      Uint8List imageBytes, String eventCode) async {
    try {
      // Get the temporary directory of the device
      final directory = await getApplicationDocumentsDirectory();

      // Create the directory path
      final dirPath = '${directory.path}/$eventCode/complete_card';
      final dir = Directory(dirPath);

      // Ensure the directory exists
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // Create the file path
      final filePath = '$dirPath/complete_card.png';

      // Write the image bytes to the file
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      return file;
    } catch (e) {
      logger.e('Error saving image: $e');
      return null;
    }
  }

  // 完了カード取得
  static Future<File?> getCompleteCardImage(String eventCode) async {
    try {
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Create the file path
      final filePath =
          '${directory.path}/$eventCode/complete_card/complete_card.png';

      // Check if the file exists
      final file = File(filePath);
      if (await file.exists()) {
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Retrieves a saved image from the device's local storage using the [fileName].
  static Future<File?> getWorshipCardImage(String historicSpotId) async {
    try {
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Create the file path
      final filePath =
          '${directory.path}/$historicSpotId/${DateTime.now()}_worship_card.png';

      // Check if the file exists
      final file = File(filePath);
      if (await file.exists()) {
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
