{ stdenv, lib, fetchFromGitHub, cmake
}:
stdenv.mkDerivation rec {
  pname = "libacars";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "szpajder";
    repo = "libacars";
    rev = "v${version}";
    hash = "sha256-2n1tuKti8Zn5UzQHmRdvW5Q+x4CXS9QuPHFQ+DFriiE=";
  };

  nativeBuildInputs = [
    cmake
  ];

  postPatch = ''
    substituteInPlace "libacars/libacars.pc.in" \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR&
  '';

  meta = with lib; {
    homepage = "https://github.com/szpajder/libacars";
    description = ''
      libacars is a library for decoding ACARS message contents.
    '';
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.mafo ];
  };
}
