import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_final/layout/home_layout.dart';
import 'package:shop_app_final/modules/login_screen/login_screen.dart';
import 'package:shop_app_final/modules/signup_screen/cubit/cubit/cubit.dart';
import 'package:shop_app_final/modules/signup_screen/cubit/states/states.dart';
import 'package:shop_app_final/network/local/shared_helper.dart';
import 'package:shop_app_final/shared/components/components.dart';
import 'package:shop_app_final/shared/components/constants.dart';

//ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => ShopSignUpCubit(),
      child: BlocConsumer<ShopSignUpCubit, ShopSignUpStates>(
        listener: (context, state) => {
          if (state is ShopSignUpSuccessState)
            {
              if (state.signup.status!)
                {
                  CacheHelper.saveData(
                      key: "token", value: state.signup.data!.token)
                      .then((value) {
                    token = state.signup.data!.token!;
                    NavigateToReb(
                        context: context, widget: const HomeShopScreen());
                  }),
                }
              else
                {
                  Fluttertoast.showToast(
                      msg: "${state.signup.message}",
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
          ShopSignUpCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/newsignup.svg",
                            height: size.height * 0.2,
                            width: size.width * 0.5,
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          MyTextFormField(
                            onSubmit: (value) {
                              nameController.text = value.toString();
                            },
                            controller: nameController,
                            type: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                            onTap: () {},
                            label: "User name",
                            prefix: Icons.tag_faces,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          MyTextFormField(
                            onSubmit: (value) {
                              emailController.text = value.toString();
                            },
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              return null;
                            },
                            onTap: () {},
                            label: "E-mail",
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
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
                              cubit.changeSignUpSuffixIcon();
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          MyTextFormField(
                            onSubmit: (value) {
                              phoneController.text = value.toString();
                            },
                            controller: phoneController,
                            type: TextInputType.number,
                            validator: (value) {
                              return null;
                            },
                            onTap: () {},
                            label: "phone",
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: ShopSignUpCubit.get(context).isCheckBox,
                                  onChanged: (value) {
                                    ShopSignUpCubit.get(context).changeCheckBox();
                                  },
                                ),
                                Text(
                                  "I Accept to",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                myTextButton(
                                  context: context,
                                    onTap: () {
                                      NavigateTo(
                                          context: context,
                                          widget: LoginScreen());
                                    },
                                    label: "Privacy"),
                                Text(
                                  "&",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                myTextButton(
                                  context: context,
                                    onTap: () {
                                      NavigateTo(
                                          context: context,
                                          widget: LoginScreen());
                                    },
                                    label: "Terms & Conditions",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopSignUpLoadingState,
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
                                    ShopSignUpCubit.get(context).userModel(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                    );
                                  }
                                },
                                label: "SIGN UP",
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
                            height: size.height * 0.004,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "already have an account ?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "KareemR",
                                    fontSize: 12),
                              ),
                              myTextButton(
                                context: context,
                                label: "SIGN IN",
                                onTap: ()
                                {
                                  NavigateTo(context: context, widget: LoginScreen());
                                }
                              ),
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
                                  onPressed: () {},
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
            ),
          );
        },
      ),
    );
  }
}
