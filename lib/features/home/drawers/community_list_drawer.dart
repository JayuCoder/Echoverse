import 'package:echoversetwo/core/common/error_text.dart';
import 'package:echoversetwo/core/common/loader.dart';
import 'package:echoversetwo/core/common/sign_in_button.dart';
import 'package:echoversetwo/features/auth/controller/auth_controller.dart';
import 'package:echoversetwo/features/community/controller/community_controller.dart';
import 'package:echoversetwo/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCrateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            isGuest
                ? const SignInButton()
                : ListTile(
                  title: const Text('Create a Community'),
                  leading: const Icon(Icons.add),
                  onTap: () => navigateToCrateCommunity(context),
                ),
            if (!isGuest)
              ref
                  .watch(userCommunitiesProvider)
                  .when(
                    data:
                        (communities) => Expanded(
                          child: ListView.builder(
                            itemCount: communities.length,
                            itemBuilder: (BuildContext context, int index) {
                              final community = communities[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    community.avatar,
                                  ),
                                ),
                                title: Text('r/${community.name}'),
                                onTap:
                                    () =>
                                        navigateToCommunity(context, community),
                              );
                            },
                          ),
                        ),
                    error:
                        (error, stackTrace) =>
                            ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  ),
          ],
        ),
      ),
    );
  }
}
