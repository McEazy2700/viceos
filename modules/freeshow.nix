{pkgs, ...}: let
  freeshow = pkgs.callPackage (
    {
      lib,
      fetchurl,
      appimageTools,
    }: let
      pname = "FreeShow";
      version = "1.3.3";
      name = "${pname}-${version}";

      src = fetchurl {
        url = "https://github.com/ChurchApps/FreeShow/releases/download/v1.3.8/FreeShow-1.3.8-x86_64.AppImage";
        hash = "sha256-4LweaHlmSzVgeqoeLgZSfxfdNvYIkDKKh500hMasjJc=";
      };

      icon = fetchurl {
        url = "https://freeshow.app/images/favicon.png";
        hash = "sha256-XyNYThRXx7AB/ZKrjPYIDDjvJVEi7Pk8QWHskHk2qH8="; # You'll need to provide this
      };
    in
      appimageTools.wrapType2 {
        inherit name src version pname;

        extraInstallCommands = ''
          # Create desktop file
          mkdir -p $out/share/applications
          cat > $out/share/applications/${pname}.desktop << EOF
          [Desktop Entry]
          Name=FreeShow
          Exec=${pname}
          Type=Application
          Categories=Office;Presentation;
          Comment=A dynamic, user-friendly, and open-source presenter
          Icon=${pname}
          EOF

          # Install the icon
          mkdir -p $out/share/icons/hicolor/512x512/apps
          cp ${icon} $out/share/icons/hicolor/512x512/apps/${pname}.png
        '';

        meta = with lib; {
          description = "A dynamic, user-friendly, and open-source presenter built for all of your presentations.";
          homepage = "https://freeshow.app";
          license = licenses.unfree;
          platforms = ["x86_64-linux"];
          maintainers = [];
        };
      }
  ) {};
in {
  home.packages = [freeshow];
}
