{ fetchFromGitHub, buildDotnetModule, dotnetCorePackages, ffmpeg }:

let
  referencedProject = import ../../bar { # ...
  };
in buildDotnetModule rec {
  pname = "stability-matrix";
  version = "2.10.2";

  src = fetchFromGitHub {
    owner = "LykosAI";
    repo = "StabilityMatrix";
    rev = "v${version}";
    hash = "sha256-5gpwB4x2/JAaNtPQrlgFwh7om3rTJE0/mGr/Kn4qIIw=";
  };

  projectFile = "src/project.sln";
  # File generated with `nix-build -A package.passthru.fetch-deps`.
  # To run fetch-deps when this file does not yet exist, set nugetDeps to null
  nugetDeps = ./deps.nix;

  projectReferences = [
    referencedProject
  ]; # `referencedProject` must contain `nupkg` in the folder structure.

  dotnet-sdk = dotnetCorePackages.sdk_6_0;
  dotnet-runtime = dotnetCorePackages.runtime_6_0;

  executables = [ "foo" ]; # This wraps "$out/lib/$pname/foo" to `$out/bin/foo`.

  packNupkg = true; # This packs the project as "foo-0.1.nupkg" at `$out/share`.

  runtimeDeps =
    [ ffmpeg ]; # This will wrap ffmpeg's library path into `LD_LIBRARY_PATH`.
}
