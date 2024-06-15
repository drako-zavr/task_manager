part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool switchValue;
  const SwitchState({required this.switchValue});

  @override
  List<Object> get props => [switchValue];

  Map<String, dynamic> toMap() {
    return {
      'switchValue': switchValue,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      switchValue: map['switchValue'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory SwitchState.fromJson(String source) => SwitchState.fromMap(json.decode(source));
}

class SwitchInitial extends SwitchState {
  const SwitchInitial({required super.switchValue});
  // const SwitchInitial({required bool switchValue}):super(switchValue: switchValue);
}
