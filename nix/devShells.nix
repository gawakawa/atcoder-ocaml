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
          ]
          ++ import ./commands.nix { inherit pkgs atcoder-cli; };

        shellHook = ''
          ${config.pre-commit.shellHook}
        '';
      };
    };
}
