{ pkgs }:

rec {
  check-added-large-files.enable = true;
  check-merge-conflicts.enable = true;
  detect-private-keys.enable = true;
  end-of-file-fixer.enable = true;
  forbid-new-submodules.enable = true;
  no-commit-to-branch.enable = true;
  trim-trailing-whitespace.enable = true;
  codespell = {
    enable = true;
    name = "codespell";
    description = "Checks for common misspellings in text files.";
    package = pkgs.codespell;
    entry = "${codespell.package}/bin/codespell";
    types = [ "text" ];
  };
  gitleaks = {
    enable = true;
    name = "Detect hardcoded secrets";
    description = "Detect hardcoded secrets using Gitleaks";
    package = pkgs.gitleaks;
    entry = "${gitleaks.package}/bin/gitleaks protect --verbose --redact --staged";
    pass_filenames = false;
  };
}
