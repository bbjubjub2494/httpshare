{ mkShell, python3, bats, curl }:

mkShell {
  buildInputs = [ python3 bats curl ];
}
