{ pkgs }:
let
  pyz = pkgs.callPackage ({ stdenv, bats, python3, ensureNewerSourcesForZipFilesHook }:
    stdenv.mkDerivation {
      name = "httpshare.pyz";
      src = ./.;

      buildInputs = [bats python3 ensureNewerSourcesForZipFilesHook];

      dontPatchShebangs = true;  # Keep the portable shebang.

      buildPhase = ''
        ${python3}/bin/python make_zipapp.py
      '';

      installPhase = ''
        cp httpshare.pyz $out
      '';
    }) {};
in
pkgs.callPackage ({ stdenv, python, makeWrapper }:
  stdenv.mkDerivation {
    name = "httpshare";
    inherit pyz;

    meta = with stdenv.lib; {
      description = "A file transfer utility using an ephemeral HTTP service";
      license = licenses.zlib;
      homepage = https://github.com/bbjubjub2494/httpshare;
      maintainers = [{
        name = "Julie Bettens";
        email = "julie@bettens.info";
        github = "bbjubjub2494";
      }];
    };

    buildInputs = [python makeWrapper];

    phases = "installPhase";
    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${python}/bin/python $out/bin/httpshare --add-flags $pyz
    '';
  }) {}
