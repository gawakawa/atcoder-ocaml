_: {
  perSystem =
    {
      config,
      pkgs,
      main,
      devPackages,
      dune,
      ...
    }:
    let
      atcoder-cli = import ./atcoder-cli.nix { inherit pkgs; };
    in
    {
      devShells.default = pkgs.mkShell {
        inputsFrom = [ main ];
        buildInputs =
          config.ciPackages
          ++ config.pre-commit.settings.enabledPackages
          ++ devPackages
          ++ [
            pkgs.online-judge-tools
            atcoder-cli
            (import ./aclogin.nix { inherit pkgs; })
            (import ./new.nix { inherit pkgs atcoder-cli dune; })
          ];

        shellHook = ''
          ${config.pre-commit.shellHook}
          export ROOT="$PWD"
        '';
      };
    };
}
