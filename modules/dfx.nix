{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dfx
    nodejs_20
    nodePackages.npm
  ];

  home.sessionVariables = {
    DFX_VERSION = "0.14.0";
    II_ENV = "development";
  };
}
