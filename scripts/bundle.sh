if [ $# -ne 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 target-main-ml" >&2
  exit 1
fi

TARGET=$1
ROOT=$(git rev-parse --show-toplevel)
TEMPLATE="$ROOT/acc-config/ocaml/main.ml"
MARKER="(* MYLIB *)"

if ! grep -qF "$MARKER" "$TEMPLATE"; then
  echo "$TEMPLATE has no '$MARKER' marker; template is broken" >&2
  exit 1
fi

build_mylib_block() {
  module_names=()
  for src in "$ROOT"/lib/*.ml; do
    name=$(basename "$src" .ml)
    module_name=${name^}
    module_names+=("$module_name")
    printf 'module %s = struct\n' "$module_name"
    printf '  [@@@warning "-32"]\n\n'
    sed 's/^./  &/' "$src"
    printf 'end\n\n'
  done

  for module_name in "${module_names[@]}"; do
    printf 'open! %s\n' "$module_name"
  done
}

export MYLIB_BLOCK
MYLIB_BLOCK=$(build_mylib_block)

awk -v marker="$MARKER" '
  $0 == marker { print ENVIRON["MYLIB_BLOCK"]; next }
  { print }
' "$TEMPLATE" > "$TARGET"
