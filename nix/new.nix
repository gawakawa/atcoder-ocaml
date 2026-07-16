{
  pkgs,
  atcoder-cli,
}:
pkgs.writeShellApplication {
  name = "new";
  runtimeInputs = [
    atcoder-cli
    pkgs.git
  ];
  text = builtins.readFile ../scripts/new.sh;
}
