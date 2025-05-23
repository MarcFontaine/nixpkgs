{
  lib,
  SDL2,
  autoreconfHook,
  darwin,
  fetchurl,
  giflib,
  libXpm,
  libjpeg,
  libpng,
  libtiff,
  libwebp,
  pkg-config,
  stdenv,
  zlib,
  # Boolean flags
  enableSTB ? true,
  ## Darwin headless will hang when trying to run the SDL test program
  enableSdltest ? (!stdenv.hostPlatform.isDarwin),
}:

let
  inherit (darwin.apple_sdk.frameworks) Foundation;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "SDL2_image";
  version = "2.8.5";

  src = fetchurl {
    url = "https://www.libsdl.org/projects/SDL_image/release/SDL2_image-${finalAttrs.version}.tar.gz";
    hash = "sha256-i8TFf0HiwNt/m3SbJT72zs3G8LaJ7L427pe1ARX/9kU=";
  };

  nativeBuildInputs = [
    SDL2
    autoreconfHook
    pkg-config
  ];

  buildInputs =
    [
      SDL2
      libtiff
      libwebp
      zlib
    ]
    ++ lib.optionals (!enableSTB) [
      libjpeg
      libpng
    ];

  configureFlags =
    [
      # Disable dynamically loaded dependencies
      (lib.enableFeature false "jpg-shared")
      (lib.enableFeature false "png-shared")
      (lib.enableFeature false "tif-shared")
      (lib.enableFeature false "webp-shared")
      (lib.enableFeature enableSTB "stb-image")
      (lib.enableFeature enableSdltest "sdltest")
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      # Don't use native macOS frameworks
      # Caution: do not set this as (!stdenv.hostPlatform.isDarwin) since it would be true
      # outside Darwin - and ImageIO does not exist outside Darwin
      (lib.enableFeature false "imageio")
    ];

  strictDeps = true;

  enableParallelBuilding = true;

  meta = {
    description = "SDL image library";
    homepage = "https://github.com/libsdl-org/SDL_image";
    license = lib.licenses.zlib;
    maintainers = lib.teams.sdl.members ++ (with lib.maintainers; [ ]);
    platforms = lib.platforms.unix;
  };
})
