{ stdenv, cmake, pkg-config, fetchFromGitHub, geant4, root, fftw }:

stdenv.mkDerivation {
  pname = "ratpac-two";
  version = "unstable-2026-04-15";

  src = fetchFromGitHub {
    owner = "rat-pac";
    repo = "ratpac-two";
    rev = "a74eed67ad6f611e4fc0faa002aed64c08a48153";
    hash = "sha256-v3RvGkVeLqX/zGvuCXMtIROK6iUNGHVGRk0fpSj+LPQ=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ geant4 root fftw ];

  meta = {
    description = "Simulation and analysis package built on GEANT4 and ROOT";
    homepage = "https://github.com/rat-pac/ratpac-two";
  };
}
