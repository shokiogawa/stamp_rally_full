import 'package:supabase_flutter/supabase_flutter.dart';

class StorageUseCase {
  const StorageUseCase(this.client);

  final SupabaseClient client;

  Future<String> getFileUrl(String path) async {
    final fileUrl =
        client.storage.from('shrine_worship_bucket').getPublicUrl(path);
    return fileUrl;
  }
}
