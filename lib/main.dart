import 'package:flutter/material.dart';
import 'package:cine_topia/app/core/service_locator.dart';
import 'package:cine_topia/app/app.dart';

void main() { 
  // Inicializa o ServiceLocator antes de executar o app
  ServiceLocator.initialize();
  
  runApp(const Cinetopia());
}


