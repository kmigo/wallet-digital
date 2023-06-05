// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/blocs/state_general.dart';
import 'package:wallet_digital/app/pages/notifications/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/notifications/components/tile_notification.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/app_routes.dart';

class NotificationMobile extends StatefulWidget {
  const NotificationMobile({super.key});

  @override
  State<NotificationMobile> createState() => _NotificationMobileState();
}

class _NotificationMobileState extends State<NotificationMobile> {
  final bloc = Modular.get<BlocNotification>();
  @override
  void initState() {
    super.initState();
    bloc.loadNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: const TopText(text: "Notificações"),
        onBack: () {
          Modular.to.navigate(AppRoutes.home);
        },
      ),
      body: BlocConsumer<BlocNotification, BaseState>(
        bloc: bloc,
        listener: (context, state) {

        },
        builder: (context, state) {
             if([StateIdle,StateLoading].contains(state.runtimeType)){
            return const Center(child: TopCircularProgressIndicator());
          }
          if(state is StateError ){
            return  ErrorTryAgain(
              onTap: bloc.loadNotifications,
            );
          }
           final notifications = (state as StateSuccess<List<NotificationEntity>>).data!;
          if(notifications.isEmpty){
            return const TopEmpty();
          }
          Comparator<NotificationEntity> comparator = (a,b) => a.createdAt.compareTo(b.createdAt);
          notifications.sort(comparator);
          return ListView.separated(
            itemCount: notifications.length,
            itemBuilder: (_,index) =>  TileNotification(notificationEntity: notifications[index]),
            separatorBuilder: (_,index) =>const SizedBox() ,
          );
        },
      ),
    );
  }
}
