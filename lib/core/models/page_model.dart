import 'package:AppDrop/core/models/component_model.dart';

class PageModel {
  final List<ComponentModel> components;

  PageModel({required this.components});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      components: (json['page']['components'] as List)
          .map((c) => ComponentModel.fromJson(c))
          .toList(),
    );
  }
}
