#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 contest-id" >&2
  exit 1
fi

CONTEST_ID=$1
ROOT_DIR=$ROOT

mkdir -p "$ROOT_DIR/contests"
cd "$ROOT_DIR/contests"
acc new "$CONTEST_ID" >&2

# Generate Merlin config so ocamllsp doesn't return nil for the new tasks
cd "$ROOT_DIR"
dune build @check

cd "$ROOT_DIR/contests/$CONTEST_ID"
exec "$SHELL"
