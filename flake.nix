{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.treefmt = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    treefmt,
    ...
  }: let
    eachSystem = f: nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (x: f nixpkgs.legacyPackages.${x});
    formatter = pkgs:
      (treefmt.lib.evalModule pkgs {
        programs.alejandra.enable = true;
        settings.formatter.verible = {
          command = nixpkgs.lib.getExe' pkgs.verible "verible-verilog-format";
          options = ["--wrap_spaces=2" "--inplace"];
          includes = ["*.v"];
        };
      }).config.build.wrapper;
  in {
    devShells = eachSystem (pkgs: {default = pkgs.mkShell {packages = [(formatter pkgs)];};});
    formatter = eachSystem formatter;
  };
}
