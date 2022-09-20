import 'package:flutter/material.dart';
import 'package:shop_app_final/shared/styles/colors.dart';

// ignore: non_constant_identifier_names
Future NavigateToReb({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));

// ignore: non_constant_identifier_names
Future NavigateTo({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  final Function onTap;
  final Function? suffixPressed;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  final TextEditingController controller;
  final TextInputType type;
  FormFieldValidator<String>? validator;
  final double? radius;
  final IconData? prefix;
  final IconData? suffix;
  String? label;
  bool isPassword;
  bool enabled;
  MyTextFormField(
      {required this.controller,
      required this.type,
      required this.validator,
      required this.onTap,
      this.suffixPressed,
      this.onSubmit,
      this.onChange,
      this.radius = 10.0,
      this.prefix,
      this.label = '',
      this.suffix,
      this.isPassword = false,
      this.enabled = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        onTap();
      },
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      controller: controller,
      keyboardType: type,
      enabled: enabled,
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "$label must not be empty";
        }
        return null;
      },
      style: Theme.of(context).textTheme.subtitle2,
      decoration: InputDecoration(
        filled: false,
        fillColor: Colors.red[100],
        hintText: label,
        hintStyle: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.black54),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        floatingLabelStyle: TextStyle(color: myFavColor2),
        prefixIcon: Icon(
          prefix,
          color: Colors.redAccent,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
            color: Colors.redAccent,
          ),
          onPressed: () {
            suffixPressed!();
          },
        ),
        label: Text(
          label!,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}

Widget myMaterialButton({
  required BuildContext context,
  required String label,
  required Function onTap,
}) =>
    MaterialButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white, fontSize: 16),
      ),
    );

Widget myTextButton(
        {required BuildContext context,
        required String label,
        required Function onTap,
        double size = 12}) =>
    TextButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 12),
      ),
    );

Widget myDivider() => Container(
  color: myFavColor4,
  height: 1,
);

Widget defaultMaterialButton({
  required Size size,
  required BuildContext context,
  IconData? prefixIcon,
  IconData? suffixIcon,
  required String label,
}) =>
    Container(
      color: Colors.white,
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                prefixIcon,
                color: Colors.redAccent,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 16),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    suffixIcon,
                    color: Colors.redAccent,
                  )),
            ],
          ),
        ),
      ),
    );
