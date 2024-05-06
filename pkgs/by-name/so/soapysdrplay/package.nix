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
    rev = version;
    sha256 = "sha256-FIg1YTKPsCUme0DphdP9YSWlwjeV6vP2D3TmeHj+FaY=";
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
