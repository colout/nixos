{ ... }:

{
  programs.nixvim = {
    extraConfigVim = 
      ''
        if !isdirectory($HOME."/.vim")
            call mkdir($HOME."/.vim", "", 0770)
        endif
        if !isdirectory($HOME."/.vim/undo-dir")
            call mkdir($HOME."/.vim/undo-dir", "", 0700)
        endif

        set undodir=~/.vim/undo-dir
        set undofile
      '';
    options = {
      undofile = true;
      hidden = true; # can navegete away from file and save in buffer
    };
  };
}
