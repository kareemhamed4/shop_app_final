import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/modules/login_screen/login_screen.dart';
import 'package:shop_app_final/modules/setting/cubit/cubit.dart';
import 'package:shop_app_final/modules/setting/cubit/states.dart';
import 'package:shop_app_final/network/local/shared_helper.dart';
import 'package:shop_app_final/shared/components/components.dart';

//ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSettingCubit()..getUserData(),
      child: BlocConsumer<ShopSettingCubit, ShopSettingsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopSettingCubit.get(context).userModel;
          nameController.text = model != null ? model.data!.name! : '';
          emailController.text = model != null ? model.data!.email! : '';
          phoneController.text = model != null ? model.data!.phone! : '';
          return ConditionalBuilder(
            condition: (ShopSettingCubit.get(context).userModel != null),
            builder: (context) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: IconButton(
                        onPressed: () {
                          ShopSettingCubit.get(context).editProfile();
                          if (!ShopSettingCubit.get(context).isEnabled) {
                            ShopSettingCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                            /*Fluttertoast.showToast(
                                msg: "Saved!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red[300],
                                textColor: Colors.white,
                                fontSize: 16.0);*/
                          }
                        },
                        icon: Icon(ShopSettingCubit.get(context).icon)),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (state is ShopUpdateProfileLoadingState)
                      LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.red[300],
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    MyTextFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                      onTap: () {},
                      enabled: ShopSettingCubit.get(context).isEnabled,
                      label: 'User Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MyTextFormField(
                      enabled: ShopSettingCubit.get(context).isEnabled,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        return null;
                      },
                      onTap: () {},
                      label: 'E-mail',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MyTextFormField(
                      enabled: ShopSettingCubit.get(context).isEnabled,
                      controller: phoneController,
                      type: TextInputType.number,
                      validator: (value) {
                        return null;
                      },
                      onTap: () {},
                      label: 'Phone Number',
                      prefix: Icons.phone,
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      child: myMaterialButton(
                        context: context,
                        onTap: () {
                          CacheHelper.removeData(key: 'token');
                          NavigateToReb(
                              context: context, widget: LoginScreen());
                        },
                        label: "Logout",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Scaffold(
                appBar: AppBar(),
                body: const Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }
}
