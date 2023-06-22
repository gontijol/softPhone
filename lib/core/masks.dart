import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class Masks {
  static var maskBanco =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  static var maskPIN =
      MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});
  static var maskCRNM = MaskTextInputFormatter(
      mask: '#######-#', filter: {"#": RegExp(r'[A-Za-z0-9]')});
  static var maskPass = MaskTextInputFormatter(
      mask: '##############################', filter: {"#": RegExp(r'[\S]')});
  static var maskName = MaskTextInputFormatter(
      mask: '############################################################',
      filter: {"#": RegExp(r'^[a-zA-Zà-úÀ-Ú_ ]*$')});
  static var maskBrPhone = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  static var maskUUID = MaskTextInputFormatter(
      mask: '########-####-####-####-############',
      filter: {"#": RegExp(r'[0-9a-z]')});
  static var maskBrBusinessPhone = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  static var maskUsPhone = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});
  static var maskGenericPhone = MaskTextInputFormatter(
      mask: '############', filter: {"#": RegExp(r'[0-9]')});
  static var maskCpf = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  static var maskCNPJ = MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
  static var maxCpfCnpjChar = MaskTextInputFormatter(
      mask: '##################', filter: {"#": RegExp(r'[0-9]')});
  static var cleanmask = MaskTextInputFormatter(
      mask: '##############', filter: {"#": RegExp(r'[0-9]')});
  static var maskBirthDate = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  static var maskZipCode = MaskTextInputFormatter(
      mask: '##.###-###', filter: {"#": RegExp(r'[0-9]')});
  static var maskMoney = TextInputFormatter.withFunction((_, newValue) {
    String newText = newValue.text
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('_', '')
        .replaceAll('-', '');
    String value = newText;
    int cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = formatCurrency(double.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  });
  static var maskUsMoney = TextInputFormatter.withFunction((_, newValue) {
    String newText = newValue.text
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('_', '')
        .replaceAll('-', '');
    String value = newText;
    int cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = formatUsCurrency(double.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  });
  static var maskAccount = TextInputFormatter.withFunction((_, newValue) {
    String newText = newValue.text.replaceAll('.', '').replaceAll('-', '');
    String value = newText;
    int cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = formatAccount(double.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  });
  static var maskAgency = TextInputFormatter.withFunction((_, newValue) {
    String newText = newValue.text;
    String value = newText;
    int cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = formatAgency(double.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  });
  static var maskBank = TextInputFormatter.withFunction((_, newValue) {
    String newText = newValue.text;
    String value = newText;
    int cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = formatBank(double.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  });

  static String formatCpnjOrCpf(v, type) {
    // ignore: prefer_typing_uninitialized_variables
    var a;
    if (type == 0) {
      a = v[0] +
          v[1] +
          v[2] +
          '.' +
          v[3] +
          v[4] +
          v[5] +
          '.' +
          v[6] +
          v[7] +
          v[8] +
          '-' +
          v[9] +
          v[10];
      return a;
    } else {
      a = v[0] +
          v[1] +
          '.' +
          v[2] +
          v[3] +
          v[4] +
          '.' +
          v[5] +
          v[6] +
          v[7] +
          '/' +
          v[8] +
          v[9] +
          v[10] +
          v[11] +
          '-' +
          v[12] +
          v[13];

      return a;
    }
  }
}

String formatCurrency(num value, {int fractionDigits = 2}) {
  ArgumentError.checkNotNull(value, 'value');
  value = value / 100;
  return NumberFormat.currency(
    customPattern: '###,###.##',
    locale: 'pt_BR',
  ).format(value);
}

String formatUsCurrency(num value, {int fractionDigits = 2}) {
  ArgumentError.checkNotNull(value, 'value');
  value = value / 100;
  return NumberFormat.currency(
    customPattern: '###,###.##',
    locale: 'en_US',
  ).format(value);
}

String formatMoney(num value, {int fractionDigits = 2}) {
  ArgumentError.checkNotNull(value, 'value');
  return NumberFormat.currency(
    customPattern: '###,###.##',
    locale: 'pt_BR',
  ).format(value);
}

String formatUsMoney(num value, {int fractionDigits = 2}) {
  ArgumentError.checkNotNull(value, 'value');
  return NumberFormat.currency().format(value).replaceAll('USD', '');
}

String formatAccount(num value, {int fractionDigits = 1}) {
  ArgumentError.checkNotNull(value, 'value');
  value = value / 10;
  return NumberFormat(".0").format(value).replaceAll('.', '-');
}

String formatBank(num value) {
  ArgumentError.checkNotNull(value, 'value');
  return NumberFormat("000").format(value);
}

String formatAgency(num value) {
  ArgumentError.checkNotNull(value, 'value');
  return NumberFormat("0000").format(value);
}

String formatNotificationDate(String date) {
  var dateOf = DateTime.parse(date);
  var today = DateTime.now().toLocal();

  if (today.difference(dateOf).inMinutes < 1) {
    return 'há instantes';
  } else if (today.difference(dateOf).inMinutes == 1) {
    return 'há ${(today.difference(dateOf).inMinutes)} minuto';
  } else if (today.difference(dateOf).inMinutes < 60 &&
      today.difference(dateOf).inHours == 0) {
    return 'há ${(today.difference(dateOf).inMinutes)} minutos';
  } else if (today.difference(dateOf).inHours == 1) {
    return 'há ${(today.difference(dateOf).inHours)} hora';
  } else if (today.difference(dateOf).inHours < 24 &&
      today.difference(dateOf).inDays == 0) {
    return 'há ${(today.difference(dateOf).inHours)} horas';
  } else if (today.difference(dateOf).inDays == 1) {
    return 'há ${(today.difference(dateOf).inDays)} dia';
  } else if (today.difference(dateOf).inDays < 30) {
    return 'há ${(today.difference(dateOf).inDays)} dias';
  } else if ((today.difference(dateOf).inDays / 30).round() < 2) {
    return 'há ${(today.difference(dateOf).inDays / 30).round()} mês';
  } else {
    return 'há ${(today.difference(dateOf).inDays / 30).round()} meses';
  }
}

Duration dateDiference(date) {
  var dateOf = date;
  var today = DateTime.now().toLocal();
  return today.difference(dateOf);
}

String formatDate(String date) {
  return '${DateFormat('dd/MM/yyyy - HH').format(DateTime.parse(date).toLocal())}h${DateFormat('mm').format(DateTime.parse(date).toLocal())}';
}

String formatDateDay(String date) {
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(date).toLocal());
}

String hideCPF(String value) {
  return value.replaceRange(3, 11, '********');
}

String hideEmail(String value) {
  var i = value.indexOf('@');
  return value.replaceRange(4, i, putAsterisk(i - 4));
}

String hidePhone(String value) {
  if (value.contains('+55')) {
    return value.replaceRange(3, 10, '*******');
  } else if (value.contains('+1')) {
    return value.replaceRange(2, 8, '******');
  } else {
    return value.replaceRange(3, value.length - 2, '******');
  }
}

String putAsterisk(num n) {
  var asteriskMask = '';
  for (var j = 1; j <= n; j++) {
    asteriskMask = '$asteriskMask*';
  }
  return asteriskMask;
}

String formatCpf(String value) {
  return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6, 9)}-${value.substring(9, 11)}';
}

String formatCnpj(String value) {
  return '${value.substring(0, 2)}.${value.substring(2, 5)}.${value.substring(5, 8)}/${value.substring(8, 12)}-${value.substring(12, 14)}';
}
