{ appimageTools, lib, fetchzip, makeWrapper, }:
let
  pname = "StabilityMatrix";

  version = "2.10.2";

  srcZipped = fetchzip {
    url =
      "https://github.com/LykosAI/${pname}/releases/download/v${version}/${pname}-linux-x64.zip";
    hash = "sha256-gFdiuamvrHVq19Y/ChNOBrb+AD668LcBfNnyyVnHubo=";
  };

  appimageContents = appimageTools.extractType2 {
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

  libs = [ ];
in appimageTools.wrapType2 rec {
  inherit pname version appimageContents meta;

  src = "${srcZipped}/${pname}.AppImage";
  multiPkgs = null;
  extraPkgs = p: (appimageTools.defaultFhsEnvArgs.multiPkgs p) ++ libs;
  extraInstallCommands = ''
    touch /tmp/hi
    #makeWrapper $out/bin/${pname}-${version} $out/bin/${pname} \
    #  --unset APPIMAGE \
    #  --unset APPDIR
  '';

}
