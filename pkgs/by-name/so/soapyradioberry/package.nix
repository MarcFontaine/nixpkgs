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
    rev = "999e628ee35a46d57f8d23b81ff132ba285eb061";
    sha256 = "sha256-sQtsP6MWDcQpmnMC5j3kkC6BqFhu5ZdXtiW1YGDIo7E=";
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
