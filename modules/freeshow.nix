{ pkgs, lib, ... }:

let
  appName = "FreeShow";  # Replace with your app's name
  version = "1.3.3";        # Replace with app version
in
{
  home.packages = with pkgs; [
    (pkgs.stdenv.mkDerivation {
      pname = lib.strings.toLower appName;
      inherit version;

      src = pkgs.fetchurl {
        url = "https://github.com/ChurchApps/FreeShow/releases/download/v1.3.3/FreeShow-1.3.3-x86_64.AppImage";
        sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with actual hash
      };

      nativeBuildInputs = [ pkgs.makeWrapper ];
      buildInputs = [ pkgs.appimage-run ];

      unpackPhase = ''
        cp $src ./${appName}.AppImage
        chmod +x ./${appName}.AppImage
      '';

      installPhase = ''
        mkdir -p $out/bin $out/share/applications $out/share/icons/hicolor/256x256/apps
        
        # Copy AppImage
        cp ./${appName}.AppImage $out/bin/
        
        # Create wrapper script
        makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/${lib.strings.toLower appName} \
          --add-flags "$out/bin/${appName}.AppImage"
        
        # Create desktop entry
        cat > $out/share/applications/${lib.strings.toLower appName}.desktop << EOF
        [Desktop Entry]
        Name=${appName}
        Exec=$out/bin/${lib.strings.toLower appName}
        Icon=${lib.strings.toLower appName}
        Type=Application
        Categories=Application;
        EOF

        # Extract icon from AppImage (assuming it exists at this location)
        ./${appName}.AppImage --appimage-extract usr/share/icons/hicolor/256x256/apps/${lib.strings.toLower appName}.png || true
        
        # Copy icon if extraction succeeded, otherwise create a placeholder
        if [ -f squashfs-root/usr/share/icons/hicolor/256x256/apps/${lib.strings.toLower appName}.png ]; then
          cp squashfs-root/usr/share/icons/hicolor/256x256/apps/${lib.strings.toLower appName}.png \
            $out/share/icons/hicolor/256x256/apps/
        else
          # Create a simple placeholder icon if extraction fails
          ${pkgs.imagemagick}/bin/convert -size 256x256 xc:transparent \
            -gravity center -pointsize 20 -fill black -annotate 0 "${appName}" \
            $out/share/icons/hicolor/256x256/apps/${lib.strings.toLower appName}.png
        fi
      '';

      meta = with lib; {
        description = "A dynamic, user-friendly, and open-source presenter built for all of your presentations.";
        homepage = "https://freeshow.app";
        license = licenses.unfree; # Adjust according to app's license
        platforms = platforms.linux;
      };
    })
  ];
}
