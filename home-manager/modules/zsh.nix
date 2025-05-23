{...}: {
  programs.zsh = {
    enable = true;
    initExtra = "source ~/git/dotfiles/.zplugrc.sh";
    shellAliases = {
      ll = "ls -l";

      # NixOS command shortcuts
      napply = "sudo chown -R $USER /etc/nixos; cd /etc/nixos && git -C /etc/nixos add . && git -C /etc/nixos commit -m 'change' || sudo nixos-rebuild switch --flake /etc/nixos";
      nupdate = "cd /etc/nixos; sudo nix flake update";
      nedit = "cd /etc/nixos; nvim";
      ngarbage-collect = "nix-collect-garbage -d";
    };
  };
}
