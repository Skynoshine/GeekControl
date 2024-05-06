class ConvertState {
  static String toPortuguese(String status) {
    switch (status.toUpperCase()) {
      case 'FINISHED':
        return 'Finalizado';
      case 'RELEASING':
        return 'Em Lançamento';
      case 'NOT_YET_RELEASED':
        return 'Ainda Não lançado';
      case 'CANCELLED':
        return 'Cancelado';
      case 'HIATUS':
        return 'Em Hiato';
      default:
        return 'Status Desconhecido';
    }
  }
}

enum MangaStates {
  finished,
  releasing,
  notYetReleased,
  canceled,
  hiatus,
}

extension ConvertStates on MangaStates {
  String get portuguese {
    switch (this) {
      case MangaStates.finished:
        return 'Finalizado';
      case MangaStates.releasing:
        return 'Lançamento';
      case MangaStates.notYetReleased:
        return 'Não lançado';
      case MangaStates.canceled:
        return 'Cancelado';
      case MangaStates.hiatus:
        return 'Hiato';
      default:
        return 'Desconhecido';
    }
  }
}
