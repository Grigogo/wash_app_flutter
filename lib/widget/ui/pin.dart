import 'package:flutter/material.dart';
import 'package:vt_app/utils/const/app_colors.dart';

class PinCodeInput extends StatefulWidget {
  final int pinLength;
  final Function(String) onChanged; // Callback для передачи PIN-кода

  const PinCodeInput({
    Key? key,
    this.pinLength = 4,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  List<String> _pin = []; // Список введенных цифр PIN-кода

  // Метод для обработки нажатий на клавиши
  void _onKeyboardTap(String value) {
    if (_pin.length < widget.pinLength) {
      setState(() {
        _pin.add(value); // Добавляем новую цифру в PIN-код
        widget.onChanged(_pin.join()); // Передаём PIN-код через callback
      });
    }
  }

  // Метод для обработки нажатия кнопки удаления
  void _onDeleteTap() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast(); // Удаляем последнюю цифру
        widget.onChanged(_pin.join()); // Передаём обновлённый PIN-код
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Получаем цвет текста один раз
    Color textColor = AppColors.getTextColor(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        // Отображаем кружочки или цифры
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.pinLength,
            (index) => Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 40, // Фиксированная ширина
                height: 40, // Фиксированная высота
                child: Center(
                  child: _pin.length > index
                      ? Text(
                          _pin[
                              index], // Отображаем введённую цифру вместо кружка
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: textColor), // Используем переменную
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                          ),
                        ), // Пустой кружок, если цифра еще не введена
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Рисуем цифровую клавиатуру
        _buildKeyboard(textColor),
        const SizedBox(height: 20),
      ],
    );
  }

  // Метод для рисования клавиатуры
  Widget _buildKeyboard(Color textColor) {
    return Column(
      children: [
        // Первые 3 строки цифр (1-9)
        for (int i = 1; i <= 9; i += 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildKeyboardButton(i.toString(), textColor),
              _buildKeyboardButton((i + 1).toString(), textColor),
              _buildKeyboardButton((i + 2).toString(), textColor),
            ],
          ),
        // Последняя строка (0) и кнопка "Стереть"
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 86),
            _buildKeyboardButton('0', textColor),
            _buildDeleteButton(textColor)
          ],
        ),
      ],
    );
  }

  // Метод для рисования кнопки "Стереть"
  Widget _buildDeleteButton(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: _onDeleteTap, // Обработка нажатия на кнопку "Стереть"
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8.0), // Закругление углов
          ),
          alignment: Alignment.center, // Центрирование содержимого
          child: const Icon(
            Icons.backspace, // Иконка для удаления
            color: Colors.white,
            size: 30, // Размер иконки
          ),
        ),
      ),
    );
  }

  // Метод для рисования кнопок клавиатуры
  Widget _buildKeyboardButton(String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => _onKeyboardTap(value), // Обработка нажатия на кнопку
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8.0), // Закругление углов
          ),
          alignment: Alignment.center, // Центрирование содержимого
          child: Text(
            value,
            style: TextStyle(
                fontSize: 24, color: textColor), // Используем переменную
            textAlign: TextAlign.center, // Центрирование текста
          ),
        ),
      ),
    );
  }
}
