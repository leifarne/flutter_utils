import 'dart:typed_data';

import 'package:http/http.dart' as http;

/// FileService
///
abstract class FileService {
  Future<String> load(String fileName);
  Future<Uint8List> loadAsBytes({String? fileName});
  Future<String?> getDownloadUrl(String? fileName) => Future.value(null);

  String getDir(String fileName) {
    Uri uri = Uri(path: fileName);
    final pathSegments = uri.pathSegments;
    pathSegments.removeLast();
    return pathSegments.join('/');
  }

  Uri getFullUri(String? part);
}

/// HttpFileService is a concrete implementation of FileService.
///
class HttpFileService extends FileService {
  static const scheme = 'https';
  static const host = 'localhost';

  // This is where we find the markdown files on Google Storage.
  // https://storage.googleapis.com/rokrust-fs2.appspot.com/sky4/frontpage
  //
  // String get imageDir => '$scheme://$host/$bucket/$dir/';
  //
  final Uri _uri;

  HttpFileService(this._uri);

  @override
  Future<String> load(String fileName) async {
    final fullUri = getFullUri(fileName);
    final response = await http.get(fullUri);

    if (response.statusCode != 200) throw Exception('[${response.statusCode}] $fileName does not exist.');

    return response.body;
  }

  @override
  Uri getFullUri(String? part) {
    return _uri.resolve(part ?? '');
  }

  @override
  Future<Uint8List> loadAsBytes({String? fileName}) {
    // TODO: implement loadAsBytes
    throw UnimplementedError();
  }
}

/// Markdown services
///
abstract class MarkdownService {
  final FileService fileService;

  MarkdownService(this.fileService);

  Future<void> init();
  Future<String> load(String fileName);
  String getImageDir();
  Future<Uint8List> loadAsBytes(String fileName);
}
