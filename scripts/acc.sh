if ! ROOT=$(git rev-parse --show-toplevel 2>/dev/null); then
  echo "acc: not inside a git repository (run from an atcoder-ocaml worktree)" >&2
  exit 1
fi

# Point acc's config dir at this worktree's acc-config/, so multiple
# worktrees never share (and clobber) one global $XDG_CONFIG_HOME symlink.
XDG="$ROOT/.acc-xdg"
mkdir -p "$XDG"
ln -sfn "$ROOT/acc-config" "$XDG/atcoder-cli-nodejs"

# The AtCoder session, on the other hand, should be shared across worktrees
# so `aclogin` only needs to run once per machine.
SHARED_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/atcoder-ocaml"
SHARED_SESSION="$SHARED_DIR/session.json"
mkdir -p "$SHARED_DIR"

SESSION="$ROOT/acc-config/session.json"
if [ -f "$SESSION" ] && [ ! -L "$SESSION" ]; then
  if [ ! -e "$SHARED_SESSION" ]; then
    mv "$SESSION" "$SHARED_SESSION"
  else
    rm "$SESSION"
  fi
fi
ln -sfn "$SHARED_SESSION" "$SESSION"

export XDG_CONFIG_HOME="$XDG"
exec acc "$@"
