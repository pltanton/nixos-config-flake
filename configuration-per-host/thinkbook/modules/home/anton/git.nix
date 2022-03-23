{ pkgs, secrets, ... }: {
  programs.git = {
    userEmail = "antplotnikov@ozon.ru";

    signing = {
      key = "E49A7BC8572859AB9609F6E9311C09268E05E376";
      signByDefault = true;
    };
  };
}
