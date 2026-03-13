import 'package:chat/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonImage extends Image{

  const CommonImage({
    super.key,
    required super.image,
    this.width,
    this.height,
    this.fit
  }) : super(
    width: width ?? AppSizes.size4,
    height: height ?? AppSizes.size4,
    fit: fit ?? BoxFit.cover
  );

  final double? width;
  final double? height;
  final BoxFit? fit;  
}