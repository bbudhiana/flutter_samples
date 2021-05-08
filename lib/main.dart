import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/bindings/auth_bind.dart';
import 'package:flutter_samples/bindings/infinite_bind.dart';
import 'package:flutter_samples/bindings/infinite_bind_dua.dart';
import 'package:flutter_samples/bloc/authentication_bloc.dart';
import 'package:flutter_samples/bloc/counterthree_bloc.dart';
//import 'package:flutter_samples/bloc/infiniteversion2/post_bloc_version2.dart';
import 'package:flutter_samples/camera_guide_screen.dart';
import 'package:flutter_samples/controllers/infinite_controller.dart';
import 'package:flutter_samples/infinite_loading_getx_screen.dart';
import 'package:flutter_samples/infinite_loading_getx_screen_dua.dart';
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

class MyHomePage extends StatelessWidget {
  final String title;
  int _i = 1;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListSubject(
            number: _i++,
            title: 'Post With HTTP',
            subTitle: 'Post With HTTP',
            iconSubject: Icons.add,
            route: PostScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Get With HTTP',
            subTitle: 'Melakukan Get dengan HTTP, dari https://reqres.in/',
            iconSubject: Icons.get_app,
            route: GetScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Get Many With HTTP',
            subTitle: 'Melakukan Get many dengan HTTP, dari https://reqres.in/',
            iconSubject: Icons.all_out,
            route: GetManyScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Try Widget',
            subTitle: 'Testing Widget',
            iconSubject: Icons.event,
            route: TryWidgetScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Switch Sample',
            subTitle: 'Switch Sample',
            iconSubject: Icons.switch_camera,
            route: SwitchScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Share Preferences',
            subTitle: 'Untuk simpan data simple',
            iconSubject: Icons.stay_primary_landscape,
            route: SharedPreferencesScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Provider State Management',
            subTitle: 'Untuk contoh Provider State Management',
            iconSubject: Icons.system_update,
            route: StateManagementScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Bloc State Management 1 - tanpa library',
            subTitle: 'Bloc 1',
            iconSubject: Icons.block,
            route: BlocOneScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Bloc State Management 2 - with library and hydrated',
            subTitle: 'Bloc 2',
            iconSubject: Icons.block,
            route: BlocTwoScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Bloc State Management 3 - update version 6.1.1',
            subTitle: 'Bloc 3',
            iconSubject: Icons.block,
            route: BlocThreeScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Timer',
            subTitle: 'Menggunakan Timer',
            iconSubject: Icons.timer,
            route: TimerScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Progress Bar with Provider and Timer',
            subTitle:
                'Membuat Progress Bar dengan kombinasi Provider dan Timer',
            iconSubject: Icons.timer,
            route: ProgressBarProvider.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Card with message',
            subTitle: 'Membuat Widget Dard dengan Message',
            iconSubject: Icons.timer,
            route: CardWithMessageScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Listview Builder and BLoC',
            subTitle: 'Listview dengan BLoC',
            iconSubject: Icons.list,
            route: ListviewBlocScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'MVVM with BLoC',
            subTitle: 'Menggunakan MVVM dengan BLoC',
            iconSubject: Icons.block,
            route: MvvmScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'MultiBLoC in Multipage',
            subTitle: 'Multi BLoC dalam aplikasi Multipage',
            iconSubject: Icons.rowing,
            route: MultiblocScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Dropdown',
            subTitle: 'Contoh penggunaan Dropdown',
            iconSubject: Icons.arrow_drop_down,
            route: DropdownScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Hive - Database Lokal',
            subTitle: 'Menggunakan Hive sebagai database lokal',
            iconSubject: Icons.data_usage,
            route: HiveScreen.routeName,
          ),
          /* ListSubject(
            number: _i++,
            title: 'Infinite Loading with Future Builder',
            subTitle: 'List infinite menggunakan Future Builder',
            iconSubject: Icons.info_outline,
            route: 3671094901800003BuilderScreen.routeName,
          ), */
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with BLoC',
            subTitle: 'List infinite menggunakan BLoC',
            iconSubject: Icons.info_outline,
            route: InfiniteLoadingScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with BLoC',
            subTitle: 'List infinite menggunakan BLoC - Version 2',
            iconSubject: Icons.info_outline,
            route: InfiniteLoadingScreen2.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with BLoC Cubit',
            subTitle: 'List infinite menggunakan BLoC Cubit',
            iconSubject: Icons.info_outline,
            route: InfiniteLoadingCubitScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with GetX',
            subTitle: 'List infinite menggunakan GetX',
            iconSubject: Icons.get_app,
            //route: InfiniteLoadingGetxScreen.routeName,
            route: '/infinite-loading-getx',
          ),
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with GetX versi 2',
            subTitle:
                'List infinite menggunakan GetX, dengan struktur file yang baik',
            iconSubject: Icons.get_app,
            //route: InfiniteLoadingGetxScreen.routeName,
            route: '/infinite-loading-getx-dua',
          ),
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with GetX versi 3',
            subTitle:
                'List infinite menggunakan Obx, dengan struktur file yang baik',
            iconSubject: Icons.get_app,
            //route: InfiniteLoadingGetxScreen.routeName,
            route: '/infinite-loading-getx-tiga',
          ),
          ListSubject(
            number: _i++,
            title: 'Infinite Loading with BLoC Cubit',
            subTitle: 'List infinite menggunakan BLoC Cubit - Select',
            iconSubject: Icons.info_outline,
            route: InfiniteLoadingCubitSelectScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Mobx State Management',
            subTitle: 'State Management lain yang menarik',
            iconSubject: Icons.satellite,
            route: MobxStateScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Division - Custom Widget',
            subTitle: 'Membuat Widget Seperti halnya CSS di web',
            iconSubject: Icons.satellite,
            route: DivisionScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Slider - Page View',
            subTitle: 'Widget Slider dengan menggunakan page view',
            iconSubject: Icons.satellite,
            route: SliderPageviewScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Slider - Transition',
            subTitle: 'Widget Slider dengan menggunakan transition',
            iconSubject: Icons.satellite,
            route: SliderTransitionScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Rive - Flutter',
            subTitle: 'Menggunakan animasi rive.app dengan flutter',
            iconSubject: Icons.satellite,
            route: RiveFlutterScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Google Font - Cara Gunakan',
            subTitle: 'Menggunakan google font secara efektif untuk coba font',
            iconSubject: Icons.font_download,
            route: GoogleFontScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Login with Firebase - anonymous and email-pass',
            subTitle:
                'Login menggunakan firebase, baik anonymous atau email-pass',
            iconSubject: Icons.vpn_key,
            route: LoginFirebaseScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Login Standard - using email and pass',
            subTitle: 'Login standard menggunakan email dan password',
            iconSubject: Icons.vpn_key,
            route: LoginStandardScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Login Standard - using email and pass - GetX',
            subTitle: 'Login Standard dengan email-pass, dengan GetX',
            iconSubject: Icons.get_app,
            route: '/login-standard-getx',
          ),
          ListSubject(
            number: _i++,
            title: 'Cloud Firestore - database from firebase',
            subTitle: 'Menggunakan database Cloud Firestore',
            iconSubject: Icons.table_chart,
            route: CloudFirestoreScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Firebase Storage - Storage nya Firebase',
            subTitle: 'Menggunakan storage milik firebase',
            iconSubject: Icons.table_chart,
            route: FirebaseStorageScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Shimmef Effect',
            subTitle: 'Efek loading berkilau halaman sebelum buka full',
            iconSubject: Icons.gavel,
            route: ShimmerEffectScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'OneSignal Notification',
            subTitle: 'Menggunakan one signal notification untuk smartphone',
            iconSubject: Icons.signal_cellular_null,
            route: OneSignalNotificationScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Application Lifecycle State dalam Flutter',
            subTitle:
                'Kita lihat berbagai macam state dalam lifecycle milik aplikasi flutter',
            iconSubject: Icons.signal_cellular_null,
            route: ApplicationLifecycleStateScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Biometric in Flutter',
            subTitle: 'Menggunakan authentic local (biometric) dalam Flutter',
            iconSubject: Icons.fingerprint,
            route: BiometricScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Cubit State management',
            subTitle: 'Cubit State Management - Sub dari Bloc',
            iconSubject: Icons.scatter_plot,
            route: CubitStateScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Cubit State management with Replay',
            subTitle: 'Cubit State Management - Dengan implement Replay',
            iconSubject: Icons.replay,
            route: ReplayBlocScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Future Provider Demo',
            subTitle: 'Future Provider Cara Kerja nya',
            iconSubject: Icons.time_to_leave,
            route: FutureProviderScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Stream Provider Demo',
            subTitle: 'Stream Provider Cara Kerja nya',
            iconSubject: Icons.time_to_leave_sharp,
            route: StreamProviderScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Future Provider and FutureBuilder',
            subTitle: 'Cara kerja Future Provider vs FutureBuilder',
            iconSubject: Icons.time_to_leave_rounded,
            route: FutureProviderBuilderScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Great Places - Implement Google Map',
            subTitle: 'Untuk melihat bagaimana Google Map bekerja',
            iconSubject: Icons.replay,
            route: GreatPlacesScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Camera with Guide - Implement Camera',
            subTitle: 'Untuk melihat bagaimana Camera bekerja dengan Guide',
            iconSubject: Icons.camera,
            route: CameraGuideScreen.routeName,
          ),
          /* ListSubject(
            number: _i++,
            title: 'Map - Menggunakan Here Map',
            subTitle: 'Map dengan menggunakan 3rd Party Here.com',
            iconSubject: Icons.map_sharp,
            route: MapHereScreen.routeName,
          ), */
          ListSubject(
            number: _i++,
            title: 'Location - Real Update location of User',
            subTitle: 'Mendeteksi longitude dan latitude secara realt time',
            iconSubject: Icons.location_on,
            route: LocationRealScreen.routeName,
          ),
          ListSubject(
            number: _i++,
            title: 'Slidable Example',
            subTitle: 'Contoh penggunaan slidable di list item',
            iconSubject: Icons.slideshow,
            route: SlidableScreen.routeName,
          ),
        ],
      ),
    );
  }
}
