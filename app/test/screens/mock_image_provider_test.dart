import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';

class MockImageProvider extends ImageProvider<MockImageProvider> {
  @override
  Future<MockImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MockImageProvider>(this);
  }

  @override
  ImageStream resolve(ImageConfiguration configuration) {
    final ImageStream stream = ImageStream();

    // Cria um Future que resolve para um ImageInfo com um ui.Image fake
    final Future<ImageInfo> imageFuture = Future.value(ImageInfo(
      image: _createFakeImage(),
      scale: 1.0,
    ));

    // Passa o Future para o OneFrameImageStreamCompleter
    stream.setCompleter(OneFrameImageStreamCompleter(imageFuture));

    return stream;
  }

  // Cria um ui.Image fake
  ui.Image _createFakeImage() {
    final FakeImage image = FakeImage();
    return image;
  }
}

// Implementação de um ui.Image fake com todos os métodos obrigatórios
class FakeImage implements ui.Image {
  @override
  int get width => 100;

  @override
  int get height => 100;

  @override
  void dispose() {
    // No-op
  }

  @override
  Future<ByteData?> toByteData(
      {ui.ImageByteFormat format = ui.ImageByteFormat.rawRgba}) async {
    return ByteData(0); // Retorna um ByteData vazio
  }

  @override
  ui.Image clone() {
    return this; // Retorna a mesma instância, pois é um mock
  }

  @override
  bool isCloneOf(ui.Image other) {
    return this == other; // Compara instâncias
  }

  @override
  List<StackTrace>? debugGetOpenHandleStackTraces() {
    return null; // Retorna null, pois não é necessário para testes
  }

  @override
  ui.ColorSpace get colorSpace =>
      ui.ColorSpace.sRGB; // Retorna um valor non-null padrão

  @override
  bool get debugDisposed =>
      false; // Retorna false como valor padrão para testes

  // Adiciona o getter image
  @override
  ui.Image get image => this;
}
