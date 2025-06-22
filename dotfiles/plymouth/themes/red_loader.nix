{ stdenv, fetchFromGitHub ? null }:

stdenv.mkDerivation {
  pname = "red_loader";
  version = "1.0";

  src = ./red_loader;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/red_loader
    cp -r $src/* $out/share/plymouth/themes/red_loader/
  '';
}

