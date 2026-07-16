_: {
  perSystem =
    {
      config,
      pkgs,
      main,
      devPackages,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        inputsFrom = [ main ];
        buildInputs =
          config.ciPackages
          ++ config.pre-commit.settings.enabledPackages
          ++ devPackages
          ++ [
            pkgs.online-judge-tools
            (import ./atcoder-cli.nix { inherit pkgs; })
            (import ./aclogin.nix { inherit pkgs; })
          ];

        shellHook = ''
          ${config.pre-commit.shellHook}
        '';
      };
    };
}
