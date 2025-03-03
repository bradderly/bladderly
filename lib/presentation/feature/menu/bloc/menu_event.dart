part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class GetVersion extends MenuEvent {
  const GetVersion({
    required this.device,
  });

  final String device;

  @override
  List<Object> get props => [
        device,
      ];
}
