import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/extract/extract_page.dart';
import 'package:wallet_digital/app/pages/home/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/home/bloc/state.dart';
import 'package:wallet_digital/app/pages/home/components/buttons.dart';
import 'package:wallet_digital/app/pages/home/components/header.dart';
import 'package:wallet_digital/app/pages/home/components/qr_code.dart';

import 'package:wallet_digital/ds/ds.dart';

import '../../../../utils/app_routes.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  final bloc = Modular.get<BlocHome>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopAppBar(
        leading: const SizedBox(),
        title: BlocBuilder<BlocHome, HomeState>(
          bloc: bloc,
          builder: (context, state) {
            return Row(
              children: [
                InkWell(
                  child:  TopText(text:   "Minha Conta",
                  style: state.page == 0 ? Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,color: TopColors.thirdColor) :Theme.of(context).textTheme.bodyMedium?.copyWith() ,
                  ),
                  onTap: () => bloc.onChangePage(0),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child:  TopText(text: "Extrato",
                  style:  state.page == 1 ? Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,color: TopColors.thirdColor) :Theme.of(context).textTheme.bodyMedium?.copyWith(),),
                  onTap: () => bloc.onChangePage(1),
                ),
                const SizedBox(
                  width: 10,
                ),
                 InkWell(
                  child:  TopText(text: "Perfil",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),),
                  onTap: () => Modular.to.navigate(AppRoutes.profile),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(onPressed: () {
                        Modular.to.navigate(AppRoutes.notifications);
          }, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: bloc.signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<BlocHome, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          return IndexedStack(
            index: state.page,
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    HomeHeader(
                      visible: state.visible,
                      onVisible: bloc.visible,
                    ),
                    Expanded(child: HomeQRCode()),
                    const HomeButtons()
                  ],
                ),
              ),
              const ExtractPage()
            ],
          );
        },
      ),
    );
  }
}
