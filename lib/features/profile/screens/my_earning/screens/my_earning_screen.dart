import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

import '../../../../../common_widgets/components/custom_appbar.dart';
import '../../../bloc/my_earning_bloc.dart';
import '../../../bloc/my_earning_state.dart';
import '../widgets/more_tile_widget.dart';

class MyEarningScreen extends StatefulWidget {
  const MyEarningScreen({Key? key}) : super(key: key);

  @override
  State<MyEarningScreen> createState() => _MyEarningScreenState();
}

class _MyEarningScreenState extends State<MyEarningScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyEarningBloc>().fetchEarning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Earnings'),
      body: BlocBuilder<MyEarningBloc, MyEarningState>(
        builder: (context, state) {
          if (state is MyEarningLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MyEarningErrorState) {
            return Center(child: Text("Something Went Wrong"));
          }
          if (state is MyEarningLoadedState) {
            print(state.myEarningModel.livemode);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text('\$${state.myEarningModel.available[0].amount}',
                      style: TextStyles.mediumTextStyle(
                          textColor: AppColors.acmeBlue, fontSize: 30)),
                  SizedBox(height: 2),
                  Text("Total Earnings",
                      style: TextStyles.regularTextStyle(
                          fontSize: 13, textColor: AppColors.moon)),
                  SizedBox(height: 25),
                  Divider(thickness: 1.5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 15),
                          // Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text("More",
                          //         style: TextStyles.mediumTextStyle(
                          //             fontSize: 18,
                          //             textColor: AppColors.black))),
                          SizedBox(height: 10),
                          MoreTileWidget(
                            title: "Available balance",
                            subTitle:
                                "\$${state.myEarningModel.connectReserved[0].amount}",
                          ),
                          MoreTileWidget(
                            title: "Pending balance",
                            subTitle:
                                "\$${state.myEarningModel.pending[0].amount}",
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
