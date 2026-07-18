{
  pkgs,
}:
pkgs.writeShellApplication {
  name = "t";
  runtimeInputs = [
    pkgs.online-judge-tools
  ];
  text = builtins.readFile ../scripts/t.sh;
}
