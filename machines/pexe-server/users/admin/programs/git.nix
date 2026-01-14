{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "PEXE";
    userEmail = "paul-pexe@proton.me";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
