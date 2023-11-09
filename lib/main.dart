import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/components/body_data_chart.dart';
import 'package:mobileapp/components/time_zone_manager.dart';
import 'package:mobileapp/converter.dart';
import 'package:mobileapp/pages/account/developer_profile.dart';
import 'package:mobileapp/pages/account/login_page.dart';
import 'package:mobileapp/pages/account/profile_page.dart';
import 'package:mobileapp/pages/account/register_page.dart';
import 'package:mobileapp/pages/account/register_password_page.dart';
import 'package:mobileapp/pages/home_page.dart';
import 'package:mobileapp/pages/standard_page.dart';
import 'package:mobileapp/pages/tools/add_time_zone.dart';
import 'package:mobileapp/pages/tools/advanced_calculator.dart';
import 'package:mobileapp/pages/tools/b_m_i_calculator.dart';
import 'package:mobileapp/pages/tools/b_m_i_result_show.dart';
import 'package:mobileapp/pages/tools/body_data_record_page.dart';
import 'package:mobileapp/pages/tools/grade_calculator.dart';
import 'package:mobileapp/pages/tools/konversi_mata_uang.dart';
import 'package:mobileapp/pages/tools/konversi_satuan.dart';
import 'package:mobileapp/pages/tools/konversi_teks.dart';
import 'package:mobileapp/pages/tools/timer_tool.dart';
import 'package:mobileapp/pages/tools_page.dart';
import 'package:mobileapp/tool_manager.dart';
import 'package:mobileapp/user_manager.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const kHomePage = 'home';
const kHomePageAddTimeZone = 'home:addtimezone';
const kToolsPage = 'tools';
const kToolsBMIPage = 'tools:bmi';
const kToolsBMIShowPage = 'tools:bmi_result_show';
const kToolsGradePage = 'tools:grade';
const kToolsCalculatorPage = 'tools:calculator';
const kToolsTimerPage = 'tools:timer';
const kToolsTemperaturePage = 'tools:temperature';
const kToolsLengthPage = 'tools:length';
const kToolsWeightPage = 'tools:weight';
const kToolsCurrencyConverterPage = 'tools:currency_converter';
const kToolsFileSizeConverterPage = 'tools:file_size_converter';
const kToolsTimeConverterPage = 'tools:time_converter';
const kToolsNumberConverterPage = 'tools:number_converter'; // hex, bin, dec
const kDeveloperPage = 'developer_page';
const kBodyDataRecord = 'body_data';
const kProfilePage = 'profile';
const kLoginPage = 'login';
const kRegisterPage = 'register';
const kRegisterPasswordPage = 'register:password';
const kTitles = [
  'Dashboard',
  'Tools',
  'Profile',
];

class _MyAppState extends State<MyApp> {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _navigatorKeys = {
    kHomePage: GlobalKey<NavigatorState>(),
    kToolsPage: GlobalKey<NavigatorState>(),
    kProfilePage: GlobalKey<NavigatorState>(),
  };

  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = _buildRouter();
  }

  GoRouter _buildRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, navigationShell) {
            return MaterialPage(
              child: StandardPage(
                navigationShell: navigationShell,
              ),
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _navigatorKeys[kHomePage]!,
              routes: [
                GoRoute(
                    path: '/',
                    name: kHomePage,
                    builder: (context, state) => const HomePage(),
                    routes: [
                      GoRoute(
                        path: 'addtimezone',
                        name: kHomePageAddTimeZone,
                        builder: (context, state) => const AddTimeZone(),
                      )
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _navigatorKeys[kToolsPage]!,
              routes: [
                GoRoute(
                    path: '/tools',
                    name: kToolsPage,
                    builder: (context, state) => const ToolsPage(),
                    routes: [
                      GoRoute(
                        path: 'bmi',
                        name: kToolsBMIPage,
                        builder: (context, state) => BMICalculator(),
                      ),
                      GoRoute(
                        path: 'bmi_result',
                        name: kToolsBMIShowPage,
                        builder: (context, state) => BMIResultShow(
                            weightKg: double.parse(
                                state.uri.queryParameters['weight']!),
                            heightCm: double.parse(
                                state.uri.queryParameters['height']!)),
                      ),
                      GoRoute(
                        path: 'grade',
                        name: kToolsGradePage,
                        builder: (context, state) => GradeCalculator(),
                      ),
                      GoRoute(
                        path: 'calculator',
                        name: kToolsCalculatorPage,
                        builder: (context, state) => AdvancedCalculator(),
                      ),
                      GoRoute(
                        path: 'timer',
                        name: kToolsTimerPage,
                        builder: (context, state) => TimerTool(),
                      ),
                      GoRoute(
                        path: 'temperature',
                        name: kToolsTemperaturePage,
                        builder: (context, state) => KonversiSatuan(
                            title: 'Konversi Suhu',
                            conversion: temperatureConversion,
                            icon: const Icon(Icons.thermostat_outlined)),
                      ),
                      GoRoute(
                        path: 'length',
                        name: kToolsLengthPage,
                        builder: (context, state) => KonversiSatuan(
                            title: 'Konversi Panjang',
                            conversion: lengthConversion,
                            icon: const Icon(Icons.straighten_outlined)),
                      ),
                      GoRoute(
                        path: 'weight',
                        name: kToolsWeightPage,
                        builder: (context, state) => KonversiSatuan(
                            title: 'Konversi Berat',
                            conversion: massConversion,
                            icon: const Icon(Icons.line_weight_outlined)),
                      ),
                      GoRoute(
                        path: 'currency_converter',
                        name: kToolsCurrencyConverterPage,
                        builder: (context, state) => KonversiMataUang(
                            title: 'Konversi Mata Uang',
                            conversion: currencyConversion,
                            icon: const Icon(Icons.money_outlined)),
                      ),
                      GoRoute(
                        path: 'file_size_converter',
                        name: kToolsFileSizeConverterPage,
                        builder: (context, state) => KonversiSatuan(
                            title: 'Konversi Ukuran File',
                            conversion: digitalStorageConversion,
                            icon: const Icon(Icons.sd_storage_outlined)),
                      ),
                      GoRoute(
                        path: 'time_converter',
                        name: kToolsTimeConverterPage,
                        builder: (context, state) => KonversiSatuan(
                            title: 'Konversi Waktu',
                            conversion: timeConversion,
                            icon: const Icon(Icons.timer_outlined)),
                      ),
                      GoRoute(
                        path: 'number_converter',
                        name: kToolsNumberConverterPage,
                        builder: (context, state) => KonversiTeks(
                            title: 'Konversi Sistem Bilangan',
                            conversion: numberConversion,
                            icon: const Icon(Icons.numbers)),
                      ),
                      GoRoute(
                        path: 'body_record',
                        name: kBodyDataRecord,
                        builder: (context, state) {
                          return const BodyDataRecordPage();
                        },
                      )
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _navigatorKeys[kProfilePage]!,
              routes: [
                GoRoute(
                    path: '/profile',
                    name: kProfilePage,
                    builder: (context, state) => const ProfilePage(),
                    routes: [
                      GoRoute(
                        path: 'login',
                        name: kLoginPage,
                        builder: (context, state) {
                          return LoginPage();
                        },
                      ),
                      GoRoute(
                        path: 'register',
                        name: kRegisterPage,
                        builder: (context, state) {
                          return RegisterPage();
                        },
                      ),
                      GoRoute(
                        path: 'about',
                        name: kDeveloperPage,
                        builder: (context, state) => DeveloperProfile(),
                      ),
                      GoRoute(
                        path: 'registerpassword',
                        name: kRegisterPasswordPage,
                        builder: (context, state) {
                          return RegisterPasswordPage(
                            email: state.uri.queryParameters['email'] ?? '',
                          );
                        },
                      )
                    ]),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BodyDataManager(
      child: UserManager(
        child: ToolsManager(
          child: TimeZoneManager(
            child: MaterialApp.router(
              routerConfig: _router,
              title: 'Flutter Demo',
              theme: ThemeData.dark(
                useMaterial3: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
