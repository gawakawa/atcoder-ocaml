_: {
  perSystem =
    {
      config,
      pkgs,
      main,
      devPackages,
      ...
    }:
    let
      atcoder-cli = import ./atcoder-cli.nix { inherit pkgs; };
      acc = import ./acc.nix { inherit pkgs atcoder-cli; };
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
            acc
            (import ./aclogin.nix { inherit pkgs; })
            (import ./new.nix { inherit pkgs acc; })
            (import ./t.nix { inherit pkgs; })
          ];

        shellHook = ''
          ${config.pre-commit.shellHook}
        '';
      };
    };
}
