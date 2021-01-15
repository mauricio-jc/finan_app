class ContaReceber {
  int _id;
  String _cliente;
  String _data;
  String _valor;
  String _formaPagamento;
  String _observacoes;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get cliente => _cliente;

  String get observacoes => _observacoes;

  set observacoes(String value) {
    _observacoes = value;
  }

  String get formaPagamento => _formaPagamento;

  set formaPagamento(String value) {
    _formaPagamento = value;
  }

  String get valor => _valor;

  set valor(String value) {
    _valor = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  set cliente(String value) {
    _cliente = value;
  }
}