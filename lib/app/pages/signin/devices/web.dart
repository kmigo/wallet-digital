import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';


import 'dart:developer' as dev;

import '../../../../ds/ds.dart';
import '../../../../helpers/validators.dart';
import '../../../../utils/app_routes.dart';
import '../../../blocs/state_general.dart';
import '../bloc/bloc.dart';



class SignInWeb extends StatefulWidget {
  const SignInWeb({super.key});

  @override
  State<SignInWeb> createState() => _SignInWebState();
}

class _SignInWebState extends State<SignInWeb> {
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
             if(state is StateSuccess ){
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
             }
  
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TopCard(
                        color: TopColors.thirdColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0 * 3),
                          child: SizedBox(
                            width: width * .3,
                            child: Column(

                              children: [
                            
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
                        ),
                      ),
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
