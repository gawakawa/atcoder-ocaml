if [ $# -gt 1 ]; then
  echo "Usage: $0 [task-dir]" >&2
  exit 1
fi

TARGET=${1:-.}

if [ ! -d "$TARGET" ]; then
  echo "$TARGET is not a directory" >&2
  exit 1
fi

ROOT=$(git rev-parse --show-toplevel)

cd "$TARGET"

exec utop -init "$ROOT/.ocamlinit"
