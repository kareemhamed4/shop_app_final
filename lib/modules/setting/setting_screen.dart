import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/modules/setting/cubit/cubit.dart';
import 'package:shop_app_final/modules/setting/cubit/states.dart';
import 'package:shop_app_final/modules/user_profile_screen/user_profile_screen.dart';
import 'package:shop_app_final/shared/components/components.dart';
import 'package:shop_app_final/shared/styles/colors.dart';

//ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSettingCubit()..getUserData(),
      child: BlocConsumer<ShopSettingCubit,ShopSettingsStates>(
        listener: (context,state){},
        builder: (context,state){
          Size size = MediaQuery.of(context).size;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {
                        NavigateTo(context: context, widget: UserProfileScreen());
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'User Profile',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.share,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Share app',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.brightness_4,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Dark Mode',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            'Turn on',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: myFavColor3),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Notifications',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            'Turn on',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: myFavColor3),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.ads_click,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Developer Website',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.facebook_outlined,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Developer FaceBook - Business',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.red[100],
                      height: size.height * 0.08,
                      onPressed: () {

                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.facebook_outlined,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Developer FaceBook - Personal',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About App :',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 14,color: myFavColor2),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'A free and non-profit application that competes with Amazon! 😎',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myDivider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'About Developer :',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 14,color: myFavColor2),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Designed, developed and revised by the poor servant of God, Karee〽️ohamed.',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text('All Copyrights © Reserved for Market El-Market.com 2022',style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 9),),
                    Text('Karee〽️ohamed',style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 9,color: myFavColor3),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}