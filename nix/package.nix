{ stdenv, lib, python, python3, ensureNewerSourcesForZipFilesHook, makeWrapper, bats, curl }:

stdenv.mkDerivation {
  pname = "httpshare";

  version = with builtins; with fromJSON (readFile ../src/httpshare/version.json);
    "${toString major}.${toString minor}.${toString patch}"
    + (if suffix != "" then "-${suffix}" else "");

  src = builtins.path { path = ../.; name = "source"; };

  doCheck = true;

  buildInputs = [ ensureNewerSourcesForZipFilesHook makeWrapper ];
  checkInputs = [ python bats curl ];

  buildPhase = ''
    ${python3}/bin/python make_zipapp.py
  '';

  checkPhase = ''
    env MODE=release bats test.bats
  '';

  installPhase = ''
    mkdir -p $out/{bin,share}
    cp httpshare.pyz $out/share
    makeWrapper ${python}/bin/python $out/bin/httpshare --add-flags $out/share/httpshare.pyz
  '';

  meta = with lib; {
    description = "A file transfer utility using an ephemeral HTTP service";
    license = licenses.zlib;
    homepage = "https://github.com/bbjubjub2494/httpshare";
    maintainers = maintainers.bbjubjub2494;
  };
}
