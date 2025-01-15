{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "google-cloud-cli";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz";
    sha256 = "sha256-OCv/EPym9yVw0TipkDw+Sa06HrSI1UlDVgURNuOQanE="; # Replace this with the actual SHA256 hash of the tarball.
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
