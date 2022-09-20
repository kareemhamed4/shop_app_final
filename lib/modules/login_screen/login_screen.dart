import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_final/layout/home_layout.dart';
import 'package:shop_app_final/modules/login_screen/cubit/cubit/cubit.dart';
import 'package:shop_app_final/modules/login_screen/cubit/states/states.dart';
import 'package:shop_app_final/modules/signup_screen/signup_screen.dart';
import 'package:shop_app_final/network/local/shared_helper.dart';
import 'package:shop_app_final/shared/components/components.dart';
import 'package:shop_app_final/shared/components/constants.dart';

//ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) => {
          if (state is ShopLoginSuccessState)
            {
              if (state.loginModel.status!)
                {
                  CacheHelper.saveData(
                          key: "token", value: state.loginModel.data!.token)
                      .then((value) {
                    token = state.loginModel.data!.token!;
                    NavigateToReb(
                        context: context, widget: const HomeShopScreen());
                  }),
                }
              else
                {
                  Fluttertoast.showToast(
                      msg: "${state.loginModel.message}",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red[300],
                      textColor: Colors.white,
                      fontSize: 16.0)
                }
            }
        },
        builder: (context, state) {
          ShopLoginCubit cubit = BlocProvider.of(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            "assets/images/newlogin.svg",
                            height: size.height * 0.3,
                            width: size.width * 0.6,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        MyTextFormField(
                          onSubmit: (value) {
                            emailController.text = value.toString();
                          },
                          controller: emailController,
                          type: TextInputType.text,
                          validator: (value) {
                            return null;
                          },
                          onTap: () {},
                          label: "E-mail",
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        MyTextFormField(
                          onSubmit: (value) {
                            passwordController.text = value.toString();
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            return null;
                          },
                          onTap: () {},
                          label: "Password",
                          prefix: Icons.lock,
                          suffix: cubit.suffixIcon,
                          isPassword: cubit.isPassword,
                          suffixPressed: () {
                            cubit.changeLoginSuffixIcon();
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            child: myMaterialButton(
                              context: context,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userModel(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              label: "Login",
                            ),
                          ),
                          fallback: (context) => Container(
                            height: size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            child: Center(
                                child: Transform.scale(
                                    scale: 0.5,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account ?",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            myTextButton(
                                context: context,
                                label: "SIGN UP",
                                onTap: () {
                                  NavigateTo(
                                      context: context, widget: SignUpScreen());
                                })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    'assets/images/facebook icon.png')),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            IconButton(
                                onPressed: () {
                                  CacheHelper.clearData();
                                },
                                icon: Image.asset(
                                    'assets/images/instagram icon.png')),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                    'assets/images/twitter icon.png')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
