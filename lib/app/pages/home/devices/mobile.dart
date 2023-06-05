import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/extract/extract_page.dart';
import 'package:wallet_digital/app/pages/home/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/home/bloc/state.dart';
import 'package:wallet_digital/app/pages/home/components/buttons.dart';
import 'package:wallet_digital/app/pages/home/components/header.dart';
import 'package:wallet_digital/app/pages/home/components/qr_code.dart';
import 'package:wallet_digital/app/pages/home/components/bottom_bar.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/app_routes.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  final bloc = Modular.get<BlocHome>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopAppBar(
        title: const TopText(text: "Wallet"),
        avatarPerson: true,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Modular.to.navigate(AppRoutes.notifications);
          }, icon: const Icon(Icons.notifications)),
         
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
                    HomeHeader(visible: state.visible,
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
      bottomNavigationBar: BlocBuilder<BlocHome, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          return HomeBottomBar(
              currentIndex: state.page,
              onChange: bloc.onChangePage,
            );
        },
      ),
    );
  }
}
