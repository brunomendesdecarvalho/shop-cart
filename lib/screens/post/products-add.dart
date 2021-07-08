import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reactive_forms/reactive_forms.dart';

Future<http.Response> createProduct(String nome, String valor) {
  return http.post(
    Uri.parse('https://api-fluttter.herokuapp.com/api/v1/produto/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nome': nome,
      'valor': valor
    }),
  );
}

class AddProducts extends StatelessWidget {
  final form = FormGroup({
    'nome': FormControl<String>(validators: [Validators.required]),
    'valor': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Produto'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ReactiveForm(
            formGroup: form,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15),
                children: <Widget>[
                  ReactiveTextField(
                    formControlName: 'nome',
                    decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                        focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ReactiveTextField(
                    formControlName: 'valor',
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ]
              )
            ),
          ),
          ElevatedButton(
            onPressed: () {
              createProduct(form.control('nome').value, form.control('valor').value);
            },
            child: Text('Adicionar Produto'),
          ),
        ],
      ),
    );
  }
}