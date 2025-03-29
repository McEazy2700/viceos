{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "google-cloud-cli";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz";
    sha256 = "sha256-0bZCWN54BbWfMkaXENUQsD3vwGs4W3Gf74gtAfZCaBc=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  meta = with pkgs.lib; {
    description = "Google Cloud SDK";
    homepage = "https://cloud.google.com/sdk";
    license = licenses.asl20;
    maintainers = [ ]; # Add yourself here if desired.
  };
}
