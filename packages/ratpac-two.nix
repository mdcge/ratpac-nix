{ stdenv, cmake, pkg-config, fetchFromGitHub, geant4, root, fftw }:

let
  geant4-vis = geant4.override {
    enableQt = true;
    enableOpenGLX11 = true;
  };

in

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
  buildInputs = [ geant4-vis
                  geant4-vis.data.G4ENSDFSTATE
                  geant4-vis.data.G4NDL
                  geant4-vis.data.G4EMLOW
                  geant4-vis.data.G4PhotonEvaporation
                  geant4-vis.data.G4RadioactiveDecay
                  geant4-vis.data.G4PARTICLEXS
                  geant4-vis.data.G4RealSurface
                  geant4-vis.data.G4SAIDDATA
                  root
                  fftw
                ];

  setupHook = ./ratpac-setup-hook.sh;
  
  meta = {
    description = "Simulation and analysis package built on GEANT4 and ROOT";
    homepage = "https://github.com/rat-pac/ratpac-two";
  };
}
