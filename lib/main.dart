import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/bindings/auth_bind.dart';
import 'package:flutter_samples/bindings/infinite_bind.dart';
import 'package:flutter_samples/bindings/infinite_bind_dua.dart';
import 'package:flutter_samples/bindings/infinite_bind_dua_alternative.dart';
import 'package:flutter_samples/bloc/authentication_bloc.dart';
import 'package:flutter_samples/bloc/counterthree_bloc.dart';
//import 'package:flutter_samples/bloc/infiniteversion2/post_bloc_version2.dart';
import 'package:flutter_samples/camera_guide_screen.dart';
import 'package:flutter_samples/controllers/infinite_controller.dart';
import 'package:flutter_samples/infinite_loading_getx_screen.dart';
import 'package:flutter_samples/infinite_loading_getx_screen_dua.dart';
import 'package:flutter_samples/infinite_loading_getx_screen_dua_alternative.dart';
import 'package:flutter_samples/infinite_loading_getx_screen_tiga.dart';
import 'package:flutter_samples/infinite_stream_builder_screen.dart';
import 'package:flutter_samples/location_real_screen.dart';
import 'package:flutter_samples/login_standard_getx.dart';
import 'package:flutter_samples/login_standard_screen.dart';
import 'package:flutter_samples/map_here_screen.dart';
import 'package:flutter_samples/screens/place_detail_screen.dart';
import 'package:flutter_samples/services/authentication_service.dart';
import 'package:flutter_samples/slidable_screen.dart';
import 'package:get_storage/get_storage.dart';
import './application_lifecycle_state_screen.dart';
import './biometric_screen.dart';
import './bloc/counter_bloc.dart';
import './bloc/counterb_bloc.dart';
import './bloc/post_bloc.dart';
import './bloc/user_bloc.dart';
import './bloc_one_screen.dart';
import './card_with_message_screen.dart';
import './cloud_firestore_screen.dart';
import './cubit/counterc_cubit.dart';
import './cubit/countercubit_cubit.dart';
import './cubit/mypost_cubit.dart';
import './cubit_state_screen.dart';
import './division_screen.dart';
import './dropdown_screen.dart';
import './firebase_storage_screen.dart';
import './future_provider_builder_screen.dart';
import './get_many_screen.dart';
import './get_screen.dart';
import './google_font_screen.dart';
import './great_places_screen.dart';
import './hive_screen.dart';
import './infinite_loading_cubit_screen.dart';
import './infinite_loading_screen.dart';
import './listview_bloc_screen.dart';
import './login_firebase_screen.dart';
import './mobx_state_screen.dart';
import './model/monster.dart';
import './multibloc_screen.dart';
import './mvvm_screen.dart';
import './one_signal_notification_screen.dart';
import './progress_bar_provider.dart';
import './provider/color_bloc_flutter.dart';
import './replay_bloc_screen.dart';
import './rive_flutter_screen.dart';
import './screens/add_place_screen.dart';
import './shared_preferences_screen.dart';
import './shimmer_effect_screen.dart';
import './slider_pageview_screen.dart';
import './slider_transition_screen.dart';
import './state_management_screen.dart';
import './switch_screen.dart';
import './timer_screen.dart';
import './try_widget_screen.dart';
import './widgets/list_subject.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import './post_screen.dart';
import './provider/uiset.dart';
import 'bloc/color_bloc.dart';
import 'bloc/counter_bloc_5.dart';
import 'bloc/infiniteversion2/bloc.dart';
import 'bloc_three_screen.dart';
import 'bloc_two_screen.dart';
import 'future_provider_screen.dart';
import 'infinite_future_builder_screen.dart';
import 'infinite_loading_cubit_select_screen.dart';
import 'infinite_loading_screen2.dart';
import 'listview_bloc_screen.dart';
import 'package:get/get.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:http/http.dart' as http;

//HERE MAP PAKET
//import 'package:here_sdk/core.dart';

//import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'my_home_page.dart';
import 'provider/great_places.dart';
import 'stream_provider_screen.dart';

import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition_type;

void main() async {
  //untuk aktifkan sdk HERE MAP (here.com)
  //SdkContext.init(IsolateOrigin.main);

  //THIS CODE FOR : Setup HydratedStorage
  //WE MUST ENSURE getApplicationDocumentsDirectory BEFORE runApp, THEN USED ensureInitialized()
  WidgetsFlutterBinding.ensureInitialized();
  //HydratedBloc.storage = await HydratedStorage.build();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  //for HIVE
  //WidgetsFlutterBinding.ensureInitialized();
  /* var appDocumentDirectory = await pathProvider
      .getApplicationDocumentsDirectory(); //cari otomatis direktori document baik android or iOS
  Hive.init(appDocumentDirectory.path); */
  //Proses set init dokument bisa diganti oleh Hive.initFlutter() milih packages hive_flutter
  Hive.initFlutter();
  //Register/daftarkan adapter nya agar bisa terima tipe data Monster, kareva hive defaultnya hanya int dan String
  Hive.registerAdapter(MonsterAdapter());

  //YOU NEED TO INITIALIZE FIREBASE TO USE FIREBASE PACKET, using firebase_core.dart
  await Firebase.initializeApp();

  //ONESIGNAL NOTIFICATION
  OneSignal.shared
      .init("6953df17-7938-440c-a4cc-ccff16209b3a", iOSSettings: null);
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  //INISIALISASI PENGGUNAAN Get Strorage
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Multiprovider implementation
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UiSet>(create: (_) => UiSet()),
        ChangeNotifierProvider<GreatPlaces>(create: (_) => GreatPlaces()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ColorBlocFlutter>(
            create: (BuildContext context) => ColorBlocFlutter(),
          ),
          BlocProvider<ColorBloc>(
            create: (BuildContext context) => ColorBloc(),
          ),
          BlocProvider<CounterBloc>(
            create: (BuildContext context) => CounterBloc(),
          ),
          BlocProvider<PostBloc>(
            //agar langsung memanggil data yang pertama, maka gunakan add(PostEvent())
            //create: (context) => PostBloc()..add(PostEvent()),
            create: (context) => PostBloc(),
          ),
          BlocProvider<PostBlocVersion2>(
            //agar langsung memanggil data yang pertama, maka gunakan add(PostEvent())
            //create: (context) =>PostBlocVersion2(httpClient: http.Client())..add(PostFetched()),
            //create: (context) => PostBlocVersion2(httpClient: http.Client())..add(PostEventInitial()),
            create: (context) => PostBlocVersion2(httpClient: http.Client()),
            //create: (context) => PostBlocVersion2()..add(PostFetched()),
          ),
          BlocProvider<CounterBloc5>(
            create: (context) => CounterBloc5(),
          ),
          BlocProvider<CounterbBloc>(
            create: (context) => CounterbBloc(),
          ),
          BlocProvider<CountercCubit>(
            create: (context) => CountercCubit(),
          ),
          BlocProvider<CounterthreeBloc>(
            create: (context) => CounterthreeBloc(),
          ),
        ],
        //child: MaterialApp(
        child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //textTheme: GoogleFonts.srirachaTextTheme(),
            /* textTheme: GoogleFonts.srirachaTextTheme().copyWith(
              bodyText1: GoogleFonts.modak(),
              headline2: GoogleFonts.halant(),
            ), */
          ),
          debugShowCheckedModeBanner: false,
          defaultTransition: transition_type.Transition.native,
          home: MyHomePage(title: 'HTTP and Widget Sample'),
          getPages: [
            GetPage(
              name: '/my-home-page',
              page: () => MyHomePage(title: 'HTTP and Widget Sample'),
              transition: transition_type.Transition.cupertino,
            ),
            GetPage(
              name: '/infinite-loading-getx',
              page: () => InfiniteLoadingGetxScreen(),
              binding: InfiniteBind(),
              transition: transition_type.Transition.cupertino,
            ),
            GetPage(
              name: '/infinite-loading-getx-dua',
              page: () => InfiniteLoadingGetxScreenDua(),
              binding: InfiniteBindDua(),
              transition: transition_type.Transition.cupertino,
            ),
            GetPage(
              name: '/infinite-loading-getx-dua-alternative',
              page: () => InfiniteLoadingGetxScreenDuaAlternative(),
              binding: InfiniteBindDuaAlternative(),
              transition: transition_type.Transition.cupertino,
            ),
            GetPage(
              name: '/infinite-loading-getx-tiga',
              page: () => InfiniteLoadingGetxScreenTiga(),
              binding: InfiniteBindDua(),
              transition: transition_type.Transition.cupertino,
            ),
            GetPage(
              name: '/login-standard-getx',
              page: () => LoginStandardGetxScreen(),
              binding: AuthBind(),
              transition: transition_type.Transition.cupertino,
            ),
          ],
          routes: {
            PostScreen.routeName: (ctx) => PostScreen(),
            GetScreen.routeName: (ctx) => GetScreen(),
            GetManyScreen.routeName: (ctx) => GetManyScreen(),
            TryWidgetScreen.routeName: (ctx) => TryWidgetScreen(),
            SwitchScreen.routeName: (ctx) => SwitchScreen(),
            SharedPreferencesScreen.routeName: (ctx) =>
                SharedPreferencesScreen(),
            StateManagementScreen.routeName: (ctx) => StateManagementScreen(),
            BlocOneScreen.routeName: (ctx) => BlocOneScreen(),
            //DISINI DIPASANGKAN PROVIDER BLOC FLUTTER NYA
            //create will get executed when the bloc is looked up via BlocProvider.of<BlocA>(context)
            /* BlocTwoScreen.routeName: (ctx) => BlocProvider<ColorBlocFlutter>(
                create: (context) => ColorBlocFlutter(), child: BlocTwoScreen()), */
            //USING MULTIBLOCPROVIDER
            BlocTwoScreen.routeName: (ctx) => BlocTwoScreen(),
            BlocThreeScreen.routeName: (ctx) => BlocThreeScreen(),
            TimerScreen.routeName: (ctx) => TimerScreen(),
            ProgressBarProvider.routeName: (ctx) => ProgressBarProvider(),
            CardWithMessageScreen.routeName: (ctx) => CardWithMessageScreen(),
            ListviewBlocScreen.routeName: (ctx) => BlocProvider<ProductBloc>(
                  create: (BuildContext context) => ProductBloc(),
                  child: ListviewBlocScreen(),
                ),
            MvvmScreen.routeName: (ctx) => BlocProvider<UserBloc>(
                  create: (BuildContext context) => UserBloc(),
                  child: MvvmScreen(),
                ),
            MultiblocScreen.routeName: (ctx) => MultiblocScreen(),
            DropdownScreen.routeName: (ctx) => DropdownScreen(),
            HiveScreen.routeName: (ctx) => HiveScreen(),
            InfiniteFutureBuilderScreen.routeName: (ctx) =>
                InfiniteFutureBuilderScreen(),
            InfiniteLoadingScreen.routeName: (ctx) => InfiniteLoadingScreen(),
            InfiniteLoadingScreen2.routeName: (ctx) => InfiniteLoadingScreen2(),
            InfiniteLoadingCubitScreen.routeName: (ctx) => BlocProvider(
                create: (context) => MypostCubit(),
                child: InfiniteLoadingCubitScreen()),
            InfiniteLoadingCubitSelectScreen.routeName: (ctx) => BlocProvider(
                create: (context) => MypostCubit(),
                child: InfiniteLoadingCubitSelectScreen()),
            //InfiniteLoadingGetxScreen.routeName: (ctx) => InfiniteLoadingGetxScreen(),
            MobxStateScreen.routeName: (ctx) => MobxStateScreen(),
            DivisionScreen.routeName: (ctx) => DivisionScreen(),
            SliderPageviewScreen.routeName: (ctx) => SliderPageviewScreen(),
            SliderTransitionScreen.routeName: (ctx) => SliderTransitionScreen(),
            RiveFlutterScreen.routeName: (ctx) => RiveFlutterScreen(),
            GoogleFontScreen.routeName: (ctx) => GoogleFontScreen(),
            LoginFirebaseScreen.routeName: (ctx) => LoginFirebaseScreen(),
            // Injects the Authentication service
            LoginStandardScreen.routeName: (ctx) =>
                RepositoryProvider<AuthenticationService>(
                  create: (context) {
                    return FakeAuthenticationService();
                  },
                  // Injects the Authentication BLoC
                  child: BlocProvider<AuthenticationBloc>(
                    create: (context) {
                      final authService =
                          RepositoryProvider.of<AuthenticationService>(context);
                      return AuthenticationBloc(authService)..add(AppLoaded());
                    },
                    child: LoginStandardScreen(),
                  ),
                ),
            CloudFirestoreScreen.routeName: (ctx) => CloudFirestoreScreen(),
            FirebaseStorageScreen.routeName: (ctx) => FirebaseStorageScreen(),
            ShimmerEffectScreen.routeName: (ctx) => ShimmerEffectScreen(),
            OneSignalNotificationScreen.routeName: (ctx) =>
                OneSignalNotificationScreen(),
            ApplicationLifecycleStateScreen.routeName: (ctx) =>
                ApplicationLifecycleStateScreen(),
            BiometricScreen.routeName: (ctx) => BiometricScreen(),
            //CONTOH PENGGUNAAN CUBIT PROVIDER
            CubitStateScreen.routeName: (ctx) => BlocProvider(
                create: (context) => CountercubitCubit(),
                child: CubitStateScreen()),
            ReplayBlocScreen.routeName: (ctx) => ReplayBlocScreen(),
            FutureProviderScreen.routeName: (ctx) => FutureProviderScreen(),
            StreamProviderScreen.routeName: (ctx) => StreamProviderScreen(),
            FutureProviderBuilderScreen.routeName: (ctx) =>
                FutureProviderBuilderScreen(),
            GreatPlacesScreen.routeName: (ctx) => GreatPlacesScreen(),
            AddPlaceScreen.routename: (ctx) => AddPlaceScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
            CameraGuideScreen.routeName: (ctx) => CameraGuideScreen(),
            //MapHereScreen.routeName: (ctx) => MapHereScreen(),
            LocationRealScreen.routeName: (ctx) => LocationRealScreen(),
            SlidableScreen.routeName: (ctx) => SlidableScreen(),
          },
        ),
      ),
    );
  }
}
