import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  if (arguments.length != 3) {
    print('Должны быть введены три параметра!');
    print('Формат ввода: USD RUB 120');
    return;
  }

  final fromCurrency = arguments[0];
  final toCurrency = arguments[1];
  if (double.tryParse(arguments[2]) == null) {
    print('Третий аргумент должен быть число!');
    return;
  }
  final amount = double.parse(arguments[2]);

  print(
    'Загрузка...Конвертируем из $fromCurrency в $toCurrency сумма: $amount',
  );

  final response = await http.get(
    Uri(
      host: 'api.exchangerate.host',
      path: 'convert',
      scheme: 'https',
      queryParameters: {
        'access_key': 'ba89afba792d4622bb63110ef496b92d',
        'from': fromCurrency,
        'to': toCurrency,
        'amount': amount.toString(),
      },
    ),
  );

  final data = JsonDecoder().convert(response.body) as Map<String, dynamic>;

  print('Результат: ${data['result']}');
}
