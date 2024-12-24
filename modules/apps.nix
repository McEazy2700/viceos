{ pkgs, ... }:
let
  zen_browser = pkgs.appimageTools.wrapType2 {
    name = "zen-browser";
    version = "1.0.2-b.4";
    src = pkgs.fetchurl {
      url = "https://github.com/zen-browser/desktop/releases/download/1.0.2-b.4/zen-x86_64.AppImage";
      sha256 = "sha256-lHqNAfr0nDR8pV3egKzNXn5DJn9W0vJqiV1WJLG+U34=";
    };
    extraInstall = ''
      mkdir -p $out/share/applications
      cp ${./zen-browser.png} $out/share/applications/zen-browser.png
      cat > $out/share/applications/zen-browser.desktop << EOF
      [Desktop Entry]
      Version=1.0.2
      Type=Application
      Name=Zen Browser
      Comment=Privacy-focused web browser
      Exec=$out/bin/zen-browser %U
      Icon=$out/share/applications/zen-browser.png
      Terminal=false
      Categories=Network;WebBrowser;
      MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
      EOF
    '';
  };
in
{
  home.packages = with pkgs; [
    zen_browser
    vivaldi
    discord
  ];
  programs.mpv.enable = true;
}
