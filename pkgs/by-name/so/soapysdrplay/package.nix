{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  pkg-config,
  soapysdr,
  sdrplay,
}:

stdenv.mkDerivation rec {
  pname = "soapysdr-sdrplay3";
  version = "0.8.10";

  src = fetchFromGitHub {
    owner = "luarvique";
    repo = "SoapySDRPlay3";
    rev = "cc14358ba0ec46aa6d3570c48a229a0bb29df8d2";
    sha256 = "sha256-amK0P5sQb/5xNZ/sGXpO6f/RD7SIbQa+LAa08kEAXLg=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    soapysdr
    sdrplay
  ];

  cmakeFlags = [
    "-DSoapySDR_DIR=${soapysdr}/share/cmake/SoapySDR/"
  ];

  meta = with lib; {
    description = "Soapy SDR module for SDRplay";
    homepage = "https://github.com/pothosware/SoapySDRPlay3";
    license = licenses.mit;
    maintainers = [ maintainers.pmenke ];
    platforms = platforms.linux;
  };
}
