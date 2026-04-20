{ stdenv, cmake, pkg-config, makeWrapper, fetchFromGitHub, geant4, root, fftw }:

stdenv.mkDerivation {
  pname = "ratpac-two";
  version = "26-04";

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

  postPatch = ''
    substituteInPlace src/gen/src/VertexGen_PhotonBomb.cc --replace \
      'dformat("Using wavelength specrum:\t%d\t%s", fNumPhotons, fWavelengthIndex)' \
      'dformat("Using wavelength specrum:\t%d\t%s", fNumPhotons, fWavelengthIndex.c_str())'

    substituteInPlace src/daq/src/WaveformAnalysisLucyDDM.cc --replace \
      'std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count()' \
      'static_cast<long>(std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count())'
  '';

  postInstall = ''
    wrapProgram $out/bin/rat \
    --set RATSHARE "$out/share/RAT" \
    --set G4ENSDFSTATEDATA "$(echo ${geant4.data.G4ENSDFSTATE}/share/Geant4-*/data/G4ENSDFSTATE*)" \
    --set G4NEUTRONHPDATA "$(echo ${geant4.data.G4NDL}/share/Geant4-*/data/G4NDL*)" \
    --set G4LEDATA "$(echo ${geant4.data.G4EMLOW}/share/Geant4-*/data/G4EMLOW*)" \
    --set G4LEVELGAMMADATA "$(echo ${geant4.data.G4PhotonEvaporation}/share/Geant4-*/data/G4PhotonEvaporation*)" \
    --set G4RADIOACTIVEDATA "$(echo ${geant4.data.G4RadioactiveDecay}/share/Geant4-*/data/G4RadioactiveDecay*)" \
    --set G4PARTICLEXSDATA "$(echo ${geant4.data.G4PARTICLEXS}/share/Geant4-*/data/G4PARTICLEXS*)" \
    --set G4REALSURFACEDATA "$(echo ${geant4.data.G4RealSurface}/share/Geant4-*/data/G4RealSurface*)" \
    --set G4SAIDXSDATA "$(echo ${geant4.data.G4SAIDDATA}/share/Geant4-*/data/G4SAIDDATA*)"
  '';
  
  meta = {
    description = "Simulation and analysis package built on GEANT4 and ROOT";
    homepage = "https://github.com/rat-pac/ratpac-two";
    mainProgram = "rat";
  };
}
