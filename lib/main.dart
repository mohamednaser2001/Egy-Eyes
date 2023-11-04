import 'dart:async';
import 'dart:html' as html;
import 'package:bloc/bloc.dart';
import 'package:egy_eye_admin/app/archive/view_model/archive_bloc/archive_bloc.dart';
import 'package:egy_eye_admin/app/layout/view/screens/layout_screen.dart';
import 'package:egy_eye_admin/app/reports/view_model/app_bloc/app_bloc.dart';
import 'package:egy_eye_admin/app/support/model/support_model.dart';
import 'package:egy_eye_admin/helpers/cache/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app/authentication/view/login_screen.dart';
import 'app/campaigns/view_model/campaigns_bloc/campaigns_bloc.dart';
import 'app/layout/view_model/locale_cubit/locale_cubit.dart';
import 'app/layout/view_model/locale_cubit/locale_states.dart';
import 'app/reports/view_model/app_bloc/app_observer.dart';
import 'app/support/view_model/support_bloc/support_bloc.dart';
import 'helpers/constants/constants.dart';
import 'helpers/localization/app_localization.dart';

String apiKey = "AIzaSyCTLHSgmMxT_ctRQzmDbL_Vr5dExEQHNf0";
String projectId = "egyeyes-38cae";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  //await windowManager.ensureInitialized();
  //Firestore.initialize(projectId);
  await CacheHelper.init();
  //uId = CacheHelper.getData(key: 'uId');
  uId = html.window.localStorage['uId'];
  print(uId.toString() + '================');

  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCTLHSgmMxT_ctRQzmDbL_Vr5dExEQHNf0",
        authDomain: "egyeyes-38cae.firebaseapp.com",
        projectId: "egyeyes-38cae",
        storageBucket: "egyeyes-38cae.appspot.com",
        messagingSenderId: "181989827182",
        appId: "1:181989827182:web:d52e739f3e584dff3b7c7f",
        measurementId: "G-JVEWYQTDKX"),
  ).then((value) {
    runApp(MyApp());
  });

  // WindowOptions windowOptions =const WindowOptions(
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.normal,
  //   minimumSize: Size(800, 700)
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  //   await windowManager.focus();
  // },);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //mosatfa
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SupportCubit(),
        ),
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) => ArchiveCubit(),
        ),
        BlocProvider(
          create: (context) => CampaignsCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..getAdminData(),
        ),
      ],
      child: BlocConsumer<LocaleCubit, ChangeLocaleState>(
        listener: (context, state) {},
        builder: (context, state) => ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            home: child,
          ),
          child: uId == null ? LoginScreen() : LayoutScreen(),
        ),
      ),
    );
  }
}
