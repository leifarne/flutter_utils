import 'dart:typed_data';

import 'package:github/github.dart';

import 'file_service.dart';

class GithubFileService extends FileService {
  final String user;
  final String repo;
  late GitHub github;
  late RepositorySlug repositorySlug;

  GithubFileService(this.user, this.repo) {
    // github personal token: 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. Expires on Wed, Apr 5 2023.
    // var authentication = Authentication.basic('leif.arne.rones@gmail.com', 'Traktor20!');
    var authentication = Authentication.withToken('4b47866c46ac2af6bf64631f807bdeb58144c85b');
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
