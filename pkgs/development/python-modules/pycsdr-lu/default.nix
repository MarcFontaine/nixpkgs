{ lib, buildPythonPackage, fetchFromGitHub, csdr-lu }:

buildPythonPackage rec {
  pname = "pycsdr";

  version = "0.18.23-lu";
  src = fetchFromGitHub {
    owner = "luarvique";
    repo = "pycsdr";
    rev = "922ea1b2100e00b21ab5ee09d9c8d90c4e4f473e";
    hash = "sha256-NjRBC7bhq2bMlRI0Q8bcGcneD/HlAO6l/0As3/lk4e8=";
  };

  propagatedBuildInputs = [ csdr-lu ];

  # has no tests
  doCheck = false;
  pythonImportsCheck = [ "pycsdr" ];

  meta = {
    homepage = "https://github.com/jketterl/pycsdr";
    description = "bindings for the csdr library";
    license = lib.licenses.gpl3Only;
    maintainers = lib.teams.c3d2.members;
  };
}
