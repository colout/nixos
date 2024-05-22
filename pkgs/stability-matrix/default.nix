{ fetchFromGitHub, buildDotnetModule, dotnetCorePackages, ffmpeg, }:
# with import <nixpkgs> { };

buildDotnetModule rec {
  pname = "stability-matrix";
  version = "2.10.3";

  src = fetchFromGitHub {
    owner = "LykosAI";
    repo = "StabilityMatrix";
    rev = "v${version}";
    hash = "sha256-+C+gFXNFcLg7lXj4S/qnwGoLn8Z8HFbiaEGIDyBpjBY=";
  };

  projectFile = "StabilityMatrix.sln";
  nugetDeps = ./deps.nix;

  dotnet-sdk = dotnetCorePackages.sdk_7_0;
  dotnet-runtime = dotnetCorePackages.runtime_7_0;

  runtimeDeps =
    [ ffmpeg ]; # This will wrap ffmpeg's library path into `LD_LIBRARY_PATH`.
}
