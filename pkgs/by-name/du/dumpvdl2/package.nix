{ stdenv, lib, fetchFromGitHub, cmake, pkg-config,
  glib,
  soapysdr, sdrplay, sqlite,
  zeromq,
  libacars
}:

stdenv.mkDerivation rec {
  pname = "dumpvdl2";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "szpajder";
    repo = "dumpvdl2";
    rev = "v${version}";
    hash = "sha256-lmjVLHFLa819sgZ0NfSyKywEwS6pQxzdOj4y8RwRu/8=";
  };

  buildInputs = [
    glib
    soapysdr
  	sdrplay
    sqlite
    zeromq
    libacars
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  meta = with lib; {
    homepage = "https://github.com/szpajder/dumpvdl2";
    description = ''
      dumpvdl2 is a VDL Mode 2 message decoder and protocol analyzer.
    '';
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.mafo ];
  };
}
