{ ... } : {
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name  = "Paul Pexe";
        email = "paul-pexe@proton.me";
      };
      init.defaultBranch = "main";
    };
  };
}