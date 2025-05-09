{
  lib,
  stdenv,
  fetchFromGitHub,
  openssl,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xilinx-bootgen";
  version = "xilinx_v2024.2";

  src = fetchFromGitHub {
    owner = "xilinx";
    repo = "bootgen";
    rev = finalAttrs.version;
    hash = "sha256-t165nTG4IkI3WrcS3ZryINmAOVzfctxg5zY3oqmNtLw=";
  };

  buildInputs = [ openssl ];

  enableParallelBuilding = true;

  installPhase = ''
    install -Dm755 bootgen $out/bin/bootgen
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Generate Boot Images for Xilinx Zynq and ZU+ SoCs";
    longDescription = ''
      Bootgen for Xilinx Zynq and ZU+ SoCs, without code related to generating
      obfuscated key and without code to support FPGA encryption and
      authentication. These features are only available as part of Bootgen
      shipped with Vivado tools.

      For more details about Bootgen, please refer to Xilinx UG1283.
    '';
    homepage = "https://github.com/Xilinx/bootgen";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux;
    maintainers = [
      lib.maintainers.flokli
      lib.maintainers.jmbaur
    ];
    mainProgram = "bootgen";
  };
})
