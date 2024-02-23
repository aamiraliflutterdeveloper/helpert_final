import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/common_widgets/specialist_widget.dart';
import 'package:helpert_app/common_widgets/textfield/search_textformfield.dart';
import 'package:helpert_app/features/home/bloc/speciality_state.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../other_user_profile/screens/other_profile_screen.dart';
import '../bloc/speciality_bloc.dart';
import '../models/specialists_model.dart';

class SpecialistScreen extends StatefulWidget {
  const SpecialistScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistScreen> createState() => _SpecialistScreenState();
}

class _SpecialistScreenState extends State<SpecialistScreen> {
  List<SpecialistsModel> _foundSpecialists = [];
  List<SpecialistsModel> _allUsers = [];

  @override
  initState() {
    super.initState();
    context.read<SpecialityBloc>().fetchSpeciality();
  }

  // void _runSearch(String enteredKeyword) {
  //   List<SpecialistsModel> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = _allUsers;
  //   } else {
  //     results = _allUsers
  //         .where((user) =>
  //             user.username
  //                 .toLowerCase()
  //                 .contains(enteredKeyword.toLowerCase()) ||
  //             user.specialization
  //                 .toLowerCase()
  //                 .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }
  //
  //   // Refresh the UI
  //   setState(() {
  //     _foundSpecialists = results;
  //   });
  // }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Specialists',
      ),
      body: BlocBuilder<SpecialityBloc, SpecialityState>(
        builder: (context, state) {
          if (state is SpecialistLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SpecialistErrorState) {
            return Center(child: Text(state.error));
          } else if (state is SpecialistLoadedState) {
            _allUsers = state.doctorList;
            if (searchController.text.isEmpty) {
              _foundSpecialists = _allUsers;
            }
            return Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchTextFormField(
                      controller: searchController,
                      onChanged: (val) {
                        context.read<SpecialityBloc>().search(val, _allUsers);
                      },
                      hintText: 'Search for Experts or Career advice?',
                      onTap: () {},
                    )),
                const SizedBox(height: 20),
                Expanded(
                  child: _foundSpecialists.isNotEmpty
                      ? SingleChildScrollView(
                          child: SearchUsersList(
                              foundSpecialists: _foundSpecialists,
                              allUsers: _allUsers),
                        )
                      : Text("No results found"),
                ),
              ],
            );
          } else if (state is SearchLoaded) {
            _foundSpecialists = state.foundUsers;
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchTextFormField(
                    controller: searchController,
                    onChanged: (val) {
                      context.read<SpecialityBloc>().search(val, _allUsers);
                    },
                    hintText: 'Search for Experts or Career advice?',
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _foundSpecialists.isNotEmpty
                      ? SingleChildScrollView(
                          child: SearchUsersList(
                              foundSpecialists: _foundSpecialists,
                              allUsers: _allUsers),
                        )
                      : Text("No results found"),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class SearchUsersList extends StatelessWidget {
  const SearchUsersList({
    Key? key,
    required List<SpecialistsModel> foundSpecialists,
    required List<SpecialistsModel> allUsers,
  })  : _foundSpecialists = foundSpecialists,
        _allUsers = allUsers,
        super(key: key);

  final List<SpecialistsModel> _foundSpecialists;
  final List<SpecialistsModel> _allUsers;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16) +
          const EdgeInsets.only(bottom: 30, top: 18),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _foundSpecialists.isEmpty
          ? _allUsers.length
          : _foundSpecialists.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          debugPrint('user id :: ${_foundSpecialists[index].doctorId}');
          NavRouter.push(
              context,
              OtherUserProfileScreen(
                  userId: _foundSpecialists[index].doctorId));
        },
        child: SpecialistWidget(
          name: _foundSpecialists[index].username,
          speciality: _foundSpecialists[index].specialization,
          rating: _foundSpecialists[index].rating,
          reviews: 0,
          image: _foundSpecialists[index].image,
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 4 / 5,
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
    );
  }
}
