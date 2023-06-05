


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/profile/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/profile/bloc/state.dart';
import 'package:wallet_digital/app/pages/profile/components/header.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/app_routes.dart';
import '../../../../helpers/validators.dart';

class ProfileTablet extends StatefulWidget {
  const ProfileTablet({super.key});

  @override
  State<ProfileTablet> createState() => _ProfileTabletState();
}

class _ProfileTabletState extends State<ProfileTablet> {
  final bloc = Modular.get<BlocProfile>();
  @override
  void initState() {
    super.initState();
    bloc.loadUser();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  TopAppBar(
        onBack: (){
          Modular.to.navigate(AppRoutes.home);
        },
        title:  const TopText(text: 'Perfil'),
        centerTitle: true,
       
      ),
      body: BlocBuilder<BlocProfile, ProfileState>(
        bloc: bloc,
        builder: (context, state) {
             if([ProfileStatus.loading.name,ProfileStatus.idle.name].contains(state.status.name)){
            return const Center(child: TopCircularProgressIndicator());
          }
          if(state.status == ProfileStatus.error ){
            return  ErrorTryAgain(
              onTap: bloc.loadUser,
            );
          }
          return SingleChildScrollView(
              child: SizedBox(
                width: size.width ,
                child: Column(

                  children: [
                    SizedBox(
                      width: size.width *.5,
                      child: TopCard(
                        color: TopColors.thirdColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ProfileHeader(image: state.user.image, onChange: (image){
                                bloc.onChangedInfoUser(state.user.copyWith(
                                  image: image.substring(image.indexOf(',') + 1)
                                ));
                              }),
                              TopInputField(
                                    label: "Nome",
                                    initialValue: state.user.firstName,
                                    validator: _required,
                                    onChanged: (nome) =>
                                        bloc.onChangedInfoUser( state.user.copyWith(firstName: nome)),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  TopInputField(
                                    label: "Celular",
                                    initialValue: state.user.phoneNumber,
                                     validator: _required,
                                    onChanged: (text) =>
                                        bloc.onChangedInfoUser( state.user.copyWith(phoneNumber: text)),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                             
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TopInputField(
                                          label: "Rua",
                                          initialValue: state.user.street,
                                           validator: _required,
                                          onChanged: (text) =>
                                              bloc.onChangedInfoUser(state.user.copyWith(street: text)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.height * .02,
                                      ),
                                      Flexible(
                                        child: TopInputField(
                                          label: "Numero",
                                          initialValue: state.user.houseNumber,
                                           validator: _required,
                                          onChanged: (text) =>
                                              bloc.onChangedInfoUser( state.user.copyWith(houseNumber: text)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  TopInputField(
                                    label: "Bairro",
                                    initialValue: state.user.neighborhood,
                                     validator: _required,
                                    onChanged: (text) =>
                                        bloc.onChangedInfoUser( state.user.copyWith(neighborhood: text)),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  TopInputField(
                                    label: "CEP",
                                    initialValue: state.user.cpf,
                                     validator: _required,
                                    onChanged: (text) =>
                                        bloc.onChangedInfoUser( bloc.state.user.copyWith(zipCode: text)),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  TopInputField(
                                    label: "Cidade",
                                    initialValue: state.user.city,
                                     validator: _required,
                                    onChanged: (text) =>
                                        bloc.onChangedInfoUser( state.user.copyWith(city: text)),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                
                                  TopButton(text: "Salvar",onTap: bloc.updateUser,type: TopButtonType.contain,)
                                      
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
    );
  }
   String? _required(String? text) {
    if (HelperValidator.required(text)) return null;
    return "Campo obrigatorio.";
  }


  
}