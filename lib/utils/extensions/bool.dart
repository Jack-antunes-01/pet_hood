extension BoolExt on bool {
  toText() {
    if (this) {
      return "Sim";
    }
    return "Não";
  }
}
