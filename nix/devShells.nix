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
            (import ./new.nix { inherit pkgs atcoder-cli; })
            (import ./t.nix { inherit pkgs; })
          ];

        shellHook = ''
          ${config.pre-commit.shellHook}
        '';
      };
    };
}
