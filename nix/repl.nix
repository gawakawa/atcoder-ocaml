{
  pkgs,
}:
pkgs.writeShellApplication {
  name = "repl";
  runtimeInputs = [
    pkgs.git
  ];
  text = builtins.readFile ../scripts/repl.sh;
}
