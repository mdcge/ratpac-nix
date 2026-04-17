{ stdenv, cmake, pkg-config, makeWrapper, fetchFromGitHub, geant4, root, fftw }:

stdenv.mkDerivation {
  pname = "ratpac-two";
  version = "unstable-2026-04-15";

  src = fetchFromGitHub {
    owner = "rat-pac";
    repo = "ratpac-two";
    rev = "a74eed67ad6f611e4fc0faa002aed64c08a48153";
    hash = "sha256-v3RvGkVeLqX/zGvuCXMtIROK6iUNGHVGRk0fpSj+LPQ=";
  };

  nativeBuildInputs = [ cmake pkg-config makeWrapper ];
  buildInputs = [ geant4
                  geant4.data.G4ENSDFSTATE
                  geant4.data.G4NDL
                  geant4.data.G4EMLOW
                  geant4.data.G4PhotonEvaporation
                  geant4.data.G4RadioactiveDecay
                  geant4.data.G4PARTICLEXS
                  geant4.data.G4RealSurface
                  geant4.data.G4SAIDDATA
                  root
                  fftw
                ];

  setupHook = ./ratpac-setup-hook.sh;
  
  meta = {
    description = "Simulation and analysis package built on GEANT4 and ROOT";
    homepage = "https://github.com/rat-pac/ratpac-two";
  };
}
