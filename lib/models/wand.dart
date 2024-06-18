class Wand {
  String wood;
  String core;
  double length;

  Wand({
    required this.wood,
    required this.core,
    required this.length,
  });

  factory Wand.fromJson(Map<String, dynamic> json) {
    return Wand(
      wood: json['wood']??"no data",
      core: json['core']??"no data",
      length: double.parse((json['length']??0.0).toString()),
    );
  }

  Wand.empty()
      : wood = '',
        core = '',
        length = 0;

  Map<String, dynamic> toJson() {
    return {
      'wood': wood,
      'core': core,
      'length': length,
    };
  }
}