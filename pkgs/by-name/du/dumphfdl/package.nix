{ stdenv, lib, fetchFromGitHub, cmake, pkg-config, libconfig,
  liquid-dsp, fftwSinglePrec, glib, soapysdr, sdrplay, sqlite,
  zeromq, gperftools,
  libacars
}:

stdenv.mkDerivation rec {
  pname = "dumphfdl";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "szpajder";
    repo = "dumphfdl";
    rev = "v${version}";
    hash = "sha256-M4WjcGA15Kp+Hpp+I2Ndcx+oBqaGxEeQLTPcSlugLwQ=";
  };

  buildInputs = [
    fftwSinglePrec
    liquid-dsp
    glib
    libconfig
    soapysdr
	  sdrplay
	  sqlite
	  zeromq
	  gperftools
    libacars
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  meta = with lib; {
    homepage = "https://github.com/szpajder/dumphfdl";
    description = ''
      dumphfdl is a multichannel HFDL (High Frequency Data Link) decoder.
    '';
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.mafo ];
  };
}
