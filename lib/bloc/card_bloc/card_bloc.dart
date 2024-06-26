import 'package:click/bloc/card_bloc/card_event.dart';
import 'package:click/bloc/card_bloc/card_state.dart';
import 'package:click/data/models/card_model.dart';
import 'package:click/data/models/form_status.dart';
import 'package:click/data/network/response.dart';
import 'package:click/data/repositories/card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCardsBloc extends Bloc<UserCardsEvent, UserCardsState> {
  UserCardsBloc({required this.cardRepository})
      : super(
    const UserCardsState(
      userCards: [],
      userCardsDB: [],
      formStatus: FormStatus.pure,
      errorMessage: "",
      statusMessage: "",
    ),
  ) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<GetCardsByUserIdEvent>(_listenCard);
    on<GetCardsDatabaseEvent>(_listenCardDatabase);
  }

  final CardRepository cardRepository;

  _addCard(AddCardEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
    await cardRepository.addCard(event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _updateCard(UpdateCardEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
    await cardRepository.updateCard(event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _deleteCard(DeleteCardEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
    await cardRepository.deleteCard(event.cardDocId);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error,
          errorMessage: networkResponse.errorText));
    }
  }

  _listenCard(GetCardsByUserIdEvent event, emit) async {
    emit.onEach(
      cardRepository.getCardsByUserId(event.userId),
      onData: (List<CardModel> userCards) {
        emit(
          state.copyWith(userCards: userCards),
        );
      },
    );
  }

  _listenCardDatabase(GetCardsDatabaseEvent event, emit) async {
    emit.onEach(
      cardRepository.getCardsDatabase(),
      onData: (List<CardModel> userCards) {
        emit(
          state.copyWith(userCardsDB: userCards),
        );
      },
    );
  }
}