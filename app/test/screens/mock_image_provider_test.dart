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
    // Simula o carregamento de uma imagem
    return instantiateImageCodec(Uint8List.fromList([
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // Cabeçalho PNG
    ]));
  }
}
