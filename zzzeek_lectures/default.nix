{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  python3 = pkgs.python35;
  pythonPackages = pkgs.python35Packages;

  argparse = pythonPackages.buildPythonPackage rec {
    name = "argparse";

    src = pkgs.fetchurl {
      url = file://./pycon2013_student_package/sw/argparse-1.2.1.tar.gz;
      sha256 = "192174mys40m0bwk6l5jlfnzps0xi81sxm34cqms6dc3c454pbyx";
    };

    doCheck = false; # some files required by the test seem to be missing
  };

  pygments = pythonPackages.buildPythonPackage rec {
    name = "pygments";

    src = pkgs.fetchurl {
      url = file://./pycon2013_student_package/sw/Pygments-1.6.tar.gz;
      sha256 = "1h11r6ss8waih51vcksfvzghfxiav2f8svc0812fa5kmyz5d97kr";
    };

    doCheck = false; # some files required by the test seem to be missing
  };

  sliderepl = pythonPackages.buildPythonPackage rec {
    name = "sliderepl";

    src = pkgs.fetchurl {
      url = file://./pycon2013_student_package/sw/sliderepl-1.1.tar.gz;
      sha256 = "0kmqvh68lasxw02m5ca32bfs604m43i0a3xdvbcfgczmp87bfzai";
    };

    buildInputs = with pythonPackages; [ pygments ];

    doCheck = false; # some files required by the test seem to be missing
  };

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
    buildInputs = [ stdenv python3 pythonPackages.ipdb ] ++
                  [ sqlalchemy pygments argparse sliderepl ];
  };
}
