{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  name = "i2c-ch341-usb-${version}-${kernel.version}";
  version = "git";

  src = fetchFromGitHub {
    owner = "MarcFontaine";
    repo = "i2c-ch341-usb";
    rev = "faa8a2666f102d03d717cdf4071ea93595b6e96d";
    sha256 = "sha256-kkFvQEJBexa6A9/S5Vh9S3yj+GONYzqdxKIwRiVPFBY=";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    mkdir -p $out
    mv i2c-ch341-usb.ko $out/
  '';

  meta = with lib; {
    description = "A CH341A USB to I2C and GPIO Linux kernel driver";
    homepage = "https://github.com/gschorcht/i2c-ch341-usb";
    license = licenses.gpl2;
    maintainers = [ maintainers.mafo ];
    platforms = platforms.linux;
  };
}
