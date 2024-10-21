import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vt_app/utils/const/app_colors.dart';

class TopBarWidget extends StatelessWidget {
  final Function() onCityTap;
  final Function() onNotificationTap;

  const TopBarWidget({
    Key? key,
    required this.onCityTap,
    required this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onCityTap,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.getIconBgColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/other/location.svg',
                      colorFilter: ColorFilter.mode(
                          AppColors.getTextColor(context), BlendMode.srcIn),
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Text('Киров',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Icon(Icons.expand_more)
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onNotificationTap,
            child: SvgPicture.asset(
              'assets/icons/other/bell.svg',
              colorFilter: ColorFilter.mode(
                  AppColors.getTextColor(context), BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
    );
  }
}
