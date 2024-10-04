import 'package:flutter/material.dart';
import 'package:vt_app/utils/const/app_colors.dart';

class OTPInputField extends StatefulWidget {
  final int length; // Длина кода OTP
  final ValueChanged<String> onChanged; // Для получения итогового кода

  OTPInputField({
    Key? key,
    required this.length,
    required this.onChanged,
  }) : super(key: key);

  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  late TextEditingController
      _controller; // Единственный контроллер для всего OTP
  late FocusNode _focusNode; // Единственный FocusNode для всего OTP

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_onOtpChange);

    // Установка фокуса на текстовое поле сразу после загрузки страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onOtpChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onOtpChange() {
    String otp = _controller.text;
    if (otp.length > widget.length) {
      otp = otp.substring(0, widget.length); // Ограничиваем длину OTP
      _controller.value = TextEditingValue(
        text: otp,
        selection: TextSelection.collapsed(offset: otp.length),
      );
    }
    widget.onChanged(otp); // Возвращаем введенный код
    setState(() {}); // Обновляем UI
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Offstage(
          offstage: true, // Скрываем текстовое поле13
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            maxLength: widget.length,
            decoration: const InputDecoration(
              counterText: "", // Убираем счетчик символов
              border: InputBorder.none,
            ),
            style: const TextStyle(
                color: Colors.transparent), // Делаем текст невидимым
            onTap: () {
              // Запретить пользователю снимать фокус, но только при попытке нажатия
              FocusScope.of(context).requestFocus(_focusNode);
            },
          ),
        ),
        // Скрытое текстовое поле для ввода OTP

        // Отображение ячеек OTP
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.length, (index) {
            return _buildOTPBox(context, index);
          }),
        ),
      ],
    );
  }

  Widget _buildOTPBox(BuildContext context, int index) {
    String currentChar = index < _controller.text.length
        ? _controller.text[index]
        : ''; // Текущий символ в ячейке

    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: AppColors.getBlack1Color(context),
        borderRadius: BorderRadius.circular(12.0),
      ),
      alignment: Alignment.center,
      child: Text(
        currentChar,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
