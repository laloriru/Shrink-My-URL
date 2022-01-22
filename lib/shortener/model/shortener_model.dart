abstract class ShortenerState {
  const ShortenerState(): super();
}//

class InitialState extends ShortenerState {
  const InitialState();
//@override
}//

class LoadingState extends ShortenerState {
  const LoadingState();
}//

class ShortenedState extends ShortenerState {
  ShortenedState(this.link);
  Map<String, String> link;
}//

class ErrorState extends ShortenerState {
  ErrorState(this.errorMessage);
  String errorMessage = '';
}//