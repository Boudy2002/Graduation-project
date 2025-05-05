import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentora_app/core/colors_manager.dart';

class IconCircleContainer extends StatelessWidget {
  const IconCircleContainer({
    super.key,
    required this.iconPath,
    this.isStar = false,
  });

  final String iconPath;
  final bool isStar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: ColorsManager.black,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isStar? Icon(Icons.star_border_sharp, color: ColorsManager.white,)
            :SvgPicture.asset(
          iconPath,
          width: 30,
          height: 30,
          colorFilter: ColorFilter.mode(ColorsManager.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
