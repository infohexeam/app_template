import 'dart:io';

String packageName = "alsarhan";
List<String> moduleData = [
  "splash",
  "login",
  "register",
  "forgot_password",
  "home_page",
  "landing_page",
  "product_listing",
  "categories",
  "wishlist",
  "cart",
  "orders",
  "returns",
  "coupons",
  "customer_care",
  "product_details",
  "check_out",
  "left_menu",
];

class MakeTemplate {
  static create() {
    createAppConstants();
    print("App constants created ====>");
    createAppColors();
    print("App Colors created ====>");
    createAppTextFields();
    print("App Text Form fields created ====>");
    createAppButtons();
    print("App Buttons created ====>");
    createValidations();
    print("App Validations created ====>");
    createAppSnackBar();
    print("App Snackbar created ====>");
    createApiServices();
    print("App Api services created ====>");
    createAppAssets(type: "icons");
    print("App icons created ====>");
    createAppAssets(type: "images");
    print("App images created ====>");
    moduleData.sort();
    createAppPages();
    print("AppPages created ====>");
    createAppExtensions();
    print("AppExtensions created ====>");
    createAppNetworkImage();
    print("App Network Image created ====>");
    createAppRoutes();
    print("AppRoutes created ====>");
    for (String module in moduleData) {
      createModules(module);
      print("Module for $module created");
    }
  }
}

createAppPages() {
  String importForAppPages = "";
  String appPagesCode =
      "import 'package:get/get.dart';\nimport '../app_routes/app_routes.dart';\nclass AppPages { \nstatic List<GetPage> appPages = <GetPage>[\n\n";
  for (String module in moduleData) {
    createModules(module);
    importForAppPages +=
        createAppPagesImports(packageName: packageName, module: module);
    appPagesCode += createGetPages(module: module);
  }
  appPagesCode += "];}";
  Directory("lib/app_pages").createSync(recursive: true);
  String filePathAppPages = "lib/app_pages/app_pages.dart";
  File(filePathAppPages).writeAsString(importForAppPages + appPagesCode);
}

createAppRoutes() {
  Directory("lib/app_routes").createSync(recursive: true);
  String filePathRoutes = "lib/app_routes/app_routes.dart";
  String codeForAppRoutes = "class AppRoutes {\n";
  for (String module in moduleData) {
    createModules(module);
    codeForAppRoutes += createAppRoutesLines(module);
  }
  codeForAppRoutes += "}";
  File(filePathRoutes).writeAsString(codeForAppRoutes);
}

createModules(String module) {
  String subfolderPath = "lib/$module";
  Directory(subfolderPath).createSync(recursive: true);
  createView(subfolderPath: subfolderPath, module: module);
  print("$module view created ===>");
  createController(subfolderPath: subfolderPath, module: module);
  print("$module controller created ===>");
  createModel(subfolderPath: subfolderPath, module: module);
  print("$module model created ===>");
}

createView({required String subfolderPath, required String module}) {
  String filePathView = "$subfolderPath/${module}_view.dart";
  File(filePathView).writeAsStringSync('''
   import 'package:flutter/material.dart';
   class ${convertToClassName(module)}Screen extends StatelessWidget {
   const ${convertToClassName(module)}Screen({Key? key}) : super(key: key);
     @override
       Widget build(BuildContext context) {
        return Scaffold(body: Container());
     }
   }
// ''');
}

createController({required String subfolderPath, required String module}) {
  String filePathController = "$subfolderPath/${module}_controller.dart";
  File(filePathController).writeAsStringSync('''
import 'package:get/get.dart';

class ${convertToClassName(module)}ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ${convertToClassName(module)}Controller());
  }
}

class ${convertToClassName(module)}Controller extends GetxController {
  static ${convertToClassName(module)}Controller get to => Get.find();
}
''');
}

createModel({required String subfolderPath, required String module}) {
  String filePathModel = "$subfolderPath/${module}_model.dart";
  File(filePathModel).writeAsStringSync('');
}

String createAppPagesImports(
    {required String packageName, required String module}) {
  return """
import '../$module/${module}_controller.dart';
import '../$module/${module}_view.dart';
""";
}

String createGetPages({required String module}) {
  return """
  GetPage(name: AppRoutes.${convertToSnakeCase(module)},
   page: () => const ${convertToClassName(module)}Screen(),
   binding: ${convertToClassName(module)}ControllerBinding()),
   
""";
}

createApiServices() {
  createAppUrls();
  createApiServiceClass();
}

createAppUrls() {
  String urlFilePath = 'api_services/app_urls';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln('class AppUrls {\n static const String base = "";\n}');

  Directory("lib/api_services/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppConstants() {
  String urlFilePath = 'app_constants/app_constants';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer
      .writeln('class BoxKeys {\n static const String token = "token";\n}');

  Directory("lib/app_constants/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppExtensions() {
  String urlFilePath = 'app_extensions/app_extensions';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
      import 'package:intl/intl.dart';

extension StringExtension on String? {
  String changeDateFormat({String? fromFormat, String? toFormat}) =>
      this == null
          ? ""
          : DateFormat(toFormat ?? "yyyy-MM-dd")
              .format(DateFormat(fromFormat ?? "dd / MMM / yyyy").parse(this!));
  DateTime changeToDate({String? fromFormat}) =>
      DateFormat(fromFormat ?? "dd / MMM / yyyy").parse(this!);
}

extension DateTimeExtensions on DateTime {
  String changeDateFormat({String? format}) =>
      DateFormat(format ?? "yyyy-MM-dd").format(this);
}

      """);

  Directory("lib/app_extensions/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppColors() {
  String urlFilePath = 'app_colors/app_colors';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
  import 'dart:ui';
  
class AppColors {
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color black = const Color.fromRGBO(0, 0 ,0, 1);

}
""");
}

createAppTextFields() {
  String urlFilePath = 'text_form_fields/text_form_fields';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
import '../assets/icons.dart';
import '../app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AppTextFormField extends StatelessWidget {
  final String header;
  final String? hint;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? obscureText;
  final String? placeHolder;
  String? errorText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  AppTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      this.onChanged,
      this.maxLines,
      this.obscureText,
      this.maxLength,
      this.minLines,
      this.errorText,
      this.placeHolder,
      this.hint,
      required this.header,
      this.textInputType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(fontSize: 20.sp, color: AppColors.black),
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      smartDashesType: SmartDashesType.enabled,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
        labelText: header,
        hintText: hint,
        errorText: (errorText ?? "").isEmpty ? null : errorText,
      ),
    );
  }
}

class AppTextFormFieldPassword extends StatelessWidget {
  final String header;
  final String? hint;
  final int? maxLInes;
  final int? minLines;
  final int? maxLength;
  final String? placeHolder;

  String? errorText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  AppTextFormFieldPassword(
      {super.key,
      required this.controller,
      this.validator,
      this.maxLInes,
      this.maxLength,
      this.minLines,
      this.errorText,
      this.placeHolder,
      this.hint,
      required this.header,
      this.textInputType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    RxBool obscureText = true.obs;
    return Obx(() {
      return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        onChanged: (value) {
          errorText = "";
          value.replaceAll(" ", "");
        },
        style: TextStyle(fontSize: 20.sp, color: AppColors.black),
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        smartDashesType: SmartDashesType.enabled,
        maxLines: maxLInes ?? 1,
        minLines: minLines ?? 1,
        obscureText: obscureText.value,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: "",
          labelText: header,
          hintText: hint,
          alignLabelWithHint: true,
          errorText: (errorText ?? "").isEmpty ? null : errorText,
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    obscureText.value = !obscureText.value;
                  },
                  child: obscureText.value
                      ? SvgPicture.asset(
                          AppIcons.eyeClosed,
                          height: 20.sp,
                        )
                      : SvgPicture.asset(
                          AppIcons.eyeOpen,
                          height: 20.sp,
                        )),
            ],
          ),
        ),
      );
    });
  }
}

class AppDatePickerFormField extends StatelessWidget {
  final String header;
  final String? placeHolder;
  final String? label;
  final bool? readOnly;
  final void Function()? readOnlyCallBack;
  final DateTime? initialDate;
  final Widget? icon;
  final DateTime? lastDate;
  final DateTime? startDate;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppDatePickerFormField(
      {super.key,
      required this.header,
      this.readOnly,
      this.readOnlyCallBack,
      this.placeHolder,
      this.icon,
      this.initialDate,
      this.lastDate,
      this.startDate,
      required this.controller,
      this.label,
      this.validator});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("d / MMM / yyyy");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (readOnly ?? false)
              ? readOnlyCallBack
              : () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: startDate ?? DateTime(1998),
                      lastDate: lastDate ?? DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      helpText: label,
                      initialDate: initialDate ?? startDate ?? DateTime.now());

                  if (date != null) {
                    controller.text = dateFormat.format(date);
                  }
                },
          child: IgnorePointer(
            child: TextFormField(
              style: TextStyle(color: AppColors.black, fontSize: 20.sp),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              readOnly: readOnly ?? false,
              validator: validator,
              decoration: InputDecoration(
                isDense: false,
                labelText: header,
                floatingLabelStyle:
                    TextStyle(fontSize: 20.sp, color: AppColors.black),
                labelStyle:
                    TextStyle(fontSize: 20.sp, color: AppColors.black),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: 25.sp,
                  maxWidth: 65.sp,
                ),
                suffixIcon: Container(
                  padding: EdgeInsets.only(right: 13.sp),
                  child: icon ??
                      SvgPicture.asset(
                        AppIcons.calender,
                      ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                ),
                filled: true,
                fillColor: AppColors.white,
             
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppTextFormFieldTime extends StatelessWidget {
  final String placeHolder;
  final String? label;
  final TextEditingController controller;

  const AppTextFormFieldTime({
    super.key,
    required this.placeHolder,
    required this.controller,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
                initialEntryMode: TimePickerEntryMode.input,
                builder: (context, child) => Theme(
                      data: ThemeData(
                        colorScheme: ColorScheme.light(
                          primary: AppColors.black,
                        ),
                      ),
                      child: child!,
                    ),
                context: context,
                initialTime: TimeOfDay.now())
            .then((time) {
          if (time != null) {
            controller.text = time.format(context);
          }
        });
      },
      child: IgnorePointer(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          // validator: (value) =>
          //     Validators.isEmpty(value ?? "", "This field is required"),
          decoration: InputDecoration(
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 05.sp),
              child: Icon(
                Icons.access_time,
                size: 18.sp,
              ),
            ),
            suffixIconConstraints:
                BoxConstraints(maxHeight: 50.sp, maxWidth: 50.sp),
          ),
        ),
      ),
    );
  }
}

class AppDropDownFormField<T> extends StatelessWidget {
  final String header;
  final String? placeHolder;
  final String? errorText;
  final bool? validationNeeded;
  final double? width;
  final bool? readOnly;
  final String? Function(T) label;
  final T? value;
  final String? Function(T?)? validator;
  final void Function(T?)? onChange;
  final List<T> itemList;

  const AppDropDownFormField(
      {super.key,
      required this.header,
      required this.onChange,
      required this.value,
      required this.itemList,
      this.errorText,
      this.width,
      this.readOnly,
      this.placeHolder,
      required this.label,
      this.validationNeeded,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        iconSize: 0,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        itemHeight: null,
        isExpanded: true,
        style: TextStyle(fontSize: 20.sp, color: AppColors.black),
        decoration: InputDecoration(
          counterText: "",
          labelText: header,
        ),
        items: itemList
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    label(e) ?? "",
                    style: TextStyle(fontSize: 20.sp, color: AppColors.black),
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChange);
  }
}

""");
  Directory("lib/text_form_fields/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppButtons() {
  String urlFilePath = 'app_buttons/app_buttons';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
  import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors/app_colors.dart';

class SolidButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final bool? isLoading;
  final Color? color;
  final Color? textColor;
  final void Function()? onTap;
  const SolidButton({
    super.key,
    this.text,
    this.height,
    this.child,
    this.fontSize,
    this.width,
    this.radius,
     this.color,
     this.textColor,
    this.onTap,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(5.sp),
              height: (isLoading ?? false) ? 60.sp : height ?? 60.sp,
              width: (isLoading ?? false) ? 60.sp : width ?? 380.sp,
              decoration: BoxDecoration(
                color: color??Colors.white,
                borderRadius: BorderRadius.circular(radius ?? 0.sp),
              ),
              child: Center(
                child: isLoading == true
                    ? CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    : child ??
                        Text(
                          text ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize ?? 20.sp,
                              color: textColor??AppColors.white),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
""");

  Directory("lib/app_buttons/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppNetworkImage() {
  String urlFilePath = 'app_network_image/app_network_image';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors/app_colors.dart';  
  
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? radius;
  final bool? isProfile;
  final BoxFit? fit;
  final bool? dontUseBaseUrl;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.radius,
    this.fit,
    this.dontUseBaseUrl,
    this.isProfile,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Image.network(
      
             imageUrl       ,
        // "https://images.unsplash.com/photo-1708616748538-bdd66d6a9e25?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return (isProfile ?? false)
              ? Container(
                  padding: EdgeInsets.all(7.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white),
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    // AppIcons.user,
                    "",
                    color: AppColors.white,
                    height: (height ?? 50.sp) - 14,
                    width: (width ?? 50.sp) - 14,
                  ),
                )
              : Icon(
                  Icons.broken_image_rounded,
                  color: AppColors.black,
                );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        height: height,
        fit: fit ?? BoxFit.fill,
        width: width ?? 50.sp,
      ),
    );
  }
}

""");

  Directory("lib/app_network_image/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createValidations() {
  String urlFilePath = 'validations/validations';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""

class Validators {
  //check is the given string is empty or not
  static String? isEmpty(String value, String? errorText) {
    if (value.isEmpty) {
      return errorText ?? "This field is required";
    } else {
      return null;
    }
  }

  //check is the given string is email or not
  static String? isEMail(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }
   //check is the given 2 string are same
  static String? isSameAs(
      {required String? value,
      required String? confirmText,
      String? errorText}) {
    if ((value ?? "").isEmpty) {
      return "This field is required";
    } else if (value != confirmText) {
      return errorText ?? "Both field has to be same";
    } else {
      return null;
    }
  }
  //check is the given string is ,mobile or not
  static String? isMobile(String value, int minLength, int maxLength) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.length > maxLength) {
      return "Please enter a valid mobile number";
    } else if (value.length < minLength) {
      return "Please enter a valid mobile number";
    } else {
      return null;
    }
  }

//check is the given string is valid password or not
  static String? isPassword(String value) {
    if (value.isEmpty) return 'Please enter a new password';
    if (!value.contains(RegExp(r'[a-z]'))) {
      return "Password should contain at least 1 lower case letter";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password should contain at least 1 upper case letter";
    }
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return "Password should contain at least 1 special character";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password should contain at least 1 number";
    }
    if (value.length <= 8) {
      return "Password should contain at least 8 character";
    }
    return null;
  }
}

""");

  Directory("lib/validations/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppBar() {
  String urlFilePath = 'app_bars/app_bars';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../assets/icons.dart';
import '../assets/images.dart';
import '../color/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double? height;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.height,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [])),
      ),
      bottom: bottom,
      title: Text(title.toUpperCase()),
      actions: (actions ?? [])
          .map((action) => Container(
                padding: EdgeInsets.all(15.sp),
                child: action,
              ))
          .toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70.sp);
}
      """);

  Directory("lib/app_bars/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createAppSnackBar() {
  String urlFilePath = 'snack_bar/snack_bar';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors/app_colors.dart';

class AppSnackBar extends StatelessWidget {
  final String? text;
  const AppSnackBar({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Text(
        text ?? "OOPS Something went wrong",
        style: TextStyle(color: AppColors.white),
      ),
    );
  }
}

  """);
  Directory("lib/snack_bar/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

createApiServiceClass() {
  String urlFilePath = 'api_services/api_services';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln("""
import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'app_urls.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../snack_bar/snack_bar.dart';

      """);
  dartCodeBuffer.writeln("""
  class ApiServices{
  
   static printResponse(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      required http.Response response}) {
    if (kDebugMode) {
      print(Uri.https(AppUrls.base, url, queryParameter ?? {}));
      if (body != null) {
        log("\${Uri.https(AppUrls.base, url)}====>\$body");
      }
      log("\${Uri.https(AppUrls.base, url)}====>\${response.statusCode}");
      log("\${Uri.https(AppUrls.base, url)}====>\${response.body}");
    }
  }

  static checkNetworkConnection() async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          messageText: AppSnackBar(text: "Please check internet Connection")));
      throw Exception("No Network");
    }
  }
  static String getToken() {
      String token = box.read(BoxKeys.token);
  return "Bearer \$token";
}

  // static Future<T> login(Map<String, String> queryParameter) async {
  //        await checkNetworkConnection();
  //   var response =
  //       await http.post(Uri.https(AppUrls.base, AppUrls.login, queryParameter));
  //   printResponse(
  //       url: AppUrls.login, response: response, queryParameter: queryParameter);
  //   if (response.statusCode == 200) {
  //     return loginResponseModelResponseModelFromJson(response.body);
  //   } else {
  //     throw Exception(response.body);
  //   }
  // }
  //
  // static Future<T> purchaseMembershipPackage({required Map<String, dynamic> body}) async {
  //   await checkNetworkConnection();
  //   var response = await http.post(
  //     Uri.https(AppUrls.base, AppUrls.purchaseMembershipPackage),
  //     body: json.encode(body),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': getToken(),
  //     },
  //   );
  //   printResponse(
  //       url: AppUrls.purchaseMembershipPackage, response: response, body: body);
  //   if (response.statusCode == 200) {
  //     return purchaseMembershipPackageResponseModelFromJson(response.body);
  //   } else {
  //     throw Exception(response.body);
  //   }
  // }

}
""");

  Directory("lib/api_services/").createSync(recursive: true);
  File dartFile = File('lib/$urlFilePath.dart');
  dartFile.writeAsStringSync(dartCodeBuffer.toString());
}

String createAppRoutesLines(module) {
  return 'static String ${convertFirstCharacterToLower(convertToClassName(module))} = "/$module";\n';
}

createAppAssets({required String type}) {
  String iconsDirectoryPath = 'assets/$type';
  StringBuffer dartCodeBuffer = StringBuffer();
  dartCodeBuffer.writeln('class App${type.capitalizeFirst()} {\n');
  Directory iconsDirectory = Directory(iconsDirectoryPath);
  if (iconsDirectory.existsSync()) {
    List<FileSystemEntity> files = iconsDirectory.listSync(recursive: true);
    for (FileSystemEntity file in files) {
      dartCodeBuffer.writeln(
          'static String ${convertFirstCharacterToLower(convertToClassName(formatFileName(file)))} = "${file.path}";');
    }
    dartCodeBuffer.writeln('\n}');
    Directory("lib/assets/").createSync(recursive: true);
    File dartFile = File('lib/assets/$type.dart');
    dartFile.writeAsStringSync(dartCodeBuffer.toString());
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}

/// Converts the first character of a string to lowercase.
String convertFirstCharacterToLower(String string) {
  return string[0].toLowerCase() + string.substring(1);
}

/// Converts a snake_case string to CamelCase.
String convertToClassName(String input) {
  List<String> parts = input.split('_');
  return parts.map((part) => part.capitalizeFirst()).join();
}

/// Converts a snake_case string to camelCase.
String convertToSnakeCase(String input) {
  List<String> parts = input.split('_');
  return parts.first +
      parts.skip(1).map((part) => part.capitalizeFirst()).join();
}

String formatFileName(FileSystemEntity file) {
  String fileName =
      file.path.split(Platform.pathSeparator).last.split('.').first;
  return fileName
      .replaceAll('-', '_')
      .replaceAll(' ', '_')
      .replaceAll('.', '_')
      .toLowerCase();
}
