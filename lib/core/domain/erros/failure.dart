
class Failure implements Exception {
  final String? message;
  const Failure({
    this.message,
  });
 }


class FailureConnection extends Failure {
 FailureConnection({super.message});
}

const genericError = Failure(message: 'Desculpe, ocorreu um erro inesperado. Por favor, tente novamente. Se o problema persistir, entre em contato com o suporte técnico.');