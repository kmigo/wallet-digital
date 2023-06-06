import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';


import 'dart:developer' as dev;

import '../../../../ds/ds.dart';
import '../../../../helpers/validators.dart';
import '../../../../utils/app_routes.dart';
import '../../../blocs/state_general.dart';
import '../bloc/bloc.dart';



class SignInMobile extends StatefulWidget {
  const SignInMobile({super.key});

  @override
  State<SignInMobile> createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {
  final BlocSignIn bloc = Modular.get();
  var username = '';
  var password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<BlocSignIn, BaseState>(
            bloc: bloc,
            listener: (context, state) {
              dev.log(state.toString());
             if(state is StateError){
              _onError();
             }
           
  
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * .1,),
                       TopText(
                            text: 'Wallet Digital',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                           TopCard(
                            
                            child:  Icon(
                              
                               Icons.person,
                               size: width * .2,
                          
                            ),
                          ),
                           TopInputField(
                            label: "Email",
                            onChanged: (email) => username = email,
                            validator: (email){
                              if(!HelperValidator.email(email)){
                                return "Email Invalido!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                           TopInputField(
                            label: "Senha",
                            obscure: true,
                            onChanged: (passw) => password = passw,
                            validator: (password) {
                              if(!HelperValidator.password(password)){
                                return "Senha invalida!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                           TopButton(text: "Entrar",
                           loading: state is StateLoading,
                          onTap: (){
                            if(_formKey.currentState?.validate() == true){
                              bloc.login(username, password);
                            }
                      
                          },
                          ),
                           SizedBox(
                            height: height * .02,
                          ),
                          TopButton(text: "Registre-se",
                           loading: state is StateLoading,
                           type: TopButtonType.outline,
                          onTap: (){
                           
                            Modular.to.pushReplacementNamed(AppRoutes.signup);
                          },
                          )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _onError(){
    final StateError error= (bloc.state as StateError);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.red,
      content: TopText(text: error.message!,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Colors.white
      ),
      )));
  }
}
