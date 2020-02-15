import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const CircularImage(
      {Key key, @required this.imagePath, this.width = 70, this.height = 70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/image-placeholder.png",
        image: imagePath,
        height: height,
        width: width,
      ),
    );
  }
}
