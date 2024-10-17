import 'package:flutter/material.dart';

class MainTopBar extends StatelessWidget {
  final String cityName;
  final String cityIconPath; // Путь к иконке города
  final VoidCallback
      onCityTapped; // Коллбек для перехода на страницу выбора города
  final VoidCallback
      onNotificationTapped; // Коллбек для перехода на страницу оповещений

  const MainTopBar({
    super.key,
    required this.cityName,
    required this.cityIconPath,
    required this.onCityTapped,
    required this.onNotificationTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Скругленные углы
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onCityTapped, // Обработка клика по городу
              child: Row(
                children: [
                  Container(
                    width: 40, // Ширина круга
                    height: 40, // Высота круга
                    decoration: const BoxDecoration(
                      color: Colors.blue, // Цвет фона круга
                      shape: BoxShape.circle, // Круглая форма
                    ),
                    child: Center(
                      child: Image.asset(
                        cityIconPath,
                        width: 24, // Ширина иконки
                        height: 24, // Высота иконки
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Отступ между иконкой и текстом
                  Text(
                    cityName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                      Icons.arrow_drop_down), // Иконка для выпадающего списка
                ],
              ),
            ),
            GestureDetector(
              onTap: onNotificationTapped, // Обработка клика по колокольчику
              child: const Icon(
                Icons.notifications,
                color: Colors.black, // Цвет иконки
                size: 28, // Размер иконки
              ),
            ),
          ],
        ),
      ),
    );
  }
}
