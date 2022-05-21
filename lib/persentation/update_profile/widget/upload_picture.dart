import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/update_profile/cubit/update_profile_cubit.dart';
import 'package:flutter_shop_store/shared/components/custom_alert_dialog.dart';
import 'package:flutter_shop_store/shared/constants/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/components/custom_divider.dart';
import '../../../shared/constants/colors.dart';

class UploadPictures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final updateProfileCubit = BlocProvider.of<UpdateProfileCubit>(context);
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
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
                      child: updateProfileCubit.tempImage != null
                          ? Image.file(
                              updateProfileCubit.tempImage!,
                              height: 115,
                              width: 115,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
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
                                size: 120,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          height: 200,
                          widget: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomDivider(thickness: 1),
                                ListTile(
                                  leading: const Icon(
                                    Icons.add_photo_alternate_outlined,
                                  ),
                                  title: TextButton(
                                    child: const Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: mainColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      updateProfileCubit.getImageFromGallery();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.add_a_photo_outlined,
                                  ),
                                  title: TextButton(
                                    child: const Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: mainColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      updateProfileCubit.getImageFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/add_icon.svg',
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
