import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/deposit/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/deposit/deposit_page.dart';
import 'package:wallet_digital/app/pages/extract/bloc/bloc.dart';

import 'package:wallet_digital/app/pages/home/home_page.dart';
import 'package:wallet_digital/app/pages/notifications/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/notifications/notifications_page.dart';
import 'package:wallet_digital/app/pages/profile/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/profile/profile.dart';
import 'package:wallet_digital/app/pages/signin/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/signin/signin_page.dart';
import 'package:wallet_digital/app/pages/signup/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/signup/signup_page.dart';
import 'package:wallet_digital/app/pages/splash/splash_page.dart';
import 'package:wallet_digital/app/pages/transfer/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/transfer/transfer_page.dart';
import 'package:wallet_digital/core/datasource/transaction_datasource.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';
import 'package:wallet_digital/implementations/datasource/transaction_datasource.dart';
import 'package:wallet_digital/implementations/repository/transaction_repository.dart';
import 'package:wallet_digital/implementations/usecases/create_transaction.dart';
import 'package:wallet_digital/implementations/usecases/fetch_user_by_cpf.dart';
import 'package:wallet_digital/implementations/usecases/get_all_notification_by_cpf.dart';
import 'package:wallet_digital/implementations/usecases/get_all_transaction_by_cpf.dart';
import 'package:wallet_digital/implementations/usecases/update_transaction.dart';
import 'package:wallet_digital/implementations/usecases/update_user.dart';
import 'package:wallet_digital/utils/app_routes.dart';

import 'app/blocs/authententication/bloc.dart';
import 'app/pages/home/bloc/bloc.dart';
import 'core/datasource/authentication_user.dart';



import 'core/repository/authentication_repository.dart';
import 'helpers/cache_helper.dart';

import 'implementations/datasource/authentication_user.dart';
import 'implementations/repository/authentication_repository.dart';
import 'implementations/usecases/current_user.dart';

import 'implementations/usecases/sign_in.dart';
import 'implementations/usecases/sign_out.dart';
import 'implementations/usecases/sign_up.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // HELPERS
        Bind.lazySingleton<CacheHelper>((i) => CacheHelperImpl()),
    

        // DATASOURCES
        Bind.lazySingleton<AuthenticationDatasource>(
            (i) => AuthenticationDatasourceImpl()),
            Bind.lazySingleton<TransactionDatasource>((i) => TransactionDatasourceImpl()),
            
        // REPOSITORIES
        Bind.lazySingleton<AuthenticationRepository>(
            (i) => AutheticationRepositoryImpl(i())),
            Bind.lazySingleton<TransactionRepository>((i) => TransactionRepositoryImpl(i())),
           
        // USECASES
        Bind.lazySingleton((i) => CurrentUserUsecaseImpl(i())),
        Bind.lazySingleton((i) => SignInUsecaseImpl(i())),
        Bind.lazySingleton((i) => SignOutUsecaseImpl(i())),
        Bind.lazySingleton((i) => UpdateUserUsecaseImpl(i())),
        Bind.lazySingleton((i) => SignUpUsecaseImpl(i())),
        Bind.lazySingleton((i) => CreateTransactionUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetAllTransactionByCPFUsecaseImpl(i())),
        Bind.lazySingleton((i) => UpdateTransactionUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetAllNotificationsByCPFImpl(i())),
        Bind.lazySingleton((i) => FetchUserByCpfImpl(i())),
        //BLOCS
        Bind.lazySingleton((i) => AutheticationBloc(
            controller: i<AuthenticationRepository>().status,
            signOutUsecase: i(),
            currentUserUsecase: i())),
            Bind.factory((i) => BlocSignIn(i())),
            Bind.factory((i) => BlocSignUp(signUp: i())),
            Bind.lazySingleton((i) => BlocHome(signOut: i())),
            Bind.lazySingleton((i) => BlocDeposit(i(), i())),
            Bind.lazySingleton((i) => BlocExtract(i(), i())),
            Bind.lazySingleton((i) => BlocProfile(i(), i())),
            Bind.lazySingleton((i) => BlocNotification(i(), i(), i())),
            Bind.factory((i) => BlocTransfer(i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
       ChildRoute(AppRoutes.splash, child: (_,args) => const SplashPage()),
       ChildRoute(AppRoutes.signin, child: (_,args) => const SignInPage()),
        ChildRoute(AppRoutes.signup, child: (ct,args) => const SignUpPage()),
      ChildRoute(AppRoutes.home, child: (_,args) => const HomePage()),
      ChildRoute(AppRoutes.deposit, child: (ctx,args) => const DepositPage()),
      ChildRoute(AppRoutes.profile, child: (ctx,args) => const ProfilePage()),
      ChildRoute(AppRoutes.notifications, child: (ctx,args) => const NotificationsPage()),
      ChildRoute(AppRoutes.transfer, child: (ctx,args) => const TransferPage())
      ];
}
