import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wallet_digital/app_module.dart';
import 'package:wallet_digital/app_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 
  if(kIsWeb){
    setPathUrlStrategy();
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD8aD93P3dW1i7dpG7jP9n7N_3gZa6F9Cs",
  authDomain: "wallet-digital-4aa1f.firebaseapp.com",
  databaseURL: "https://wallet-digital-4aa1f-default-rtdb.firebaseio.com",
  projectId: "wallet-digital-4aa1f",
  storageBucket: "wallet-digital-4aa1f.appspot.com",
  messagingSenderId: "419166424991",
  appId: "1:419166424991:web:f28812be6afe006225b7aa",
  measurementId: "G-GDE4G1GC6P"
    ),
  );
await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
  }else{
    await Firebase.initializeApp();
  }
  
   initializeDateFormatting('pt_BR', null).then((_) => runApp( ModularApp(module: AppModule(),child: const AppWidget(),)));
}


          
          
          
          
          
          
          
          
