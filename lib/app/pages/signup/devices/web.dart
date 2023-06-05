import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/blocs/state_general.dart';
import 'package:wallet_digital/app/pages/signup/bloc/bloc.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/helpers/validators.dart';
import 'dart:developer' as dev;
import '../../../../ds/ds.dart';
import '../../../../utils/app_routes.dart';

class SignUpWeb extends StatefulWidget {
  const SignUpWeb({super.key});

  @override
  State<SignUpWeb> createState() => _SignUpWebState();
}

class _SignUpWebState extends State<SignUpWeb> {
  final bloc = Modular.get<BlocSignUp>();
  var entity = UserEntity.empty();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var password = '';
    return Scaffold(
      body: BlocConsumer<BlocSignUp, BaseState>(
        bloc: bloc,
        listener: (context, state) {
          dev.log(state.toString());
          if (state is StateError) {
            _onError();
          }
          if (state is StateSuccess) {
            Modular.to.pushReplacementNamed(AppRoutes.home);
          }
        },
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width *.4,
                    child: TopCard(
                      color: TopColors.thirdColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * .1,
                              ),
                              TopText(
                                text: 'Wallet Digital',
                                
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              TopCard(
                                child: Icon(
                                  Icons.person,
                                  size: size.width * .2,
                                ),
                              ),
                              TopInputField(
                                label: "Nome",
                                validator: _required,
                                onChanged: (nome) =>
                                    entity = entity.copyWith(firstName: nome),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "Celular",
                                 validator: _required,
                                onChanged: (text) =>
                                    entity = entity.copyWith(phoneNumber: text),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "Email",
                                 validator: _email,
                                onChanged: (text) =>
                                    entity = entity.copyWith(username: text),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TopInputField(
                                      label: "Rua",
                                       validator: _required,
                                      onChanged: (text) =>
                                          entity = entity.copyWith(street: text),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.height * .02,
                                  ),
                                  Flexible(
                                    child: TopInputField(
                                      label: "Numero",
                                       validator: _required,
                                      onChanged: (text) =>
                                          entity = entity.copyWith(houseNumber: text),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "Bairro",
                                 validator: _required,
                                onChanged: (text) =>
                                    entity = entity.copyWith(neighborhood: text),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "CEP",
                                 validator: _required,
                                onChanged: (text) =>
                                    entity = entity.copyWith(zipCode: text),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "Cidade",
                                 validator: _required,
                                onChanged: (text) =>
                                    entity = entity.copyWith(city: text),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "CPF",
                                 validator: _required,
                                onChanged: (text) =>
                                    entity = entity.copyWith(cpf: text),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopInputField(
                                label: "Senha",
                                obscure: true,
                                 validator: _password,
                                onChanged: (text) => password = text,
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopButton(
                                text: "Cadastrar-se",
                                 disabled: state is StateLoading,
                                      
                                loading: state is StateLoading,
                                onTap: () {
                                  if (_formKey.currentState?.validate() == true) {
                                    bloc.register(entity, password);
                                  }
                                },
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              TopButton(
                                text: "Já tenho conta",
                                disabled: state is StateLoading,
                                      
                                type: TopButtonType.outline,
                                onTap: () {
                                  Modular.to.pushReplacementNamed(AppRoutes.signin);
                                },
                              ),
                            ],
                          ),
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
    );
  }

  String? _required(String? text) {
    if (HelperValidator.required(text)) return null;
    return "Campo obrigatorio.";
  }

  String? _password(password) {
    if (!HelperValidator.password(password)) {
      return "Senha invalida!";
    }
    return null;
  }
    String? _email(password) {
    if (!HelperValidator.email(password)) {
      return "Email invalida!";
    }
    return null;
  }

  _onError() {
    final StateError error = (bloc.state as StateError);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
        content: TopText(
          text: error.message!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        )));
  }
}
