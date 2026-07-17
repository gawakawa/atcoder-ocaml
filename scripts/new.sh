if [ $# -ne 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 contest-id" >&2
  exit 1
fi

CONTEST_ID=$1
ROOT=$(git rev-parse --show-toplevel)

mkdir -p "$ROOT/contests"
cd "$ROOT/contests"
acc new "$CONTEST_ID" >&2

if [ ! -d "$ROOT/contests/$CONTEST_ID" ]; then
  echo "acc new did not create contests/$CONTEST_ID; see output above for the cause" >&2
  exit 1
fi

if [ -z "$(find "$ROOT/contests/$CONTEST_ID" -mindepth 1 -type f -name dune -print -quit)" ]; then
  echo "acc new created contests/$CONTEST_ID but no task scaffolding (no dune file found); see output above for the cause" >&2
  exit 1
fi

# Generate Merlin config so ocamllsp doesn't return nil for the new tasks
cd "$ROOT"
dune build "@contests/$CONTEST_ID/check"

cd "$ROOT/contests/$CONTEST_ID"
exec "${SHELL:-bash}"
