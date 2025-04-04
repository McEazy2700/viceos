{ pkgs, ... }:
let
  inherit (pkgs) lib;
in
{
  home.packages = with pkgs; [
    (pkgs.stdenv.mkDerivation rec {
      pname = "dfx";
      version = "0.25.1";

      src = pkgs.fetchurl {
        url = "https://github.com/dfinity/sdk/releases/download/0.25.1/dfx-0.25.1-x86_64-linux.tar.gz";
        sha256 = "sha256-HiEY4EY6pE/tOl3ujWOBRMZ+e27o4L6vdc/VZoe9t+c=";
      };

      nativeBuildInputs = with pkgs; [
        autoPatchelfHook
        makeWrapper
        stdenv
        gnutar
      ];

      buildInputs = with pkgs; [
        libuuid
        stdenv.cc.cc.lib
        gcc-unwrapped.lib
      ];

      unpackPhase = ''
        tar xf $src
      '';

      installPhase = ''
        mkdir -p $out/bin
        install -m755 dfx $out/bin/dfx
        wrapProgram $out/bin/dfx \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}"
      '';

      dontStrip = true;

      runtimeDependencies = buildInputs;
    })
  ];
}
