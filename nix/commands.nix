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
  # bundle is defined first because new/upsolve depend on it.
  bundle = mkCommand "bundle" [ pkgs.git ];
  packages = {
    inherit bundle;
  }
  // builtins.mapAttrs mkCommand {
    new = [
      atcoder-cli
      pkgs.git
      bundle
    ];
    repl = [ pkgs.git ];
    t = [ pkgs.online-judge-tools ];
    upsolve = [
      pkgs.git
      bundle
    ];
  };
in
builtins.attrValues packages
