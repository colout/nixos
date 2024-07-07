# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs}: {
  ue5_4_2 = pkgs.callPackage ./ue5_4_2 {};
}
