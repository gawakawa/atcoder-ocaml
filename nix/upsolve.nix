{
  pkgs,
}:
pkgs.writeShellApplication {
  name = "upsolve";
  runtimeInputs = [
    pkgs.git
  ];
  text = builtins.readFile ../scripts/upsolve.sh;
}
