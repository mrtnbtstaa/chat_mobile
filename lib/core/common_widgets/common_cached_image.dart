import 'common_avatar.dart';
import '../extensions/context_extension.dart';
import '../extensions/int_extension.dart';
import '../style/app_images.dart';
import '../style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommonCachedImage extends StatelessWidget {
  
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;

  const CommonCachedImage({ 
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius
   });

  @override
  Widget build(BuildContext context){
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return  Container(
          width: width ?? context.width / 6,
          height: height ?? context.height / 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover
            )
          ),
        );
      },
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => CommonAvatar(
        path: AppImages.placeholder,
        radius_: radius ?? AppSizes.size32,
      ),
      fadeInDuration: 3.seconds(),
    );
  }
}