part of 'booklet_cubit.dart';

class BookletState {
  StateStatusEnum getBookletStatus;
  List<Booklet> booklets;

  String getBookletError;

  StateStatusEnum createBookletStatus;

  String createBookletError;

  List<PaymentTerm> paymentTerms;

  StateStatusEnum paymentTermStatus;

  String paymentTermError;

  BookletState({
    this.getBookletStatus = StateStatusEnum.initial,
    this.getBookletError = '',
    this.booklets = const [],
    this.createBookletStatus = StateStatusEnum.initial,
    this.createBookletError = '',
    this.paymentTerms = const [],
    this.paymentTermStatus = StateStatusEnum.initial,
    this.paymentTermError = '',
  });

  BookletState copyWith({
    StateStatusEnum? getBookletStatus,
    String? getBookletError,
    List<Booklet>? booklets,
    StateStatusEnum? createBookletStatus,
    String? createBookletError,
    List<PaymentTerm>? paymentTerms,
    StateStatusEnum? paymentTermStatus,
    String? paymentTermError,
  }) {
    return BookletState(
      getBookletStatus: getBookletStatus ?? this.getBookletStatus,
      getBookletError: getBookletError ?? this.getBookletError,
      booklets: booklets ?? this.booklets,
      createBookletStatus: createBookletStatus ?? this.createBookletStatus,
      createBookletError: createBookletError ?? this.createBookletError,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      paymentTermStatus: paymentTermStatus ?? this.paymentTermStatus,
      paymentTermError: paymentTermError ?? this.paymentTermError,
    );
  }
}
