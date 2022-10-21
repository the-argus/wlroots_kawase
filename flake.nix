{
  description = "A very basic flake";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: rec {
      wlroots = pkgs.${system}.callPackage ./. {};
      default = wlroots;
      sway = pkgs.${system}.sway-unwrapped.override {inherit wlroots;};
    });
  };
}
