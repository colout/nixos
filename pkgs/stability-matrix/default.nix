# to update deps, run:
# nix-build -A passthru.fetch-deps ./pkgs/stability-matrix
# ... then run the resulting script in the output
# 
# might need to bump the sdk number to match nuget?

{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; },
fetchFromGitHub ? pkgs.fetchFromGitHub,
buildDotnetModule ? pkgs.buildDotnetModule,
dotnetCorePackages ? pkgs.dotnetCorePackages,
ffmpeg ? pkgs.ffmpeg, 
}:

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


  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  runtimeDeps =
    [ ffmpeg ]; # This will wrap ffmpeg's library path into `LD_LIBRARY_PATH`.
}
