import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../route/route_constant.dart';
import '../../../shared/components/custom_card.dart';
import '../../../shared/components/custom_dotedLine.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/components/navigate.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/constant.dart';
import '../cubit/profile_cubit.dart';
import '../widget/user_data.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_sharp, color: mainColor),
        ),
        title: const CustomText(
          text: 'Profile',
          textColor: mainColor,
          fontSize: 20.0,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              width: 500,
              color: white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.3,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            height: 115,
                            width: 115,
                            fit: BoxFit.cover,
                            imageUrl: userData.data.image,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[100]!,
                              highlightColor: Colors.grey[300]!,
                              child: Image.asset(
                                'assets/images/logo.png',
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //user data (name,email phone)
                    UserDataWidget(),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 8.0),
                      child: CustomCard(
                        paddingLeft: 0.0,
                        width: double.infinity,
                        widget: Column(
                          children: [
                            ListTile(
                              onTap: () => navigateTo(
                                context,
                                RouteConstant.updateProfileRoute,
                              ),
                              title: const CustomText(
                                text: 'Edit profile',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              subtitle: const CustomText(
                                text: 'Tap to edit user information',
                                fontSize: 12,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColor,
                                size: 25.0,
                              ),
                            ),
                            const CustomDotedLine(),
                            ListTile(
                              onTap: () => navigateTo(
                                context,
                                RouteConstant.myAddressRoute,
                              ),
                              title: const CustomText(
                                text: 'Add and edit address',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              subtitle: const CustomText(
                                text: 'Tap to add ,delete and update address',
                                fontSize: 12,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColor,
                                size: 25.0,
                              ),
                            ),
                            const CustomDotedLine(),
                            const ListTile(
                              title: CustomText(
                                text: 'change password',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              subtitle: CustomText(
                                text: 'Tap to reset password',
                                fontSize: 12,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColor,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
