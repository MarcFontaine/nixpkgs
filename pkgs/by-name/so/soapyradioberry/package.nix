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
    owner = "MarcFontaine";
    repo = "Radioberry-2.x";
    rev = "017efae2b72b3826d05ba8a6a260d8c97ae7f9c9";
    sha256 = "sha256-2+illSbujeN1MXRpO10YSglN2+TEwPiNQGjXzY9qFyg=";
  };

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
