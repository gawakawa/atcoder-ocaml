{
  pkgs,
  atcoder-cli,
  dune,
}:
let
  script = (pkgs.writeScriptBin "new" (builtins.readFile ../scripts/new.sh)).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
in
pkgs.symlinkJoin {
  name = "new";
  paths = [
    script
    atcoder-cli
    dune
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = "wrapProgram $out/bin/new --prefix PATH : $out/bin";
}
