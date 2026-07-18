if [ $# -gt 1 ]; then
  echo "Usage: $0 [task-dir]" >&2
  exit 1
fi

TARGET=${1:-.}

if [ ! -d "$TARGET" ]; then
  echo "$TARGET is not a directory" >&2
  exit 1
fi

cd "$TARGET"

if [ ! -f main.ml ]; then
  echo "no main.ml in $(pwd) — is this a task directory?" >&2
  exit 1
fi

if [ ! -d test ]; then
  echo "no test/ in $(pwd) — fetch samples first with: oj d <url>" >&2
  exit 1
fi

exec oj t -c "dune exec ./main.exe"
