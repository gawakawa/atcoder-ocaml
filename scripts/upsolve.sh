if [ $# -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 contest-id task-id" >&2
  exit 1
fi

CONTEST_ID=$1
TASK_ID=$2
ROOT=$(git rev-parse --show-toplevel)
TASK_DIR="$ROOT/contests/$CONTEST_ID/tasks/$TASK_ID"

if [ ! -f "$TASK_DIR/main.ml" ]; then
  echo "$TASK_DIR/main.ml not found; run 'new $CONTEST_ID' first" >&2
  exit 1
fi

bundle "$TASK_DIR/main.ml"

cd "$ROOT/contests/$CONTEST_ID"
exec "${SHELL:-bash}"
