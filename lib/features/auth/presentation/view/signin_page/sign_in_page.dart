import 'package:blocpractice1/bloc/auth_bloc/auth_bloc.dart';
import 'package:blocpractice1/core/managers/asset_manager.dart';
import 'package:blocpractice1/core/managers/color_manager.dart';
import 'package:blocpractice1/core/managers/font_manager.dart';
import 'package:blocpractice1/features/auth/presentation/widgets/auth_buttons.dart';
import 'package:blocpractice1/features/home/presentation/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  late VideoPlayerController videoPlayerController;
  bool isChecked = false;
  @override
  void initState() {
    initVideoPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isLoading = true;
          }
          if (state is SuccessState) {
            isLoading = false;
            Get.to(
              const HomePage(),
            );
          }
          if (state is FailureState) {
            isLoading = false;
            GetSnackBar(
              title: state.error,
            );
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Stack(
            children: [
              if (videoPlayerController.value.isInitialized)
                Positioned(
                  height: size.height,
                  width: size.width,
                  child: AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  ),
                )
              else
                Container(),
              signInBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding signInBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SIGN IN',
            style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              color: ColorManager.lightRed,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Row(
            children: [
              Text('DON\'T HAVE AN ACCOUNT? ',
                  style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      color: ColorManager.lightRed)),
              Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.green.shade200,
                  fontFamily: FontConstants.fontFamily,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
          const Divider(
            color: ColorManager.primary,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'CALL SIGN OR EMAIL ADDRESS',
            style: TextStyle(
              color: ColorManager.darkRed,
              fontFamily: FontConstants.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            style: TextStyle(
                color: ColorManager.lightRed,
                fontFamily: FontConstants.fontFamily),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.lightRed)),
                fillColor: ColorManager.primary,
                filled: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.lightRed))),
            controller: _emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          AUTHBUTTONS(
            label: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )
              ],
            ),
            color: ColorManager.lightRed,
            color2: Colors.transparent,
            ontap: () {
              BlocProvider.of<AuthBloc>(context).add(
                LoginEvent(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
            },
          ),
          Row(
            children: [
              Checkbox(
                side: BorderSide(color: ColorManager.darkRed),
                focusColor: Colors.red,
                activeColor: ColorManager.darkRed,
                checkColor: ColorManager.lightRed,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              Text(
                'REMEMBER ME',
                style: TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    color: ColorManager.darkRed,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: ColorManager.primary,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          AUTHBUTTONS(
            label: Row(
              children: [
                Text(
                  'LOGIN WITH WALLET',
                  style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      color: ColorManager.lightRed,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            color: ColorManager.lightRed.withOpacity(0.1),
            color2: Colors.red,
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          AUTHBUTTONS(
            label: Row(
              children: [
                Text(
                  'LOGIN WITH EPIC GAMES',
                  style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      color: ColorManager.lightRed,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            color: ColorManager.lightRed.withOpacity(0.1),
            color2: Colors.red,
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          AUTHBUTTONS(
            label: Row(
              children: [
                Text(
                  'LOGIN WITH STEAM',
                  style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      color: ColorManager.lightRed,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            color: ColorManager.lightRed.withOpacity(0.1),
            color2: Colors.red,
            ontap: () {},
          ),
        ],
      ),
    );
  }

  VideoPlayerController initVideoPlayer() {
    return videoPlayerController = VideoPlayerController.asset(AppAssets.back)
      ..initialize().then((value) => setState(() {
            videoPlayerController.play();
            videoPlayerController.setLooping(true);
          }));
  }
}
