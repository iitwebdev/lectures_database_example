{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  python3 = pkgs.python35;
  pythonPackages = pkgs.python35Packages;

  sqlalchemy = pythonPackages.buildPythonPackage rec {
    name = "SQLAlchemy-1.1.1.tar.gz";

    src = pkgs.fetchurl {
      url = mirror://pypi/P/Paste/SQLAlchemy-1.1.1.tar.gz;
      sha256 = "0c022vwzz1943l4nvz1ynnpkvgkqa5sfkr0zwm43xi22a34ngw9f";
    };

    doCheck = false; # some files required by the test seem to be missing
  };

in rec {
  pyEnv = stdenv.mkDerivation {
    name = "py-sqlalchemy";
    buildInputs = [ stdenv python3 sqlalchemy pythonPackages.ipdb ];
  };
}
