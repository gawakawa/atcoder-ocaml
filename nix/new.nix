{
  pkgs,
  acc,
}:
pkgs.writeShellApplication {
  name = "new";
  runtimeInputs = [
    acc
    pkgs.git
  ];
  text = builtins.readFile ../scripts/new.sh;
}
