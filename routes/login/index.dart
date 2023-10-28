import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  try {
    final body = await request.json() as Map<String, dynamic>;

    final id = body['id'];
    if (id == null || id is! int) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'id should be a number'},
      );
    }
    return Response.json(
      body: {'user_id': id},
    );
  } on FormatException {
    return Response.json(body: {'error': 'Bad Format of body.'});
  } catch (e) {
    return Response.json(body: {'error': e.toString()});
  }
}
