import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CustomCircularAvatar extends StatelessWidget {
  final String imageUrl;
  final Color? placeholderColor; // Default to AppColors.cC2C2C2
  final double size; // Diameter (default 40.r)

  const CustomCircularAvatar({
    super.key,
    required this.imageUrl,
    this.placeholderColor = const Color(0xFFC2C2C2), // AppColors.cC2C2C2 equivalent
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: CachedNetworkImage(
          imageUrl: imageUrl.isNotEmpty ? imageUrl : '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: placeholderColor,
            child:  Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: placeholderColor,
            child:  Icon(
              Icons.person_outline,
              color: Colors.grey,
              size: 20,
            ),
          ),
       
        ),
      ),
    );
  }
}

