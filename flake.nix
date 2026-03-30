{
  description = "Nix flake for CLAP";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      packages.${system}.default = pkgs.python3Packages.buildPythonPackage {
        pname = "CLAP";
        version = "0.1.0";
        format = "pyproject";
        src = ./.;
        build-system = [ pkgs.python3Packages.setuptools ];
        dependencies = with pkgs.python3Packages; [ torch torchaudio transformers numpy soundfile librosa torchlibrosa ftfy webdataset wandb scipy scikit-learn pandas h5py tqdm regex torchvision wget progressbar ];
        
        pythonRelaxDeps = true;
        doCheck = false;
      };
    };
}
