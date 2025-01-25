import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockImageProvider extends Mock implements ImageProvider {
  @override
  Future<Object> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<Object>(Object());
  }

  @override
  Future<Codec> load(Object key, ImageDecoderCallback decode) {
    // Retorna um Codec falso que já está pronto
    return instantiateImageCodec(Uint8List(0));
  }
}
