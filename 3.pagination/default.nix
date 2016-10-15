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

  paginate = pythonPackages.buildPythonPackage rec {
    name = "paginate-0.5.4.tar.gz";

    src = pkgs.fetchurl {
      url = mirror://pypi/P/Paste/paginate-0.5.4.tar.gz;
      sha256 = "18x7sfpc0xhnxwz6cwhdwni010w09jgnfl85rm5zjfcdx7adzvq3";
    };

    doCheck = false; # some files required by the test seem to be missing
  };

  paginate_sa = pythonPackages.buildPythonPackage rec {
    name = "paginate_sqlalchemy-0.2.0.tar.gz";

    src = pkgs.fetchurl {
      url = mirror://pypi/P/Paste/paginate_sqlalchemy-0.2.0.tar.gz;
      sha256 = "1mbikm7q5sjl156r1vs7rnri71ws7sacfvd9f2c30gnmcl2zrcwk";
    };

    buildInputs = with pythonPackages; [ paginate sqlalchemy ];

    doCheck = false; # some files required by the test seem to be missing
  };

in rec {
  pyEnv = stdenv.mkDerivation {
    name = "py-sqlalchemy";
    buildInputs = [ stdenv python3 pythonPackages.ipdb ] ++
                  [ sqlalchemy paginate paginate_sa ];
  };
}
