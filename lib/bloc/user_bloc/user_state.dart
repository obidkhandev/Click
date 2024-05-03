import 'package:click/data/models/form_status.dart';
import 'package:click/data/models/user_model.dart';
import 'package:equatable/equatable.dart';


class UserProfileState extends Equatable {
  final String errorText;
  final String statusMessage;
  final FormStatus formStatus;
  final UserModel userModel;

  const UserProfileState({
    required this.userModel,
    required this.formStatus,
    required this.errorText,
    required this.statusMessage,
  });

  UserProfileState copyWith({
    String? errorText,
    String? statusMessage,
    FormStatus? formStatus,
    UserModel? userModel,
  }) {
    return UserProfileState(
      userModel: userModel ?? this.userModel,
      formStatus: formStatus ?? this.formStatus,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [userModel, errorText, formStatus, statusMessage];
}