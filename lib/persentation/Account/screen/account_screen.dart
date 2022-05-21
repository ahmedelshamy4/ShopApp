import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/loading.dart';
import '../../../shared/components/network_disconnected.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../widget/profile_details.dart';
import '../widget/sign_out.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          BlocProvider.of<ProfileCubit>(context).getUserData(),
        ]);
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileError) {
            return NetworkDisconnected(
              onPress: () {
                BlocProvider.of<ProfileCubit>(context).getUserData();
              },
            );
          } else if (state is ProfileLoading) {
            return const Center(child: CustomLoading());
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      // profile
                      ProfileDetails(),
                      const SizedBox(height: 10.0),
                      //sign out
                      SignOut(),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
