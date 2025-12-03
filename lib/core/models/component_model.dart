class ComponentModel {
  final String type;
  final Map<String, dynamic> props;

  ComponentModel({required this.type, required this.props});

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(type: json['type'], props: json);
  }
}
