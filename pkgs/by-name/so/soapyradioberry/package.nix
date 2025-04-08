{ lib
, stdenv
, fetchFromGitHub
, cmake
, soapysdr
, rpi ? "rpi-4"
}:

stdenv.mkDerivation rec {
  pname = "soapyradioberry";
  version = "0.0.0";
  src = fetchFromGitHub {
    owner = "pa3gsb";
    repo = "Radioberry-2.x";
    rev = "5f99826de20c30b5389b515926fed8ef53a2fdc9";
    sha256 = "sha256-qVnviHC/x7qgcx5tuW27/FeVmu6TMyqwrvTwnZiJYCo=";
  };

  patches = [ ./0001-Fix-soapyradioberry-build.patch ];
  patchFlags = [ "-p4" ];
  
  sourceRoot = "${src.name}/SBC/${rpi}/SoapyRadioberrySDR";

  nativeBuildInputs = [ cmake soapysdr ];

  cmakeFlags = [
    "CXXFLAGS=-Wno-unused-parameter"
  ];

  meta = {
    description = "Soapy module for the Radioberry SDR";
    homepage = "https://github.com/pa3gsb/Radioberry-2.x/";
    license = with lib.licenses; [
    ];
    maintainers = with lib.maintainers; [ mafon ];
  };
}
