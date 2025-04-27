{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  udev,
  libusb1,
}:
let
  arch =
    if stdenv.hostPlatform.isx86_64 then
      "amd64"
    else if stdenv.hostPlatform.isi686 then
      "i686"
    else if stdenv.hostPlatform.isAarch64 then
      "aarch64"
    else
      throw "unsupported architecture";
in
stdenv.mkDerivation rec {
  pname = "sdrplay";
  version = "3.15.2";

  src = fetchurl {
    url = "https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-${version}.run";
    sha256 = "sha256-OpfKdkJju+dvsPIiDmQIlCNX6IZMGeFAim1ph684L+M=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    libusb1
    udev
    (lib.getLib stdenv.cc.cc)
  ];

  unpackPhase = ''
    sh "$src" --noexec --target source
  '';

  sourceRoot = "source";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/{bin,lib,include}
    majorVersion="${lib.concatStringsSep "." (lib.take 1 (builtins.splitVersion version))}"
    majorMinorVersion="${lib.concatStringsSep "." (lib.take 2 (builtins.splitVersion version))}"
    libName="libsdrplay_api"
    cp "${arch}/$libName.so.$majorMinorVersion" $out/lib/
    ln -s "$out/lib/$libName.so.$majorMinorVersion" "$out/lib/$libName.so.$majorVersion"
    ln -s "$out/lib/$libName.so.$majorVersion" "$out/lib/$libName.so"
    cp "${arch}/sdrplay_apiService" $out/bin/
    cp -r inc/* $out/include/
  '';

  meta = with lib; {
    description = "SDRplay API";
    longDescription = ''
      Proprietary library and api service for working with SDRplay devices. For documentation and licensing details see
      https://www.sdrplay.com/docs/SDRplay_API_Specification_v${lib.concatStringsSep "." (lib.take 2 (builtins.splitVersion version))}.pdf
    '';
    homepage = "https://www.sdrplay.com/downloads/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    maintainers = with maintainers; [
      pmenke
      zaninime
    ];
    platforms = platforms.linux;
    mainProgram = "sdrplay_apiService";
  };
}
