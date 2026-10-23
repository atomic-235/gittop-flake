{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  data = builtins.fromJSON (builtins.readFile ./version.json);
  system = stdenvNoCC.hostPlatform.system;

  arch =
    {
      x86_64-linux = "amd64";
      aarch64-linux = "arm64";
    }
    .${system} or (throw "gittop: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "gittop";
  version = data.version;

  src = fetchurl {
    url = "https://github.com/hjr265/gittop/releases/download/v${data.version}/gittop_${data.version}_linux_${arch}.tar.gz";
    hash = data.assets.${system};
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 gittop "$out/bin/gittop"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Interactive Git repository browser";
    homepage = "https://github.com/hjr265/gittop";
    license = licenses.mit;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    mainProgram = "gittop";
  };
}
