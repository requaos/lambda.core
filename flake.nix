{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils/main";
        devshell.url = "github:numtide/devshell/main";
    };
    outputs = { self, nixpkgs, flake-utils, devshell }:
        flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
      in
      {
        devShell = pkgs.devshell.mkShell {
          name = "lambda-core-shell";
          packages = [
            (with pkgs.dotnetCorePackages; combinePackages [
                sdk_7_0
                aspnetcore_7_0
            ])
          ];
        };
      }
    );
}