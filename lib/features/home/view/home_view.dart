import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/components/app_overlay.dart';
import '/components/gradient_background_widget.dart';
import '/constants/icons.dart';
import '/core/theme/text_stiles.dart';
import '/features/auth/controller/auth_controller.dart';
import '/features/home/controller/hobby_provider.dart';
import '/features/home/service/home_service.dart';
import '/features/home/widgets/hobby_border_widget.dart';
import '/features/home/widgets/hobby_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hobby = ref.watch(hobbyProvider);

    final homeService = HomeService();

    return hobby.when(
        data: (data) => Material(
              child: GradientBackgroundWidget(
                child: CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: AppIcons.add.toWidget(),
                        onPressed: () {
                          AppOverlayController.showOverlay(context,
                              type: AppOverlayType.add);
                        },
                      ),
                      leading: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              ref.read(authProvider.notifier).logout(),
                          child: AppIcons.exit.toWidget(
                            size: 24,
                          )),
                      backgroundColor: Colors.transparent,
                      alwaysShowMiddle: true,
                      largeTitle: const Text("Hobbies"),
                      middle: const Text("Home"),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      sliver: SliverList.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HobbyWidget(
                            hobby: data[index].toString(),
                            onDelete: () =>
                                homeService.remove(data[index].toString()),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                    ),
                    if (data.isEmpty)
                      SliverFillRemaining(
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const HobbyBorderWidget(),
                              SizedBox(height: 10.h),
                              Text(
                                'Add your first hobby',
                                style: s14W500,
                              )
                            ],
                          ),
                          onPressed: () {
                            AppOverlayController.showOverlay(context,
                                type: AppOverlayType.add);
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
        error: (e, s) => const Center(
              child: Text('Something went wrong!',
                  style: TextStyle(color: Colors.red)),
            ),
        loading: () => const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ));
  }
}

// final aa = Material(
//   child: GradientBackgroundWidget(
//       child: CustomScrollView(slivers: [
//     CupertinoSliverNavigationBar(
//       trailing: AppIcons.power.toWidget(),
//       backgroundColor: Colors.transparent,
//       alwaysShowMiddle: false,
//       largeTitle: const Text("Users"),
//       middle: const Text("Find a Friend"),
//     ),
//     const SliverToBoxAdapter(child: SizedBox(height: 16)),
//     SliverPadding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       sliver: SliverList.separated(
//         itemCount: 2,
//         itemBuilder: (context, index) {
//           return HobbyWidget(hobbiy: 'asads');
//         },
//         separatorBuilder: (context, index) {
//           return const SizedBox(height: 16);
//         },
//       ),
//     ),
//     SliverToBoxAdapter(
//       child: SizedBox(
//         height: MediaQuery.paddingOf(context).bottom,
//       ),
//     ),
//   ])),
// );
