{ appimageTools, lib, fetchzip, makeWrapper, }:
let
  pname = "StabilityMatrix";

  version = "2.10.2";

  src = fetchzip {
    url =
      "https://github.com/LykosAI/${pname}/releases/download/v${version}/${pname}-linux-x64.zip";
    hash = "sha256-gFdiuamvrHVq19Y/ChNOBrb+AD668LcBfNnyyVnHubo=";
    name = "${pname}.appimage";
  };

  appimageContents = appimageTools.extractType2 {
    name = "${pname}.appimage";
    inherit src;
  };

  libs = [ ];
in appimageTools.wrapType2 {
  inherit pname version src;
  multiPkgs = null; # no 32bit needed
  extraPkgs = p: (appimageTools.defaultFhsEnvArgs.multiPkgs p) ++ libs;
  extraInstallCommands = ''
    touch /tmp/hi
    #install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    #cp -r ${appimageContents}/usr/share/icons $out/share
    #source "${makeWrapper}/nix-support/setup-hook" # cringe hack to get wrapProgram working in extraInstallCommands
    #makeWrapper $out/bin/${pname}-${version} $out/bin/${pname} \
    #  --unset APPIMAGE \
    #  --unset APPDIR
  '';

  meta = {
    description =
      "Multi-Platform Package Manager and Inference UI for Stable Diffusion";
    homepage = "https://github.com/LykosAI/StabilityMatrix";
    license = lib.licenses.gpl3Only;
    mainProgram = "Stability Matrix";
    maintainers = with lib.maintainers; [ NotAShelf ];
    platforms = [ "x86_64-linux" ];
  };
}
