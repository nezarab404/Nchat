import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/my_observer.dart';
import 'package:flutter_application_1/shared/storage/shared_helper.dart';
import 'package:flutter_application_1/src/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_application_1/src/login/cubit/login_cubit.dart';
import 'package:flutter_application_1/src/login/login_screen.dart';
import 'package:flutter_application_1/src/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/src/register/cubit/register_cubit.dart';

void main()  {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedHelper.init();
    Widget widget;
    uId = SharedHelper.getData(key: 'uId');

    if (uId != null) {
      widget = const HomeScreen();
    } else {
      widget = LoginScreen();
    }

    runApp(MyApp(startWidget: widget,));
  }, blocObserver: MyBlocObserver());
}


// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp( {required this.startWidget,Key? key}) : super(key: key);
  Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()..getUser()),
      ],
      child: MaterialApp(
        title: 'Chaty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: startWidget,
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var controller = TextEditingController();
//   // ignore: prefer_typing_uninitialized_variables
//   var result;
//   String? verificationId;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "$result",
//             ),
//             MaterialButton(
//                 child: const Text("koko"),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => Scaffold(
//                                 appBar: AppBar(),
//                                 body: const SignInScreen(
//                                   providerConfigs: [
//                                     EmailProviderConfiguration(),
//                                   ],
//                                 ),
//                               )));
//                 }),
//             MaterialButton(
//                 child: const Text("momo"),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => const MyForm()));
//                 }),
//             TextField(
//               controller: controller,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           FirebaseAuth auth = FirebaseAuth.instance;
//           await auth.verifyPhoneNumber(
//             phoneNumber: "+963967547569",
//             timeout: const Duration(seconds: 120),
//             verificationCompleted: (PhoneAuthCredential credential) async {
//               await auth.signInWithCredential(credential);
//               User? user = auth.currentUser;
//               setState(() {
//                 if (user != null) {
//                   result = user.uid;
//                 } else {
//                   result = "nothing";
//                 }
//               });
//             },
//             verificationFailed: (FirebaseAuthException e) {
//               if (e.code == 'invalid-phone-number') {
//                 print('The provided phone number is not valid.');
//               }
//             },
//             codeSent: (String verificationId, int? resendToken) async {
//               // Update the UI - wait for the user to enter the SMS code
//               String smsCode = controller.text;
//               this.verificationId = verificationId;
//               // Create a PhoneAuthCredential with the code
//               PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                   verificationId: verificationId, smsCode: smsCode);

//               // Sign the user in (or link) with the credential
//               await auth.signInWithCredential(credential);
//             },
//             codeAutoRetrievalTimeout: (String verificationId) {},
//           );
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
