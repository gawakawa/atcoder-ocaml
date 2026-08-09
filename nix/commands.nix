{
  pkgs,
  atcoder-cli,
}:
let
  # Each command <name> wraps scripts/<name>.sh.
  mkCommand =
    name: runtimeInputs:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.readFile (../scripts + "/${name}.sh");
    };
in
builtins.attrValues (
  builtins.mapAttrs mkCommand {
    new = [
      atcoder-cli
      pkgs.git
    ];
    repl = [ pkgs.git ];
    t = [ pkgs.online-judge-tools ];
    upsolve = [ pkgs.git ];
  }
)
