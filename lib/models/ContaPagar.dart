class ContaPagar {
  int _id;
  String _data;
  String _valor;
  String _formaPagamento;
  String _observacoes;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get data => _data;

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

  set data(String value) {
    _data = value;
  }
}
