{ stdenv, lib, fetchFromGitHub
, cmake, pkg-config, fftwFloat, libsamplerate
}:

stdenv.mkDerivation rec {
  pname = "csdr-lu";
  version = "0.18.24";

  src = fetchFromGitHub {
    owner = "luarvique";
    repo = "csdr";
    rev = "be1be3c4827260e9a47729ccc01da59aa4592d67";
    hash = "sha256-uTkyzPwpsSlhL/gqSHf7Wo4QivkfdAt+wwo45iCwS0I=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  propagatedBuildInputs = [
    fftwFloat
    libsamplerate
  ];

  hardeningDisable = lib.optional stdenv.isAarch64 "format";

  postFixup = ''
    substituteInPlace "$out"/lib/pkgconfig/csdr.pc \
      --replace '=''${prefix}//' '=/' \
      --replace '=''${exec_prefix}//' '=/'
  '';

  meta = with lib; {
    homepage = "https://github.com/jketterl/csdr";
    description = "A simple DSP library and command-line tool for Software Defined Radio";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    broken = stdenv.isDarwin;
    maintainers = teams.c3d2.members;
  };
}
