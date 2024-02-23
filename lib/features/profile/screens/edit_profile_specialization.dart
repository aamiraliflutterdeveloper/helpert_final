import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/auth/repo/auth_repo.dart';
import 'package:helpert_app/features/video/model/all_list_model.dart';
import 'package:helpert_app/utils/scroll_behavior.dart';

import '../../../common_widgets/bottons/elevated_button_with_icon.dart';
import '../../../common_widgets/components/custom_appbar.dart';
import '../../../common_widgets/textfield/custom_textformfield.dart';
import '../../../common_widgets/textfield/date_textformfield.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/date_formatter.dart';
import '../../../utils/nav_router.dart';
import '../../auth/screens/register/drop_down_screen.dart';
import '../../auth/widgets/check_box_row.dart';
import '../../auth/widgets/hidden_widget.dart';
import '../bloc/edit_profile_specialization_bloc.dart';
import '../bloc/edit_profile_specialization_state.dart';

class EditProfileSpecialization extends StatefulWidget {
  final int portfolioID;
  final String iam;
  final String specialization;
  final String company;
  final String location;
  final String start_date;
  final String? end_date;
  final int isWorking;
  final String description;
  final int specializationId;
  final int iAm_id;
  final int company_id;
  final bool isFromExperiencePortfolio;
  final AllListModel? allListModel;

  const EditProfileSpecialization(
      {Key? key,
      this.allListModel,
      required this.iam,
      required this.specialization,
      required this.company,
      required this.location,
      this.end_date,
      required this.start_date,
      required this.isWorking,
      required this.description,
      required this.specializationId,
      required this.iAm_id,
      required this.company_id,
      required this.portfolioID,
      required this.isFromExperiencePortfolio})
      : super(key: key);

  @override
  State<EditProfileSpecialization> createState() =>
      _EditProfileSpecializationState();
}

class _EditProfileSpecializationState extends State<EditProfileSpecialization> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final iamController = TextEditingController();
  final specializedController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  bool checkBoxValue = false;
  bool isTOS = false;
  final hiddenIamController = TextEditingController();
  final hiddenSpecializedController = TextEditingController();
  final hiddenCompanyController = TextEditingController();

  // bool _iamTextField = false;
  // bool _specializationTextField = false;
  // bool _companyTextField = false;
  int? iAm_id;
  int? specialization_id;
  int? company_id;
  String? otherCompany;
  String? otherSpecialization;

  @override
  initState() {
    super.initState();
    iamController.text = widget.iam;
    specializedController.text = widget.specialization;
    companyController.text = widget.company;
    locationController.text = widget.location;
    startDateController.text = widget.start_date;
    endDateController.text =
        widget.end_date == null ? 'present' : widget.end_date!;
    checkBoxValue = widget.isWorking == 0 ? false : true;
    descriptionController.text = widget.description;
    iAm_id = widget.iAm_id;
    company_id = widget.company_id;
    specialization_id = widget.specializationId;
    validateButton();
  }

  final _formKey = GlobalKey<FormState>();

  bool isEnable = false;

  void validateButton() {
    bool isValid = true;

    isValid = hiddenIamController.text.isNotEmpty ||
        iamController.text.isNotEmpty &&
            hiddenSpecializedController.text.isNotEmpty ||
        specializedController.text.isNotEmpty &&
            hiddenCompanyController.text.isNotEmpty ||
        companyController.text.isNotEmpty &&
            locationController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            startDateController.text.isNotEmpty &&
            endDateController.text.isNotEmpty;

    setState(() {
      isEnable = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.pureWhite,
      appBar: CustomAppBar(
          title: 'Update Specialisation',
          onBackIconPress: () {
            NavRouter.pop(context, false);
          }),
      body: WillPopScope(
        onWillPop: () async {
          NavRouter.pop(context, false);
          return await Future.value(true);
        },
        child: SafeArea(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                            "Let us know your expertise, so that we find right people & don’t worry, your data will be safe.",
                            style:
                                TextStyle(color: AppColors.moon, fontSize: 14)),
                        const SizedBox(height: 35),
                        CustomTextFormField(
                          readOnly: false,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DropdownScreen(
                                        list: widget.allListModel != null
                                            ? widget.allListModel!.iamListing
                                            : AuthRepo.instance.user.iAmList,
                                        title: 'I am'))).then((value) {
                              if (value != null) {
                                iamController.text = value[0];
                                iAm_id = value[1];
                                setState(() {});
                              }
                            });
                          },
                          keyboardType: TextInputType.text,
                          controller: iamController,
                          labelText: 'I am',
                          onChanged: (value) {
                            setState(() {});
                            validateButton();
                          },
                        ),
                        HiddenWidget(
                          controller: hiddenIamController,
                          visibility:
                              iamController.text.toLowerCase() == 'other'
                                  ? true
                                  : false,
                          hintText: 'Enter Your Expertise',
                          onChanged: (value) {
                            setState(() {});
                            validateButton();
                          },
                        ),
                        SizedBox(
                            height: iamController.text.toLowerCase() == 'other'
                                ? 20
                                : 0),
                        CustomTextFormField(
                            readOnly: false,
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DropdownScreen(
                                              list: widget.allListModel != null
                                                  ? widget.allListModel!
                                                      .specializationListing
                                                  : AuthRepo.instance.user
                                                      .specializationList,
                                              title: 'Specialized In')))
                                  .then((value) {
                                if (value != null) {
                                  specializedController.text = value[0];
                                  specialization_id = value[1];
                                  setState(() {});
                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                            controller: specializedController,
                            labelText: 'Specialized In',
                            onChanged: (val) {
                              setState(() {});
                              validateButton();
                            }),
                        HiddenWidget(
                          onChanged: (val) {
                            setState(() {
                              otherSpecialization = val;
                            });
                            validateButton();
                          },
                          controller: hiddenSpecializedController,
                          visibility:
                              specializedController.text.toLowerCase() ==
                                      'other'
                                  ? true
                                  : false,
                          hintText: 'Enter Your specialization',
                        ),
                        SizedBox(
                            height: specializedController.text.toLowerCase() ==
                                    'other'
                                ? 20
                                : 0),
                        CustomTextFormField(
                            readOnly: false,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DropdownScreen(
                                            list: widget.allListModel != null
                                                ? widget.allListModel!
                                                    .companyListing
                                                : AuthRepo
                                                    .instance.user.companyList,
                                            title: 'Company',
                                          ))).then((value) {
                                if (value != null) {
                                  companyController.text = value[0];
                                  company_id = value[1];
                                  setState(() {});
                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                            controller: companyController,
                            labelText: 'Company',
                            onChanged: (val) {
                              setState(() {});
                              validateButton();
                            }),
                        HiddenWidget(
                          onChanged: (val) {
                            setState(() {
                              otherCompany = val;
                            });
                            validateButton();
                          },
                          controller: hiddenCompanyController,
                          visibility:
                              companyController.text.toLowerCase() == 'other'
                                  ? true
                                  : false,
                          hintText: 'Enter Your Company /Organization',
                        ),
                        SizedBox(
                            height:
                                companyController.text.toLowerCase() == 'other'
                                    ? 20
                                    : 0),
                        CustomTextFormField(
                          keyboardType: TextInputType.text,
                          controller: locationController,
                          labelText: 'Location',
                          onChanged: (val) {
                            setState(() {});
                            validateButton();
                          },
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: DateTextFormField(
                                keyboardType: TextInputType.text,
                                controller: startDateController,
                                labelText: 'Start Date*',
                                onTap: () async {
                                  String? selectedDate =
                                      await DateFormatter.pickDateDialog(
                                          context);
                                  if (selectedDate != null) {
                                    startDateController.text = selectedDate;
                                    setState(() {});
                                    validateButton();
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            if (!checkBoxValue)
                              Flexible(
                                child: DateTextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: endDateController,
                                  labelText: 'End Date*',
                                  onTap: () async {
                                    String? selectedDate =
                                        await DateFormatter.pickDateDialog(
                                            context);
                                    if (selectedDate != null) {
                                      endDateController.text = selectedDate;
                                      setState(() {});
                                      validateButton();
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 20),
                        TOSCheckBox(
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                endDateController.text = 'present';
                              }
                              checkBoxValue = value!;
                            });
                          },
                          title: 'I am currently working here',
                          checkBoxValue: checkBoxValue,
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                            isMaxLines: 8,
                            keyboardType: TextInputType.multiline,
                            controller: descriptionController,
                            labelText: 'Your Experience / Expertise',
                            onChanged: (val) {
                              setState(() {});
                              validateButton();
                            }),
                        TOSCheckBox(
                          onChanged: (value) {
                            setState(() {
                              isTOS = value!;
                            });
                          },
                          title:
                              'By accepting, it means the information you have provided is true to your knowledge.',
                          checkBoxValue: isTOS,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: BlocConsumer<EditProfileSpecializationBloc,
                                      EditProfileSpecializationState>(
                                  listener: (context, state) {
                                if (state is UpdateSpecializationLoading) {
                                  BotToast.showLoading();
                                }
                                if (state is UpdateSpecializationLoaded) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(text: 'Added Successfully');
                                  NavRouter.pop(context);
                                  // NavRouter.pop(context);
                                  // if (widget.isFromExperiencePortfolio == true) {
                                  //   NavRouter.pop(context);
                                  // }
                                }
                                if (state is UpdateSpecializationError) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(text: state.error);
                                }
                              }, builder: (context, state) {
                                return ElevatedButtonWithIconSecond(
                                  onTap: () {
                                    if ((isTOS == true) && (isEnable == true)) {
                                      Map<String, dynamic> userData = {
                                        'update_specialization_id':
                                            widget.portfolioID,
                                        'iam_id': iAm_id,
                                        'specialization_id': specialization_id,
                                        'company_id': company_id,
                                        'other_specialization':
                                            specializedController.text
                                                        .toLowerCase() ==
                                                    'other'
                                                ? otherSpecialization
                                                : null,
                                        'other_company': companyController.text
                                                    .toLowerCase() ==
                                                'other'
                                            ? otherCompany
                                            : null,
                                        'experience': '20',
                                        'description':
                                            descriptionController.text,
                                        'location': locationController.text,
                                        'start_date': startDateController.text,
                                        'currently_working':
                                            checkBoxValue == false ? 0 : 1,
                                        'end_date': checkBoxValue == true
                                            ? null
                                            : endDateController.text,
                                      };

                                      context
                                          .read<EditProfileSpecializationBloc>()
                                          .editSpecialization(userData);
                                      // NavRouter.push(context, InterestScreen());
                                    } else if (isTOS == false) {
                                      BotToast.showText(
                                          text:
                                              'please confirm terms and services');
                                    } else {
                                      BotToast.showText(
                                          text:
                                              'please fill the form correctly');
                                    }
                                  },
                                  onPrimaryColor: AppColors.pureWhite,
                                  primaryColor: isTOS
                                      ? AppColors.acmeBlue
                                      : AppColors.moon.withOpacity(.5),
                                  borderColor: isTOS
                                      ? AppColors.acmeBlue
                                      : AppColors.moon.withOpacity(.01),
                                  isIconAvailable: true,
                                  text: 'Save',
                                  suffixIcon: null,
                                );
                              }),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
