import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:echoversetwo/core/common/error_text.dart';
import 'package:echoversetwo/core/common/loader.dart';
import 'package:echoversetwo/core/constants/constants.dart';
import 'package:echoversetwo/core/utils.dart';
import 'package:echoversetwo/features/community/controller/community_controller.dart';
import 'package:echoversetwo/models/community_model.dart';
import 'package:echoversetwo/theme/pallete.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;
  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void save(Community community) {
    ref
        .read(communityControllerProvider.notifier)
        .editCommunity(
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
          community: community,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);

    return ref
        .watch(getCommunityByNameProvider(widget.name))
        .when(
          data:
              (community) => Scaffold(
                appBar: AppBar(
                  backgroundColor: currentTheme.scaffoldBackgroundColor,
                  title: const Text('Edit Community'),
                  centerTitle: false,
                  actions: [
                    TextButton(
                      onPressed: () => save(community),
                      child: const Text('Save'),
                    ),
                  ],
                ),
                body:
                    isLoading
                        ? const Loader()
                        : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: selectBannerImage,
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(10),
                                        dashPattern: const [10, 4],
                                        strokeCap: StrokeCap.round,
                                        color:
                                            currentTheme
                                                .textTheme
                                                .bodyMedium!
                                                .color!,
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child:
                                              bannerFile != null
                                                  ? Image.file(bannerFile!)
                                                  : community.banner.isEmpty ||
                                                      community.banner ==
                                                          Constants
                                                              .bannerDefault
                                                  ? const Center(
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 40,
                                                    ),
                                                  )
                                                  : Image.network(
                                                    community.banner,
                                                  ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: GestureDetector(
                                        onTap: selectProfileImage,
                                        child:
                                            profileFile != null
                                                ? CircleAvatar(
                                                  backgroundImage: FileImage(
                                                    profileFile!,
                                                  ),
                                                  radius: 32,
                                                )
                                                : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    community.avatar,
                                                  ),
                                                  radius: 32,
                                                ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
              ),
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
        );
  }
}
