if [ $# -ne 1 ]; then
  echo "Usage: $0 contest-id" >&2
  exit 1
fi

CONTEST_ID=$1
ROOT=$(git rev-parse --show-toplevel)

mkdir -p "$ROOT/contests"
cd "$ROOT/contests"
acc new "$CONTEST_ID" >&2

# Generate Merlin config so ocamllsp doesn't return nil for the new tasks
cd "$ROOT"
dune build "@contests/$CONTEST_ID/check"

cd "$ROOT/contests/$CONTEST_ID"
exec "${SHELL:-bash}"
