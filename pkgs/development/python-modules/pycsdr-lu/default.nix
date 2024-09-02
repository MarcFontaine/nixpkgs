{ lib, buildPythonPackage, fetchFromGitHub, csdr-lu }:

buildPythonPackage rec {
  pname = "pycsdr";

  version = "0.18.26-lu";
  src = fetchFromGitHub {
    owner = "luarvique";
    repo = "pycsdr";
    rev = "92efaca4aaf1a8630fb10cd1936c0eb320336b18";
    hash = "sha256-jNs5Eb3myKOEGD4hYnR8+DEwNXKCFjFmLJDq6qXsUuc=";
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
