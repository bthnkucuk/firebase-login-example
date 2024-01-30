import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/features/auth/providers/user_provider.dart';
import '/features/hobby/service/hobby_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../hobby/provider/hobby_provider.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hobby = ref.watch(hobbyProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          // HobbyService().add(ref.read(userProvider.notifier).user!, 'piano');
        },
        child: const Icon(Icons.logout),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: hobby.when(
          data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100.h,
                    child: Card(
                      child: Center(
                        child: Text(
                          data[index].toString(),
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ),
                  );
                },
              ),
          error: (e, s) => Center(
                child: Text('Something went wrong!',
                    style: TextStyle(color: Colors.red)),
              ),
          loading: () => Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
