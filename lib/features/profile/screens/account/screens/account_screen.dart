import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_without_icon.dart';
import 'package:helpert_app/features/profile/bloc/profile_bloc.dart';
import 'package:helpert_app/features/profile/bloc/profile_state.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:helpert_app/utils/scroll_behavior.dart';

import '../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../common_widgets/custom_dialog.dart';
import '../../../../../common_widgets/image_picker_manager.dart';
import '../../../../../common_widgets/textfield/custom_textformfield.dart';
import '../../../../../common_widgets/textfield/date_textformfield.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../auth/repo/auth_repo.dart';
import '../widgets/change_profile_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final dateController = TextEditingController();
  String? dateError;

  String? userNameError;
  File? requiredFile;

  @override
  void initState() {
    firstNameController.text = AuthRepo.instance.user.firstName;
    lastNameController.text = AuthRepo.instance.user.lastName;
    emailController.text = AuthRepo.instance.user.email;
    userNameController.text = AuthRepo.instance.user.userName;
    dateController.text = AuthRepo.instance.user.date_of_birthday;

    super.initState();
  }

  File? _pickedImage;

  _pickImage() {
    CustomDialogs.showImageSelectionDialog(context, onSelectGallery: () async {
      final pick =
          await ImagePickerManager.getImageFromGallery(context) ?? _pickedImage;
      if (pick != null) {
        setState(() {
          _pickedImage = File(pick.path);
          Navigator.pop(context);
        });
      } else {}
    }, onSelectCamera: () async {
      final pick =
          await ImagePickerManager.getImageFromCamera(context) ?? _pickedImage;
      if (pick != null) {
        setState(() {
          _pickedImage = File(pick.path);
          Navigator.pop(context);
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Account',
      ),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Text("Customize your personal information",
                              style: TextStyles.mediumTextStyle(
                                  fontSize: 11, textColor: AppColors.moon)),
                          SizedBox(height: 20),
                          ChangePictureWidget(
                            pickedImage: _pickedImage,
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            hasPadding: true,
                            errorMessage: userNameError,
                            keyboardType: TextInputType.text,
                            controller: firstNameController,
                            labelText: 'First name',
                            onChanged: (val) {},
                          ),
                          CustomTextFormField(
                            hasPadding: true,
                            errorMessage: userNameError,
                            keyboardType: TextInputType.text,
                            controller: lastNameController,
                            labelText: 'Last name',
                            onChanged: (val) {},
                          ),
                          CustomTextFormField(
                            readOnly: false,
                            hasPadding: true,
                            errorMessage: userNameError,
                            keyboardType: TextInputType.text,
                            controller: emailController,
                            labelText: 'Type your email',
                            onChanged: (val) {},
                          ),
                          CustomTextFormField(
                            readOnly: false,
                            hasPadding: true,
                            errorMessage: userNameError,
                            keyboardType: TextInputType.text,
                            controller: userNameController,
                            labelText: 'Type your Username',
                            onChanged: (val) {},
                          ),
                          DateTextFormField(
                              errorMessage: dateError,
                              keyboardType: TextInputType.text,
                              controller: dateController,
                              labelText: 'When’s your birthday?',
                              onTap: () async {
                                String? selectedDate =
                                    (await DateFormatter.pickDateDialog(
                                        context));
                                if (selectedDate != null) {
                                  setState(() {});
                                  if (DateFormatter.is10YearsOld(
                                      selectedDate)) {
                                    setState(() {
                                      dateController.text = selectedDate;
                                      dateError = null;
                                    });
                                  } else {
                                    setState(() {
                                      dateError =
                                          'You must be at-least 10 years old to continue';
                                    });
                                  }
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileUpdating) {
                          BotToast.showLoading();
                        }
                        if (state is ProfileUpdated) {
                          BotToast.closeAllLoading();
                          NavRouter.pop(context);
                        }
                        if (state is ProfileError) {
                          BotToast.closeAllLoading();
                          BotToast.showText(text: state.error);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButtonWithoutIcon(
                            text: 'Save',
                            onPressed: () {
                              context.read<ProfileBloc>().updateProfile(
                                  AuthRepo.instance.user.email,
                                  AuthRepo.instance.user.userName,
                                  firstNameController.text,
                                  lastNameController.text,
                                  dateController.text,
                                  _pickedImage);
                            });
                      },
                    )),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
