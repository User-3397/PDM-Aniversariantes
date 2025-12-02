library validador;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A validator is a function that processes a `FormField`
/// and returns an error [String] or null. A null [String] means that validation has passed.
FormFieldValidator validarNome() {
  return (value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    } else {
      return null;
    } // Passou na validação
  };
}

FormFieldValidator validarEmail() {
  return (value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      //Permite campo vazio
      return null;
    }
    if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  };
}

FormFieldValidator? validarData() {
  return (value) {
    if (value!.isEmpty) {
      return "Informe a data";
    } else {
      try {
        DateTime date = DateFormat('dd/MM/yyyy').parseStrict(value);
        //final currentDate = DateTime.now();
        /*if (date.isAfter(currentDate)) {
          return ("A data não pode ser posterior ao dia de hoje !");
        } else {
          return null;
        }*/
      } catch (e) {
        return ("Data Incorreta !");
      }
    }
  };
}

FormFieldValidator? validarTelefone() {
  // Expressão regular para validar números de telefone no Brasil
  final RegExp phoneNumberRegex = RegExp(
    r'^\([0-9]{2}\)[0-9]{5}-[0-9]{4}',
    caseSensitive: false,
  );

  return (value) {
    if (value!.isEmpty) {
      //Permite campo vazio
      return null;
    }
    // Valida o número de telefone usando a expressão regular
    if (!phoneNumberRegex.hasMatch(value)) {
      return 'Número de telefone inválido !';
    } else {
      return null;
    }
  };
}
