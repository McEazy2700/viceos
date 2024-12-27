{ pkgs, ... }:

let
  inherit (pkgs) lib;
in
{
  home.packages = with pkgs; [
    (pkgs.stdenv.mkDerivation rec {
      pname = "dfx";
      version = "0.24.3";

      src = pkgs.fetchurl {
        url = "https://github.com/dfinity/sdk/releases/download/0.24.3/dfx-0.24.3-x86_64-linux.tar.gz";
        sha256 = "sha256-+hAxDnr3Y9U8rJYHBJzJ1g4K/HLzYjngRAYOepghCEI=";
      };

      nativeBuildInputs = with pkgs; [
        autoPatchelfHook
        makeWrapper
        stdenv
        gnutar
      ];

      buildInputs = with pkgs; [
        openssl
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
