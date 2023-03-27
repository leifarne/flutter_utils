library flutter_utils;

import 'package:flutter/material.dart';

export 'services/file_service.dart';
export 'services/github_service.dart';

Widget futureBuilderWithError<T>(Future<T> future, Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) builder) {
  return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return builder(context, snapshot);
        } else if (snapshot.hasError) {
          debugPrint('In snapshot.error');
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Working...', style: Theme.of(context).textTheme.bodyText1));
        } else {
          return const Center(child: Text('Something else...'));
        }
      });
}
