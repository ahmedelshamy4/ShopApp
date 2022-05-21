import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../route/route_constant.dart';
import '../../../shared/components/navigate.dart';
import '../cubit/search_cubit.dart';
import '../../../shared/components/build_item.dart';
import '../../../shared/components/toast.dart';

import '../../../shared/components/custom_divider.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/constants/colors.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 10.0),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: true,
                          onFieldSubmitted: (text) {
                            if (text.isNotEmpty) {
                              searchCubit.getSearchData(text: text);
                            } else {
                              showToast(
                                  message: 'Please Enter name of product',
                                  state: ToastStates.warning);
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: grey,
                              fontFamily: 'RobotoSerif',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          onPressed: () => navigateTo(
                            context,
                            RouteConstant.basketRoute,
                          ),
                          icon: SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: SvgPicture.asset(
                              'assets/icons/basket.svg',
                              fit: BoxFit.fitWidth,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is SearchLoading)
                  const Center(
                    child: CustomLoading(),
                  )
                else if (state is SearchError)
                  const Center(
                    child: CustomText(text: 'Error'),
                  )
                else if (state is SearchSuccess &&
                    searchCubit.searchModel!.data.isEmpty)
                  const Center(
                    child: CustomText(
                      text: 'No result found',
                      textColor: grey,
                    ),
                  )
                else if (state is SearchSuccess &&
                    searchCubit.searchModel!.data.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 70.0,
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) => BuildItem(
                        itemId: searchCubit.searchModel!.data[index].id,
                        model: searchCubit.searchModel!.data[index],
                      ),
                      separatorBuilder: (context, index) =>
                          const CustomDivider(),
                      itemCount: searchCubit.searchModel!.data.length,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
