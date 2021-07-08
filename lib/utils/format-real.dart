import 'package:intl/intl.dart';

//Função para formatar os preços para o formato do Brasil, com duas casas decimais.
var realFormat = NumberFormat.currency(
    locale: 'br',
    name: 'R\$ ',
    decimalDigits: 2,
    symbol: ''
);