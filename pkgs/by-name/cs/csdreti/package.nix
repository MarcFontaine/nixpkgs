{ stdenv, lib, fetchFromGitHub
, cmake, pkg-config, csdr
}:

stdenv.mkDerivation rec {
  pname = "csdreit";
  version = "0.18.2";

  src = fetchFromGitHub {
    owner = "luarvique";
    repo = "csdr-eti";
    rev = "771aa745cff8c905ae30a1f215566d6f79a11da7";
    hash = "sha256-jft4zi1mLU6zZ+2gsym/3Xu8zkKL0MeoztcyMPM0RYI=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  propagatedBuildInputs = [
    csdr
  ];

  hardeningDisable = lib.optional stdenv.isAarch64 "format";

  meta = with lib; {
    homepage = "https://github.com/jketterl/csdreti";
    description = "A simple DSP library and command-line tool for Software Defined Radio";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    broken = stdenv.isDarwin;
    maintainers = teams.c3d2.members;
  };
}
