{
  pkgs,
  atcoder-cli,
}:
pkgs.writeShellApplication {
  name = "acc";
  runtimeInputs = [
    atcoder-cli
    pkgs.git
    pkgs.coreutils
  ];
  text = builtins.readFile ../scripts/acc.sh;
}
