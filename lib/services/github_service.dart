import 'dart:typed_data';

import 'package:github/github.dart';

import 'file_service.dart';

class GithubFileService extends FileService {
  final String user;
  final String repo;
  final String token;
  late GitHub github;
  late RepositorySlug repositorySlug;

  GithubFileService(this.user, this.repo, this.token) {
    var authentication = Authentication.withToken(token);
    github = GitHub(auth: authentication);
    repositorySlug = RepositorySlug(user, repo);
  }

  /// curl https://api.github.com/repos/leifarne/qrcode/contents/lib/main.dart
  ///
  @override
  Future<String> load(String fileName) async {
    final contents = await github.repositories.getContents(repositorySlug, fileName);
    return contents.file!.text;
  }

  @override
  Uri getFullUri(String? fileName) {
    // TODO: implement getFullUri
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> loadAsBytes({String? fileName}) {
    // TODO: implement loadAsBytes
    throw UnimplementedError();
  }
}
