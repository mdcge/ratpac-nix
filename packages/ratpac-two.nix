{ stdenv, cmake, fetchFromGitHub, geant4, root }:

stdenv.mkDerivation {
  pname = "ratpac-two";
  version = "unstable-2024";  # pin to a specific commit later

  src = fetchFromGitHub {
    owner = "rat-pac";
    repo = "ratpac-two";
    rev = "main";  # replace with a specific commit hash
    hash = "";     # nix will tell you the correct hash on first attempt
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ geant4 root ];

  meta = {
    description = "Simulation and analysis package built on GEANT4 and ROOT";
    homepage = "https://github.com/rat-pac/ratpac-two";
  };
}
