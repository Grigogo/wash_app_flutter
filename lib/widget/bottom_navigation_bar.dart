import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vt_app/pages/app_stack/history_page.dart';
import 'package:vt_app/pages/app_stack/home_page.dart';
import 'package:vt_app/models/user.dart';
import 'package:vt_app/pages/app_stack/map_page.dart';
import 'package:vt_app/pages/app_stack/profile_page.dart';
import 'package:vt_app/pages/app_stack/scanner_page.dart';
import 'package:vt_app/utils/const/app_colors.dart'; // Импортируйте ваш файл с цветами

class BottomNavPage extends StatefulWidget {
  final User? userData;

  const BottomNavPage({super.key, required this.userData});

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    // Добавляем страницы в список
    _pages.addAll([
      HomePage(userData: widget.userData), // Главная страница
      MapPage(userData: widget.userData),
      ScannerPage(userData: widget.userData), // Страница профиля
      HistoryPage(userData: widget.userData),
      ProfilePage(userData: widget.userData),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Отображаем текущую страницу
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.getBorderMenuColor(context), // Цвет бордера
              width: 1.0, // Толщина бордера
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.getBgColor(context), // Цвет фона меню
          currentIndex: _currentIndex,
          enableFeedback: true,
          selectedItemColor:
              AppColors.getTextColor(context), // Цвет активных лейблов
          unselectedItemColor:
              AppColors.getMenuIconColor(context), // Цвет неактивных лейблов
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0, // Размер шрифта активного пункта
          unselectedFontSize: 0, // Размер шрифта неактивного пункта
          onTap: (int index) {
            setState(() {
              _currentIndex = index; // Обновляем выбранный пункт меню
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildNavItem(
                0,
                'Автомойки',
                _currentIndex == 0
                    ? 'assets/icons/menu/car-line-active.svg' // Активная иконка
                    : 'assets/icons/menu/car-line.svg',
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem(
                1,
                'На карте',
                _currentIndex == 1 ? Icons.map : Icons.map_outlined,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScannerIcon(), // Замена иконки на круг
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem(
                3,
                'История',
                _currentIndex == 3
                    ? 'assets/icons/menu/history-active.svg' // Активная иконка
                    : 'assets/icons/menu/history.svg',
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem(
                4,
                'Профиль',
                _currentIndex == 4
                    ? 'assets/icons/menu/profile-active.svg' // Активная иконка
                    : 'assets/icons/menu/profile.svg',
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, dynamic icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index; // Обновляем выбранный пункт меню
        });
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          14,
          0,
          defaultTargetPlatform == TargetPlatform.iOS
              ? 0
              : 12, // Разный отступ для iOS и Android
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon is String
                ? _buildSvgIcon(
                    icon,
                    _currentIndex == index
                        ? AppColors.getTextColor(context)
                        : AppColors.getMenuIconColor(context),
                  )
                : Icon(
                    icon,
                    color: _currentIndex == index
                        ? AppColors.getTextColor(context)
                        : AppColors.getMenuIconColor(context),
                  ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: _currentIndex == index
                    ? AppColors.getTextColor(context)
                    : AppColors.getMenuIconColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgIcon(String assetName, Color color) {
    return SvgPicture.asset(
      assetName,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn, // Применяет цвет к изображению
      ),
      width: 24, // Задайте фиксированную ширину
      height: 24, // Задайте фиксированную высоту
    );
  }

  Widget _buildScannerIcon() {
    return Container(
      width: 50, // Ширина круга
      height: 50, // Высота круга
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkPrimary // Цвет фона в темной теме
            : AppColors.lightPrimary, // Цвет фона в светлой теме
        shape: BoxShape.circle, // Круглая форма
      ),
      child: SvgPicture.asset(
        'assets/icons/menu/scan.svg', // Путь к вашему SVG файлу
        colorFilter: ColorFilter.mode(
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBgColor // Цвет иконки в темной теме
              : AppColors.lightBgColor, // Цвет иконки в светлой теме,
          BlendMode.srcIn, // Применяет цвет к изображению
        ),
        width: 24, // Размер SVG
        height: 24,
        fit: BoxFit.scaleDown, // Масштабируем SVG внутри контейнера
        alignment: Alignment.center, // Центрируем иконку
      ),
    );
  }
}
