import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
    customPattern: '\u00A4###,###');

final NumberFormat pointsFormat = NumberFormat.currency(
    locale: 'es_CO', decimalDigits: 0, customPattern: '###,###');

final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
