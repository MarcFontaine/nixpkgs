{ stdenv, lib, fetchurl
, pkg-config, libsForQt5
, fftw, libpcap, libpulseaudio
, speexdsp
, zlib
}:

stdenv.mkDerivation rec {
  pname = "dream-cli";
  version = "2.2";

  src = fetchurl {
    url = "mirror://sourceforge/drm/dream/${version}/dream_${version}.orig.tar.gz";
    sha256 = "sha256-9yEe48GbQhFrbR+ZnUUAfBqeYv7pKQaqN9VusAIZ71Y=";
  };

  buildInputs = [
    fftw
    libpulseaudio
    libpcap
    speexdsp
  ];

  nativeBuildInputs = [
    pkg-config
    libsForQt5.qmake
    libsForQt5.wrapQtAppsHook
  ];

  qmakeFlags =[ "qt=qt5" "CONFIG+=console"  "CONFIG+=speexdsp" "CONFIG+=pulseaudio" "CONFIG+=sound" ];

  postUnpack = ''
     substituteInPlace "$sourceRoot/dream.pro" \
       --replace "target.path = /usr/bin" "target.path = $out/bin" \
       --replace "documentation.path = /usr/share/man/man1" "documentation.path = $out/share/man/man1"
  '';

  meta = with lib; {
    homepage = "https://sourceforge.net/projects/drm/";
    description = ''
      Dream is a software implementation of a Digital Radio Mondiale (DRM) receiver.
      This is a minimal build without GUI, suitable as DRM decoder for openwebrxplus.
   '';
    license = licenses.gpl2;
    platforms = platforms.unix;
    maintainers = [ maintainers.mafo ];
  };
}
