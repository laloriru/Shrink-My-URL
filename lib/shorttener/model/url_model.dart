class UrlModel {
  UrlModel(this.fullUrl, {this.shortUrl = '', this.order = 0});

  String fullUrl = '';
  String shortUrl = '';
  int order = 0;

} //

abstract class UrlState {
  const UrlState(): super();
}//

class InitialState extends UrlState {
  const InitialState();
//@override
}//

class LoadingState extends UrlState {
  const LoadingState();
}//