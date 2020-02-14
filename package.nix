{ pkgs }:
let
  pyz = pkgs.callPackage ({ bats, curl, git, stdenv, python3, ensureNewerSourcesForZipFilesHook }:
    stdenv.mkDerivation {
      name = "httpshare.pyz";
      src = ./.;

      buildInputs = [python3 ensureNewerSourcesForZipFilesHook];

      dontPatchShebangs = true;  # Keep the portable shebang.

      buildPhase = ''
        ${python3}/bin/python make_zipapp.py
      '';

      checkInputs = [bats curl git];
      doCheck = true;

      checkPhase = ''
        # test.bats call make_zipapp.py, which we don't want.
        echo "#!/bin/sh" >make_zipapp.py
        env MODE=release bats test.bats
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
