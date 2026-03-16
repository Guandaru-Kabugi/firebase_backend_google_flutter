// import 'package:flutter/material.dart';
// import 'package:sap/core/design_patterns/my_media.dart';
// import 'package:sap/core/localization/app_localization.dart';
// import 'package:sap/src/presentation/widgets/custom/login_widget.dart';
// import 'package:sap/src/presentation/widgets/shared/asset_image_widget.dart';
// import 'package:sap/src/presentation/widgets/shared/text_widget.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   static const String routeName = '/login-screen';

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context);
//     final theme = Theme.of(context);
//     final size = MediaQuery.of(context).size;

//     //  choose logo based on theme brightness
//     final String logoPath = theme.brightness == Brightness.dark
//         ? MyMedia.smartCompanyLogoDark
//         : MyMedia.smartCompanyLogo;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(height: size.height * 0.02),

//                         // 🔥 dynamic theme-based logo
//                         Center(
//                           child: AssetImageWidget(
//                             logoPath,
//                             width: 0.45,
//                             height: 0.45,
//                             fit: BoxFit.contain,
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         TextWidget(
//                           t?.translate("Sign In") ?? "Sign In",
//                           fontSize: 3.0,
//                           fontWeight: FontWeight.bold,
//                           textColor: theme.colorScheme.onSurface,
//                           textAlign: TextAlign.center,
//                         ),

//                         const Spacer(flex: 2),
//                         const LoginForm(),
//                         const Spacer(flex: 2),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }






// BlocConsumer<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is AuthLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return SafeArea(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                     ),
//                     child: IntrinsicHeight(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(height: size.height * 0.02),

//                             // 🔥 dynamic theme-based logo
//                             Center(
//                               child: AssetImageWidget(
//                                 logoPath,
//                                 width: 0.45,
//                                 height: 0.45,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             TextWidget(
//                               t?.translate("Sign In") ?? "Sign In",
//                               fontSize: 3.0,
//                               fontWeight: FontWeight.bold,
//                               textColor: theme.colorScheme.onSurface,
//                               textAlign: TextAlign.center,
//                             ),

//                             const Spacer(flex: 2),
//                             LoginForm(),
//                             const Spacer(flex: 2),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//         listener: AuthBlocListeners.handleLoginAuthState,
//       ),