{pkgs, ...}: let
  zenbrowser =
    pkgs.callPackage
    (
      {
        lib,
        fetchurl,
        appimageTools,
      }: let
        pname = "ZenBrowser";
        version = "1.0.2-b.4";
        name = "${pname}-${version}";

        src = fetchurl {
          url = "https://github.com/zen-browser/desktop/releases/download/1.0.2-b.4/zen-x86_64.AppImage";
          hash = "sha256-lHqNAfr0nDR8pV3egKzNXn5DJn9W0vJqiV1WJLG+U34=";
        };

        icon = fetchurl {
          url = "https://docs.zen-browser.app/static/icon.png";
          hash = "sha256-FXbh3eDdvROF6Z0bEAFxYr93LSz+c/Z0WcrCcsrauGI="; # You'll need to provide this
        };
      in
        appimageTools.wrapType2 {
          inherit name src version pname;

          extraInstallCommands = ''
            # Create desktop file
            mkdir -p $out/share/applications
            cat > $out/share/applications/${pname}.desktop << EOF
            [Desktop Entry]
            Name=ZenBrowser
            Exec=${pname}
            Type=Application
            Categories=Network;WebBrowser;
            Comment=Beautifully designed, privacy-focused browser, packed with features.
            Icon=${pname}
            EOF

            # Install the icon
            mkdir -p $out/share/icons/hicolor/512x512/apps
            cp ${icon} $out/share/icons/hicolor/512x512/apps/${pname}.png
          '';

          meta = with lib; {
            description = "Beautifully designed, privacy-focused browser, packed with features.";
            homepage = "https://zen-browser.app";
            license = licenses.unfree;
            platforms = ["x86_64-linux"];
            maintainers = [];
          };
        }
    )
    {};
in {
  home.packages = [zenbrowser];
}
