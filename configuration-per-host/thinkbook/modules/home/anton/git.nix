{ pkgs, secrets, ... }: {
  programs.git = {
    userEmail = "antplotnikov@ozon.ru";

    signing = {
     key = "C5E9ED0B49F6532A3551DF0585ABC45A273326BD";
     signByDefault = true;
    };
  };
}
