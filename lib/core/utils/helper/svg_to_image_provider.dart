import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgToImageProvider extends ImageProvider<ProviderModel> {
  /// SVG Path
  final String path;

  /// Height of the SVG Viewbox
  final double? height;

  /// Width of the SVG Viewbox
  final double? width;

  /// Color to apply to the SVG
  final Color? color;

  /// Gradient to apply to the SVG
  final LinearGradient? gradient;

  /// Scale of the SVG
  final int? scale;

  SvgToImageProvider(
    this.path, {
    this.height,
    this.width,
    this.color,
    this.gradient,
    this.scale,
  });
  static bool _isLocalImageCheck(String path) {
    if (path.trim().toLowerCase().contains("https://") ||
        path.trim().toLowerCase().contains("https://")) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<ProviderModel> obtainKey(ImageConfiguration configuration) {
    double widthK = (width ?? 100) * (scale ?? 1);
    double heightK = (height ?? 100) * (scale ?? 1);
    return SynchronousFuture<ProviderModel>(
      ProviderModel(
        path: path,
        size: Size(widthK, heightK),
        color: color,
        gradient: gradient,
      ),
    );
  }

  @override
  ImageStreamCompleter loadImage(
      ProviderModel key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(_loadImage(key));
  }

  Future<ImageInfo> _loadImage(ProviderModel key) async {
    String data = await _getSvgString(key.path);

    final SvgStringLoader svgStringLoader = SvgStringLoader(data);
    final PictureInfo pictureInfo = await vg.loadPicture(svgStringLoader, null);

    final ui.Picture picture = pictureInfo.picture;
    ui.PictureRecorder recorder = ui.PictureRecorder();
    ui.Canvas canvas = Canvas(recorder,
        Rect.fromPoints(Offset.zero, Offset(key.size.width, key.size.height)));
    canvas.scale(key.size.width / pictureInfo.size.width,
        key.size.height / pictureInfo.size.height);
    canvas.drawPicture(picture);
    final ui.Image colorlessImage = await recorder
        .endRecording()
        .toImage(key.size.width.ceil(), key.size.height.ceil());
    pictureInfo.picture.dispose();
    ui.Image imgByteData = colorlessImage;

    if (key.color == null && key.gradient == null) {
      return ImageInfo(image: colorlessImage);
    }
    recorder = ui.PictureRecorder();
    canvas = Canvas(recorder,
        Rect.fromPoints(Offset.zero, Offset(key.size.width, key.size.height)));
    Paint paint = Paint();

    Paint paintGradient = Paint();

    if (key.gradient != null) {
      paintGradient.blendMode = BlendMode.srcATop;
      paintGradient.shader = key.gradient!
          .createShader(Rect.fromLTWH(0, 0, key.size.width, key.size.height));
    } else if (key.color != null) {
      paint.colorFilter = ColorFilter.mode(key.color!, BlendMode.srcIn);
    }

    ui.Size inputSize =
        ui.Size(imgByteData.width.toDouble(), imgByteData.height.toDouble());
    final FittedSizes fittedSizes =
        applyBoxFit(BoxFit.contain, inputSize, inputSize);
    final ui.Size sourceSize = fittedSizes.source;
    final Rect sourceRect =
        Alignment.center.inscribe(sourceSize, Offset.zero & inputSize);
    Rect rect = Rect.fromPoints(const Offset(0.0, 0.0),
        Offset(imgByteData.width.toDouble(), imgByteData.height.toDouble()));

    canvas.drawImageRect(imgByteData, sourceRect, rect, paint);
    if (key.gradient != null) {
      canvas.drawRect(rect, paintGradient);
    }

    final ui.Image image = await recorder
        .endRecording()
        .toImage(key.size.width.ceil(), key.size.height.ceil());

    return ImageInfo(image: image);
  }

  static Future<String> _getSvgString(String path) async {
    bool isLocal = _isLocalImageCheck(path);
    if (isLocal) {
      return await rootBundle.loadString(path);
    } else {
      Dio dio = Dio();
      final response = await dio.get<String>(path);
      final data = response.data;
      return data!;
    }
  }
}

class ProviderModel {
  final String path;
  final Size size;
  final Color? color;
  final LinearGradient? gradient;

  ProviderModel({
    required this.path,
    required this.size,
    required this.color,
    required this.gradient,
  });

  @override
  String toString() {
    return 'ProviderModel(path: $path, size: $size, color: $color, gradient: $gradient)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProviderModel &&
        other.path == path &&
        other.size == size &&
        other.color == color &&
        other.gradient == gradient;
  }

  @override
  int get hashCode {
    return path.hashCode ^ size.hashCode ^ color.hashCode ^ gradient.hashCode;
  }

  ProviderModel copyWith({
    String? path,
    Size? size,
    Color? color,
    LinearGradient? gradient,
  }) {
    return ProviderModel(
      path: path ?? this.path,
      size: size ?? this.size,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
    );
  }
}
