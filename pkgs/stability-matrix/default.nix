{ appimageTools, lib, fetchzip, makeWrapper, dotnet-runtime_7, }:
let
  pname = "StabilityMatrix";

  version = "2.10.2";

  srcZipped = fetchzip {
    url =
      "https://github.com/LykosAI/${pname}/releases/download/v${version}/${pname}-linux-x64.zip";
    hash = "sha256-gFdiuamvrHVq19Y/ChNOBrb+AD668LcBfNnyyVnHubo=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname;
    name = "${pname}";
    src = "${srcZipped}/${pname}.AppImage";
  };

  meta = {
    description =
      "Multi-Platform Package Manager and Inference UI for Stable Diffusion";
    homepage = "https://github.com/LykosAI/StabilityMatrix";
    license = lib.licenses.gpl3Only;
    mainProgram = "Stability Matrix";
    maintainers = with lib.maintainers; [ NotAShelf ];
    platforms = [ "x86_64-linux" ];
  };

in appimageTools.wrapType2 rec {
  inherit pname version meta;

  src = "${srcZipped}/${pname}.AppImage";

  extraPkgs = pkgs:
    (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs) ++ [ dotnet-runtime_7 ];
  extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/zone.lykos.stabilitymatrix.desktop -t $out/share/applications/${pname}.desktop

    source "${makeWrapper}/nix-support/setup-hook"
    makeWrapper $out/bin/${pname}-${version} $out/bin/${pname} \
      --unset APPIMAGE \
      --unset APPDIR
  '';
}
