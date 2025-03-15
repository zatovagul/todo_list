import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/common/utils/image_util.dart';

class PickImageField extends StatelessWidget {
  const PickImageField({required this.onFilePicked, super.key, this.file});

  final File? file;
  final ValueSetter<File?> onFilePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Builder(
        builder: (context) {
          if (file == null) {
            return PopupMenuButton<bool>(
              onSelected: (value) async {
                final image = await ImageUtil.pickImage(camera: value);
                if (image != null) onFilePicked(image);
              },
              offset: const Offset(0, 50),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(value: true, child: Text(context.l10n.camera)),
                  PopupMenuItem(
                    value: false,
                    child: Text(context.l10n.gallery),
                  ),
                ];
              },
              child: const Center(child: Icon(Icons.camera_alt)),
            );
          }
          return Stack(
            children: [
              Positioned.fill(child: Image.file(file!, fit: BoxFit.cover)),
              Positioned(
                top: 8,
                right: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => onFilePicked(null),
                    color: Colors.white,
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
