{ stdenv, lib, buildPythonPackage, buildPythonApplication, fetchFromGitHub
, pkg-config, cmake, setuptools
, libsamplerate, fftwFloat
, rtl-sdr, soapysdr-with-plugins, csdr-lu, csdreti, pycsdr-lu, pycsdreti, pydigiham, direwolf, sox, wsjtx, codecserver
, paho-mqtt
}:

let

  js8py = buildPythonPackage rec {
    pname = "js8py";
    version = "0.1.1";

    src = fetchFromGitHub {
      owner = "jketterl";
      repo = pname;
      rev = version;
      sha256 = "1j80zclg1cl5clqd00qqa16prz7cyc32bvxqz2mh540cirygq24w";
    };

    pythonImportsCheck = [ "js8py" "test" ];

    meta = with lib; {
      homepage = "https://github.com/jketterl/js8py";
      description = "A library to decode the output of the js8 binary of JS8Call";
      license = licenses.gpl3Only;
      maintainers = teams.c3d2.members;
    };
  };

  owrx_connector = stdenv.mkDerivation rec {
    pname = "owrx_connector";
    version = "0.6.5";

    src = fetchFromGitHub {
      owner = "luarvique";
      repo = pname;
      rev = "870285269143048f850151346980942a12ccf24b";
      sha256 = "sha256-e0VEv9t4gVDxJEbDJm1aKSJeqlmhT/QimC3x4JJ6ke8=";
    };

    nativeBuildInputs = [
      cmake
      pkg-config
    ];

    buildInputs = [
      libsamplerate fftwFloat
      csdr-lu
      rtl-sdr
      soapysdr-with-plugins
    ];

    meta = with lib; {
      homepage = "https://github.com/jketterl/owrx_connector";
      description = "A set of connectors that are used by OpenWebRX to interface with SDR hardware";
      license = licenses.gpl3Only;
      platforms = platforms.unix;
      maintainers = teams.c3d2.members;
    };
  };

in
buildPythonApplication rec {
  pname = "openwebrx";
  version = "1.2.62";

  src = fetchFromGitHub {
    owner = "luarvique";
    repo = "openwebrx";
    rev = "38f2d4a953b4bfce84abcfb2508fabf9c5616cbe";
    hash = "sha256-A2gkc3t4nswlcp7BK1fHrGHHmbCADJ5voRwyw1HTLTQ=";
  };

  patches = [ ./useMagicKey.patch ];

  propagatedBuildInputs = [
    setuptools
    csdr-lu
    csdreti
    pycsdr-lu
    pycsdreti
    pydigiham
    js8py
    soapysdr-with-plugins
    owrx_connector
    direwolf
    sox
    wsjtx
    codecserver
    paho-mqtt
  ];

  pythonImportsCheck = [ "csdr" "owrx" "test" ];

  passthru = {
    inherit js8py owrx_connector;
  };

  meta = with lib; {
    homepage = "https://github.com/jketterl/openwebrx";
    description = "A simple DSP library and command-line tool for Software Defined Radio";
    mainProgram = "openwebrx";
    license = licenses.gpl3Only;
    maintainers = teams.c3d2.members;
  };
}
